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
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';


class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final PostRepository _postRepository;
  StreamSubscription _postsListSubscription;
  final AccessBloc accessBloc;
  final EliudQuery eliudQuery;


  PostListBloc(this.accessBloc,{ this.eliudQuery, @required PostRepository postRepository })
      : assert(postRepository != null),
      _postRepository = postRepository,
      super(PostListLoading());
  String _currentMember() {
    var _currentMember = '';
    var state = accessBloc.state;
    if (state is LoggedIn) _currentMember = state.member.documentID;
    return _currentMember;
  }

  Stream<PostListState> _mapLoadPostListToState({ String orderBy, bool descending }) async* {
    _postsListSubscription?.cancel();
    _postsListSubscription = _postRepository.listen((list) => add(PostListUpdated(value: list)), orderBy: orderBy, descending: descending, eliudQuery: eliudQuery, currentMember: _currentMember(), );
  }

  Stream<PostListState> _mapLoadPostListWithDetailsToState({ String orderBy, bool descending }) async* {
    _postsListSubscription?.cancel();
    _postsListSubscription = _postRepository.listenWithDetails((list) => add(PostListUpdated(value: list)), orderBy: orderBy, descending: descending, eliudQuery: eliudQuery, currentMember: _currentMember(), );
  }

  Stream<PostListState> _mapAddPostListToState(AddPostList event) async* {
    _postRepository.add(event.value);
  }

  Stream<PostListState> _mapUpdatePostListToState(UpdatePostList event) async* {
    _postRepository.update(event.value);
  }

  Stream<PostListState> _mapDeletePostListToState(DeletePostList event) async* {
    _postRepository.delete(event.value);
  }

  Stream<PostListState> _mapPostListUpdatedToState(PostListUpdated event) async* {
    yield PostListLoaded(values: event.value);
  }


  @override
  Stream<PostListState> mapEventToState(PostListEvent event) async* {
    final currentState = state;
    if (event is LoadPostList) {
      yield* _mapLoadPostListToState(orderBy: event.orderBy, descending: event.descending);
    } if (event is LoadPostListWithDetails) {
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


