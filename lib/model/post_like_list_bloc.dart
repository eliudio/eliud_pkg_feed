/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/post_like_repository.dart';
import 'package:eliud_pkg_feed/model/post_like_list_event.dart';
import 'package:eliud_pkg_feed/model/post_like_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _postLikeLimit = 5;

class PostLikeListBloc extends Bloc<PostLikeListEvent, PostLikeListState> {
  final PostLikeRepository _postLikeRepository;
  StreamSubscription? _postLikesListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;

  PostLikeListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required PostLikeRepository postLikeRepository})
      : assert(postLikeRepository != null),
        _postLikeRepository = postLikeRepository,
        super(PostLikeListLoading());

  Stream<PostLikeListState> _mapLoadPostLikeListToState() async* {
    int amountNow =  (state is PostLikeListLoaded) ? (state as PostLikeListLoaded).values!.length : 0;
    _postLikesListSubscription?.cancel();
    _postLikesListSubscription = _postLikeRepository.listen(
          (list) => add(PostLikeListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * _postLikeLimit : null
    );
  }

  Stream<PostLikeListState> _mapLoadPostLikeListWithDetailsToState() async* {
    int amountNow =  (state is PostLikeListLoaded) ? (state as PostLikeListLoaded).values!.length : 0;
    _postLikesListSubscription?.cancel();
    _postLikesListSubscription = _postLikeRepository.listenWithDetails(
            (list) => add(PostLikeListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * _postLikeLimit : null
    );
  }

  Stream<PostLikeListState> _mapAddPostLikeListToState(AddPostLikeList event) async* {
    var value = event.value;
    if (value != null) 
      _postLikeRepository.add(value);
  }

  Stream<PostLikeListState> _mapUpdatePostLikeListToState(UpdatePostLikeList event) async* {
    var value = event.value;
    if (value != null) 
      _postLikeRepository.update(value);
  }

  Stream<PostLikeListState> _mapDeletePostLikeListToState(DeletePostLikeList event) async* {
    var value = event.value;
    if (value != null) 
      _postLikeRepository.delete(value);
  }

  Stream<PostLikeListState> _mapPostLikeListUpdatedToState(
      PostLikeListUpdated event) async* {
    yield PostLikeListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<PostLikeListState> mapEventToState(PostLikeListEvent event) async* {
    if (event is LoadPostLikeList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadPostLikeListToState();
      } else {
        yield* _mapLoadPostLikeListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadPostLikeListWithDetailsToState();
    } else if (event is AddPostLikeList) {
      yield* _mapAddPostLikeListToState(event);
    } else if (event is UpdatePostLikeList) {
      yield* _mapUpdatePostLikeListToState(event);
    } else if (event is DeletePostLikeList) {
      yield* _mapDeletePostLikeListToState(event);
    } else if (event is PostLikeListUpdated) {
      yield* _mapPostLikeListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _postLikesListSubscription?.cancel();
    return super.close();
  }
}


