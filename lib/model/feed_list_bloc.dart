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
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';


class FeedListBloc extends Bloc<FeedListEvent, FeedListState> {
  final FeedRepository _feedRepository;
  StreamSubscription _feedsListSubscription;
  final AccessBloc accessBloc;
  final EliudQuery eliudQuery;


  FeedListBloc(this.accessBloc,{ this.eliudQuery, @required FeedRepository feedRepository })
      : assert(feedRepository != null),
      _feedRepository = feedRepository,
      super(FeedListLoading());

  Stream<FeedListState> _mapLoadFeedListToState({ String orderBy, bool descending }) async* {
    _feedsListSubscription?.cancel();
    _feedsListSubscription = _feedRepository.listen((list) => add(FeedListUpdated(value: list)), orderBy: orderBy, descending: descending, eliudQuery: eliudQuery, );
  }

  Stream<FeedListState> _mapLoadFeedListWithDetailsToState() async* {
    _feedsListSubscription?.cancel();
    _feedsListSubscription = _feedRepository.listenWithDetails((list) => add(FeedListUpdated(value: list)), );
  }

  Stream<FeedListState> _mapAddFeedListToState(AddFeedList event) async* {
    _feedRepository.add(event.value);
  }

  Stream<FeedListState> _mapUpdateFeedListToState(UpdateFeedList event) async* {
    _feedRepository.update(event.value);
  }

  Stream<FeedListState> _mapDeleteFeedListToState(DeleteFeedList event) async* {
    _feedRepository.delete(event.value);
  }

  Stream<FeedListState> _mapFeedListUpdatedToState(FeedListUpdated event) async* {
    yield FeedListLoaded(values: event.value);
  }


  @override
  Stream<FeedListState> mapEventToState(FeedListEvent event) async* {
    final currentState = state;
    if (event is LoadFeedList) {
      yield* _mapLoadFeedListToState(orderBy: event.orderBy, descending: event.descending);
    } if (event is LoadFeedListWithDetails) {
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


