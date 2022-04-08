/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/feed_front_repository.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_event.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class FeedFrontListBloc extends Bloc<FeedFrontListEvent, FeedFrontListState> {
  final FeedFrontRepository _feedFrontRepository;
  StreamSubscription? _feedFrontsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int feedFrontLimit;

  FeedFrontListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required FeedFrontRepository feedFrontRepository, this.feedFrontLimit = 5})
      : assert(feedFrontRepository != null),
        _feedFrontRepository = feedFrontRepository,
        super(FeedFrontListLoading());

  Stream<FeedFrontListState> _mapLoadFeedFrontListToState() async* {
    int amountNow =  (state is FeedFrontListLoaded) ? (state as FeedFrontListLoaded).values!.length : 0;
    _feedFrontsListSubscription?.cancel();
    _feedFrontsListSubscription = _feedFrontRepository.listen(
          (list) => add(FeedFrontListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * feedFrontLimit : null
    );
  }

  Stream<FeedFrontListState> _mapLoadFeedFrontListWithDetailsToState() async* {
    int amountNow =  (state is FeedFrontListLoaded) ? (state as FeedFrontListLoaded).values!.length : 0;
    _feedFrontsListSubscription?.cancel();
    _feedFrontsListSubscription = _feedFrontRepository.listenWithDetails(
            (list) => add(FeedFrontListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * feedFrontLimit : null
    );
  }

  Stream<FeedFrontListState> _mapAddFeedFrontListToState(AddFeedFrontList event) async* {
    var value = event.value;
    if (value != null) 
      _feedFrontRepository.add(value);
  }

  Stream<FeedFrontListState> _mapUpdateFeedFrontListToState(UpdateFeedFrontList event) async* {
    var value = event.value;
    if (value != null) 
      _feedFrontRepository.update(value);
  }

  Stream<FeedFrontListState> _mapDeleteFeedFrontListToState(DeleteFeedFrontList event) async* {
    var value = event.value;
    if (value != null) 
      _feedFrontRepository.delete(value);
  }

  Stream<FeedFrontListState> _mapFeedFrontListUpdatedToState(
      FeedFrontListUpdated event) async* {
    yield FeedFrontListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<FeedFrontListState> mapEventToState(FeedFrontListEvent event) async* {
    if (event is LoadFeedFrontList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadFeedFrontListToState();
      } else {
        yield* _mapLoadFeedFrontListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadFeedFrontListWithDetailsToState();
    } else if (event is FeedFrontChangeQuery) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadFeedFrontListToState();
      } else {
        yield* _mapLoadFeedFrontListWithDetailsToState();
      }
    } else if (event is AddFeedFrontList) {
      yield* _mapAddFeedFrontListToState(event);
    } else if (event is UpdateFeedFrontList) {
      yield* _mapUpdateFeedFrontListToState(event);
    } else if (event is DeleteFeedFrontList) {
      yield* _mapDeleteFeedFrontListToState(event);
    } else if (event is FeedFrontListUpdated) {
      yield* _mapFeedFrontListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _feedFrontsListSubscription?.cancel();
    return super.close();
  }
}


