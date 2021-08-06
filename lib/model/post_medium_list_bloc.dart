/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/post_medium_repository.dart';
import 'package:eliud_pkg_feed/model/post_medium_list_event.dart';
import 'package:eliud_pkg_feed/model/post_medium_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class PostMediumListBloc extends Bloc<PostMediumListEvent, PostMediumListState> {
  final PostMediumRepository _postMediumRepository;
  StreamSubscription? _postMediumsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int postMediumLimit;

  PostMediumListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required PostMediumRepository postMediumRepository, this.postMediumLimit = 5})
      : assert(postMediumRepository != null),
        _postMediumRepository = postMediumRepository,
        super(PostMediumListLoading());

  Stream<PostMediumListState> _mapLoadPostMediumListToState() async* {
    int amountNow =  (state is PostMediumListLoaded) ? (state as PostMediumListLoaded).values!.length : 0;
    _postMediumsListSubscription?.cancel();
    _postMediumsListSubscription = _postMediumRepository.listen(
          (list) => add(PostMediumListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * postMediumLimit : null
    );
  }

  Stream<PostMediumListState> _mapLoadPostMediumListWithDetailsToState() async* {
    int amountNow =  (state is PostMediumListLoaded) ? (state as PostMediumListLoaded).values!.length : 0;
    _postMediumsListSubscription?.cancel();
    _postMediumsListSubscription = _postMediumRepository.listenWithDetails(
            (list) => add(PostMediumListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * postMediumLimit : null
    );
  }

  Stream<PostMediumListState> _mapAddPostMediumListToState(AddPostMediumList event) async* {
    var value = event.value;
    if (value != null) 
      _postMediumRepository.add(value);
  }

  Stream<PostMediumListState> _mapUpdatePostMediumListToState(UpdatePostMediumList event) async* {
    var value = event.value;
    if (value != null) 
      _postMediumRepository.update(value);
  }

  Stream<PostMediumListState> _mapDeletePostMediumListToState(DeletePostMediumList event) async* {
    var value = event.value;
    if (value != null) 
      _postMediumRepository.delete(value);
  }

  Stream<PostMediumListState> _mapPostMediumListUpdatedToState(
      PostMediumListUpdated event) async* {
    yield PostMediumListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<PostMediumListState> mapEventToState(PostMediumListEvent event) async* {
    if (event is LoadPostMediumList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadPostMediumListToState();
      } else {
        yield* _mapLoadPostMediumListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadPostMediumListWithDetailsToState();
    } else if (event is AddPostMediumList) {
      yield* _mapAddPostMediumListToState(event);
    } else if (event is UpdatePostMediumList) {
      yield* _mapUpdatePostMediumListToState(event);
    } else if (event is DeletePostMediumList) {
      yield* _mapDeletePostMediumListToState(event);
    } else if (event is PostMediumListUpdated) {
      yield* _mapPostMediumListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _postMediumsListSubscription?.cancel();
    return super.close();
  }
}


