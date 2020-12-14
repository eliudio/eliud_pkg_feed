import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_pkg_feed/extensions/bloc/post_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/bloc/post_paged_state.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

const _postLimit = 5;

class PostPagedBloc extends Bloc<PostPagedEvent, PostPagedState> {
  final PostRepository _postRepository;
  final AccessBloc accessBloc;
  Object lastRowFetched;

  PostPagedBloc(this.accessBloc,{ @required PostRepository postRepository }) :
       assert(postRepository != null),
      _postRepository = postRepository,
        super(const PostPagedState());

  @override
  Stream<Transition<PostPagedEvent, PostPagedState>> transformEvents(
    Stream<PostPagedEvent> events,
    TransitionFunction<PostPagedEvent, PostPagedState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostPagedState> mapEventToState(PostPagedEvent event) async* {
    if (event is PostPagedFetched) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<PostPagedState> _mapPostFetchedToState(PostPagedState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == PostPagedStatus.initial) {
        final values = await _fetchPosts();
        return state.copyWith(
          status: PostPagedStatus.success,
          values: values,
          lastRowFetched: lastRowFetched,
          hasReachedMax: _hasReachedMax(values.length),
        );
      } else {
        final values = await _fetchPosts(lastRowFetched: state.lastRowFetched);
        return values.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
          status: PostPagedStatus.success,
          values: List.of(state.values)
            ..addAll(values),
          lastRowFetched: lastRowFetched,
          hasReachedMax: _hasReachedMax(values.length),
        );
      }
    } on Exception {
      return state.copyWith(status: PostPagedStatus.failure);
    }
  }

  String _currentMember() {
    var _currentMember = '';
    var state = accessBloc.state;
    if (state is LoggedIn) _currentMember = state.member.documentID;
    return _currentMember;
  }

  Future<List<PostModel>> _fetchPosts({Object lastRowFetched}) async {
    String currentMember = _currentMember();
    return _postRepository.valuesList(currentMember, orderBy: 'timestamp', descending: true, limit: _postLimit, startAfter: lastRowFetched, setLastDoc: _setLastRowFetched);
  }

  void _setLastRowFetched(Object o) {
    lastRowFetched = o;
  }

  bool _hasReachedMax(int postsCount) => postsCount < _postLimit ? true : false;
}
