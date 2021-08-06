/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:eliud_pkg_feed/model/feed_list_event.dart';
import 'package:eliud_pkg_feed/model/feed_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class FeedListBloc extends Bloc<FeedListEvent, FeedListState> {
  final FeedRepository _feedRepository;
  StreamSubscription? _feedsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int feedLimit;

  FeedListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required FeedRepository feedRepository, this.feedLimit = 5})
      : assert(feedRepository != null),
        _feedRepository = feedRepository,
        super(FeedListLoading());

  Stream<FeedListState> _mapLoadFeedListToState() async* {
    int amountNow =  (state is FeedListLoaded) ? (state as FeedListLoaded).values!.length : 0;
    _feedsListSubscription?.cancel();
    _feedsListSubscription = _feedRepository.listen(
          (list) => add(FeedListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * feedLimit : null
    );
  }

  Stream<FeedListState> _mapLoadFeedListWithDetailsToState() async* {
    int amountNow =  (state is FeedListLoaded) ? (state as FeedListLoaded).values!.length : 0;
    _feedsListSubscription?.cancel();
    _feedsListSubscription = _feedRepository.listenWithDetails(
            (list) => add(FeedListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * feedLimit : null
    );
  }

  Stream<FeedListState> _mapAddFeedListToState(AddFeedList event) async* {
    var value = event.value;
    if (value != null) 
      _feedRepository.add(value);
  }

  Stream<FeedListState> _mapUpdateFeedListToState(UpdateFeedList event) async* {
    var value = event.value;
    if (value != null) 
      _feedRepository.update(value);
  }

  Stream<FeedListState> _mapDeleteFeedListToState(DeleteFeedList event) async* {
    var value = event.value;
    if (value != null) 
      _feedRepository.delete(value);
  }

  Stream<FeedListState> _mapFeedListUpdatedToState(
      FeedListUpdated event) async* {
    yield FeedListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<FeedListState> mapEventToState(FeedListEvent event) async* {
    if (event is LoadFeedList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadFeedListToState();
      } else {
        yield* _mapLoadFeedListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadFeedListWithDetailsToState();
    } else if (event is AddFeedList) {
      yield* _mapAddFeedListToState(event);
    } else if (event is UpdateFeedList) {
      yield* _mapUpdateFeedListToState(event);
    } else if (event is DeleteFeedList) {
      yield* _mapDeleteFeedListToState(event);
    } else if (event is FeedListUpdated) {
      yield* _mapFeedListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _feedsListSubscription?.cancel();
    return super.close();
  }
}


