/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/feed_menu_repository.dart';
import 'package:eliud_pkg_feed/model/feed_menu_list_event.dart';
import 'package:eliud_pkg_feed/model/feed_menu_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class FeedMenuListBloc extends Bloc<FeedMenuListEvent, FeedMenuListState> {
  final FeedMenuRepository _feedMenuRepository;
  StreamSubscription? _feedMenusListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int feedMenuLimit;

  FeedMenuListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required FeedMenuRepository feedMenuRepository, this.feedMenuLimit = 5})
      : assert(feedMenuRepository != null),
        _feedMenuRepository = feedMenuRepository,
        super(FeedMenuListLoading());

  Stream<FeedMenuListState> _mapLoadFeedMenuListToState() async* {
    int amountNow =  (state is FeedMenuListLoaded) ? (state as FeedMenuListLoaded).values!.length : 0;
    _feedMenusListSubscription?.cancel();
    _feedMenusListSubscription = _feedMenuRepository.listen(
          (list) => add(FeedMenuListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * feedMenuLimit : null
    );
  }

  Stream<FeedMenuListState> _mapLoadFeedMenuListWithDetailsToState() async* {
    int amountNow =  (state is FeedMenuListLoaded) ? (state as FeedMenuListLoaded).values!.length : 0;
    _feedMenusListSubscription?.cancel();
    _feedMenusListSubscription = _feedMenuRepository.listenWithDetails(
            (list) => add(FeedMenuListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * feedMenuLimit : null
    );
  }

  Stream<FeedMenuListState> _mapAddFeedMenuListToState(AddFeedMenuList event) async* {
    var value = event.value;
    if (value != null) 
      _feedMenuRepository.add(value);
  }

  Stream<FeedMenuListState> _mapUpdateFeedMenuListToState(UpdateFeedMenuList event) async* {
    var value = event.value;
    if (value != null) 
      _feedMenuRepository.update(value);
  }

  Stream<FeedMenuListState> _mapDeleteFeedMenuListToState(DeleteFeedMenuList event) async* {
    var value = event.value;
    if (value != null) 
      _feedMenuRepository.delete(value);
  }

  Stream<FeedMenuListState> _mapFeedMenuListUpdatedToState(
      FeedMenuListUpdated event) async* {
    yield FeedMenuListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<FeedMenuListState> mapEventToState(FeedMenuListEvent event) async* {
    if (event is LoadFeedMenuList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadFeedMenuListToState();
      } else {
        yield* _mapLoadFeedMenuListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadFeedMenuListWithDetailsToState();
    } else if (event is AddFeedMenuList) {
      yield* _mapAddFeedMenuListToState(event);
    } else if (event is UpdateFeedMenuList) {
      yield* _mapUpdateFeedMenuListToState(event);
    } else if (event is DeleteFeedMenuList) {
      yield* _mapDeleteFeedMenuListToState(event);
    } else if (event is FeedMenuListUpdated) {
      yield* _mapFeedMenuListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _feedMenusListSubscription?.cancel();
    return super.close();
  }
}


