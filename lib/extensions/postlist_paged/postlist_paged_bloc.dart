import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_post/model/post_model.dart';
import 'package:eliud_pkg_post/model/post_repository.dart';
import 'package:meta/meta.dart';

const _postLimit = 5;

class PostListPagedBloc extends Bloc<PostPagedEvent, PostListPagedState> {
  final PostRepository _postRepository;
  Object? lastRowFetched;
  EliudQuery eliudQuery;

  PostListPagedBloc(this.eliudQuery, { required PostRepository postRepository }) :
       assert(postRepository != null),
      _postRepository = postRepository,
        super(const PostListPagedState());

  @override
  Stream<Transition<PostPagedEvent, PostListPagedState>> transformEvents(
    Stream<PostPagedEvent> events,
    TransitionFunction<PostPagedEvent, PostListPagedState> transitionFn,
  ) {
    return super.transformEvents(
      events,
      transitionFn,
    );
  }

  @override
  Stream<PostListPagedState> mapEventToState(PostPagedEvent event) async* {
    if (event is PostListPagedFetched) {
      var value = await _mapPostFetchedToState(state);
      if (value != null)
        yield value;
    } else if (event is AddPostPaged) {

    } else if (event is DeletePostPaged) {
      await _mapDeletePost(event);
      // wetodo  might require to copy this in a new list, not sure
      var newListOfValues = state.values.map((v) => v).toList();
      newListOfValues.remove(event.value);
      final extraValues = await _fetchPosts(lastRowFetched: state.lastRowFetched, limit: 1);
      if (extraValues != null) {
        var newState = extraValues.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
          status: PostListPagedStatus.success,
          values: List.of(newListOfValues)
            ..addAll(extraValues),
          lastRowFetched: lastRowFetched,
          hasReachedMax: _hasReachedMax(
              newListOfValues.length + extraValues.length),
        );
        yield newState;
      }
    }
  }

  Future<void> _mapDeletePost(DeletePostPaged event) async {
    await _postRepository.update(event.value!.copyWith(archived: PostArchiveStatus.Archived));
  }

  Future<PostListPagedState?> _mapPostFetchedToState(PostListPagedState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == PostListPagedStatus.initial) {
        final values = await _fetchPosts(limit: 5);
        if (values != null) {
          return state.copyWith(
            status: PostListPagedStatus.success,
            values: values,
            lastRowFetched: lastRowFetched,
            hasReachedMax: _hasReachedMax(values.length),
          );
        }
      } else {
        final values = await _fetchPosts(lastRowFetched: state.lastRowFetched, limit: 5);
        return values == null || values.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
          status: PostListPagedStatus.success,
          values: List.of(state.values)
            ..addAll(values),
          lastRowFetched: lastRowFetched,
          hasReachedMax: _hasReachedMax(values.length),
        );
      }
    } on Exception {
      return state.copyWith(status: PostListPagedStatus.failure);
    }
  }

  Future<List<PostModel?>?> _fetchPosts({Object? lastRowFetched, int? limit}) async {
    try {
      return _postRepository.valuesListWithDetails(orderBy: 'timestamp', descending: true, eliudQuery: eliudQuery, setLastDoc: _setLastRowFetched, startAfter: lastRowFetched, limit: limit);
    } catch (Exception) {
      print("Exception: " + Exception.toString());
    }
    return null;
  }

  void _setLastRowFetched(Object? o) {
    lastRowFetched = o;
  }

  bool _hasReachedMax(int postsCount) => postsCount < _postLimit ? true : false;
}
