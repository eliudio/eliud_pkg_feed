/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/post_repository.dart';
import 'package:eliud_pkg_feed/model/post_list_event.dart';
import 'package:eliud_pkg_feed/model/post_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _postLimit = 5;

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final PostRepository _postRepository;
  StreamSubscription? _postsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;

  PostListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required PostRepository postRepository})
      : assert(postRepository != null),
        _postRepository = postRepository,
        super(PostListLoading());

  Stream<PostListState> _mapLoadPostListToState() async* {
    int amountNow =  (state is PostListLoaded) ? (state as PostListLoaded).values!.length : 0;
    _postsListSubscription?.cancel();
    _postsListSubscription = _postRepository.listen(
          (list) => add(PostListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * _postLimit : null
    );
  }

  Stream<PostListState> _mapLoadPostListWithDetailsToState() async* {
    int amountNow =  (state is PostListLoaded) ? (state as PostListLoaded).values!.length : 0;
    _postsListSubscription?.cancel();
    _postsListSubscription = _postRepository.listenWithDetails(
            (list) => add(PostListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * _postLimit : null
    );
  }

  Stream<PostListState> _mapAddPostListToState(AddPostList event) async* {
    var value = event.value;
    if (value != null) 
      _postRepository.add(value);
  }

  Stream<PostListState> _mapUpdatePostListToState(UpdatePostList event) async* {
    var value = event.value;
    if (value != null) 
      _postRepository.update(value);
  }

  Stream<PostListState> _mapDeletePostListToState(DeletePostList event) async* {
    var value = event.value;
    if (value != null) 
      _postRepository.delete(value);
  }

  Stream<PostListState> _mapPostListUpdatedToState(
      PostListUpdated event) async* {
    yield PostListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<PostListState> mapEventToState(PostListEvent event) async* {
    if (event is LoadPostList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadPostListToState();
      } else {
        yield* _mapLoadPostListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadPostListWithDetailsToState();
    } else if (event is AddPostList) {
      yield* _mapAddPostListToState(event);
    } else if (event is UpdatePostList) {
      yield* _mapUpdatePostListToState(event);
    } else if (event is DeletePostList) {
      yield* _mapDeletePostListToState(event);
    } else if (event is PostListUpdated) {
      yield* _mapPostListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _postsListSubscription?.cancel();
    return super.close();
  }
}


