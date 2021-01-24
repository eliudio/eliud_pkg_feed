/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/post_comment_repository.dart';
import 'package:eliud_pkg_feed/model/post_comment_list_event.dart';
import 'package:eliud_pkg_feed/model/post_comment_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _postCommentLimit = 5;

class PostCommentListBloc extends Bloc<PostCommentListEvent, PostCommentListState> {
  final PostCommentRepository _postCommentRepository;
  StreamSubscription _postCommentsListSubscription;
  final EliudQuery eliudQuery;
  int pages = 1;
  final bool paged;
  final String orderBy;
  final bool descending;
  final bool detailed;

  PostCommentListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, @required PostCommentRepository postCommentRepository})
      : assert(postCommentRepository != null),
        _postCommentRepository = postCommentRepository,
        super(PostCommentListLoading());

  Stream<PostCommentListState> _mapLoadPostCommentListToState() async* {
    int amountNow =  (state is PostCommentListLoaded) ? (state as PostCommentListLoaded).values.length : 0;
    _postCommentsListSubscription?.cancel();
    _postCommentsListSubscription = _postCommentRepository.listen(
          (list) => add(PostCommentListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && (paged)) ? pages * _postCommentLimit : null
    );
  }

  Stream<PostCommentListState> _mapLoadPostCommentListWithDetailsToState() async* {
    int amountNow =  (state is PostCommentListLoaded) ? (state as PostCommentListLoaded).values.length : 0;
    _postCommentsListSubscription?.cancel();
    _postCommentsListSubscription = _postCommentRepository.listenWithDetails(
            (list) => add(PostCommentListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && (paged)) ? pages * _postCommentLimit : null
    );
  }

  Stream<PostCommentListState> _mapAddPostCommentListToState(AddPostCommentList event) async* {
    _postCommentRepository.add(event.value);
  }

  Stream<PostCommentListState> _mapUpdatePostCommentListToState(UpdatePostCommentList event) async* {
    _postCommentRepository.update(event.value);
  }

  Stream<PostCommentListState> _mapDeletePostCommentListToState(DeletePostCommentList event) async* {
    _postCommentRepository.delete(event.value);
  }

  Stream<PostCommentListState> _mapPostCommentListUpdatedToState(
      PostCommentListUpdated event) async* {
    yield PostCommentListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<PostCommentListState> mapEventToState(PostCommentListEvent event) async* {
    if (event is LoadPostCommentList) {
      if ((detailed == null) || (!detailed)) {
        yield* _mapLoadPostCommentListToState();
      } else {
        yield* _mapLoadPostCommentListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadPostCommentListWithDetailsToState();
    } else if (event is AddPostCommentList) {
      yield* _mapAddPostCommentListToState(event);
    } else if (event is UpdatePostCommentList) {
      yield* _mapUpdatePostCommentListToState(event);
    } else if (event is DeletePostCommentList) {
      yield* _mapDeletePostCommentListToState(event);
    } else if (event is PostCommentListUpdated) {
      yield* _mapPostCommentListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _postCommentsListSubscription?.cancel();
    return super.close();
  }
}


