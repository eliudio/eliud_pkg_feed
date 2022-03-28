/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/header_repository.dart';
import 'package:eliud_pkg_feed/model/header_list_event.dart';
import 'package:eliud_pkg_feed/model/header_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class HeaderListBloc extends Bloc<HeaderListEvent, HeaderListState> {
  final HeaderRepository _headerRepository;
  StreamSubscription? _headersListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int headerLimit;

  HeaderListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required HeaderRepository headerRepository, this.headerLimit = 5})
      : assert(headerRepository != null),
        _headerRepository = headerRepository,
        super(HeaderListLoading());

  Stream<HeaderListState> _mapLoadHeaderListToState() async* {
    int amountNow =  (state is HeaderListLoaded) ? (state as HeaderListLoaded).values!.length : 0;
    _headersListSubscription?.cancel();
    _headersListSubscription = _headerRepository.listen(
          (list) => add(HeaderListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * headerLimit : null
    );
  }

  Stream<HeaderListState> _mapLoadHeaderListWithDetailsToState() async* {
    int amountNow =  (state is HeaderListLoaded) ? (state as HeaderListLoaded).values!.length : 0;
    _headersListSubscription?.cancel();
    _headersListSubscription = _headerRepository.listenWithDetails(
            (list) => add(HeaderListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * headerLimit : null
    );
  }

  Stream<HeaderListState> _mapAddHeaderListToState(AddHeaderList event) async* {
    var value = event.value;
    if (value != null) 
      _headerRepository.add(value);
  }

  Stream<HeaderListState> _mapUpdateHeaderListToState(UpdateHeaderList event) async* {
    var value = event.value;
    if (value != null) 
      _headerRepository.update(value);
  }

  Stream<HeaderListState> _mapDeleteHeaderListToState(DeleteHeaderList event) async* {
    var value = event.value;
    if (value != null) 
      _headerRepository.delete(value);
  }

  Stream<HeaderListState> _mapHeaderListUpdatedToState(
      HeaderListUpdated event) async* {
    yield HeaderListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<HeaderListState> mapEventToState(HeaderListEvent event) async* {
    if (event is LoadHeaderList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadHeaderListToState();
      } else {
        yield* _mapLoadHeaderListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadHeaderListWithDetailsToState();
    } else if (event is HeaderChangeQuery) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadHeaderListToState();
      } else {
        yield* _mapLoadHeaderListWithDetailsToState();
      }
    } else if (event is AddHeaderList) {
      yield* _mapAddHeaderListToState(event);
    } else if (event is UpdateHeaderList) {
      yield* _mapUpdateHeaderListToState(event);
    } else if (event is DeleteHeaderList) {
      yield* _mapDeleteHeaderListToState(event);
    } else if (event is HeaderListUpdated) {
      yield* _mapHeaderListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _headersListSubscription?.cancel();
    return super.close();
  }
}


