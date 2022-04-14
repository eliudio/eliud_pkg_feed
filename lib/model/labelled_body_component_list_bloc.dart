/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 labelled_body_component_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/labelled_body_component_repository.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_list_event.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class LabelledBodyComponentListBloc extends Bloc<LabelledBodyComponentListEvent, LabelledBodyComponentListState> {
  final LabelledBodyComponentRepository _labelledBodyComponentRepository;
  StreamSubscription? _labelledBodyComponentsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int labelledBodyComponentLimit;

  LabelledBodyComponentListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required LabelledBodyComponentRepository labelledBodyComponentRepository, this.labelledBodyComponentLimit = 5})
      : assert(labelledBodyComponentRepository != null),
        _labelledBodyComponentRepository = labelledBodyComponentRepository,
        super(LabelledBodyComponentListLoading());

  Stream<LabelledBodyComponentListState> _mapLoadLabelledBodyComponentListToState() async* {
    int amountNow =  (state is LabelledBodyComponentListLoaded) ? (state as LabelledBodyComponentListLoaded).values!.length : 0;
    _labelledBodyComponentsListSubscription?.cancel();
    _labelledBodyComponentsListSubscription = _labelledBodyComponentRepository.listen(
          (list) => add(LabelledBodyComponentListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * labelledBodyComponentLimit : null
    );
  }

  Stream<LabelledBodyComponentListState> _mapLoadLabelledBodyComponentListWithDetailsToState() async* {
    int amountNow =  (state is LabelledBodyComponentListLoaded) ? (state as LabelledBodyComponentListLoaded).values!.length : 0;
    _labelledBodyComponentsListSubscription?.cancel();
    _labelledBodyComponentsListSubscription = _labelledBodyComponentRepository.listenWithDetails(
            (list) => add(LabelledBodyComponentListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * labelledBodyComponentLimit : null
    );
  }

  Stream<LabelledBodyComponentListState> _mapAddLabelledBodyComponentListToState(AddLabelledBodyComponentList event) async* {
    var value = event.value;
    if (value != null) 
      _labelledBodyComponentRepository.add(value);
  }

  Stream<LabelledBodyComponentListState> _mapUpdateLabelledBodyComponentListToState(UpdateLabelledBodyComponentList event) async* {
    var value = event.value;
    if (value != null) 
      _labelledBodyComponentRepository.update(value);
  }

  Stream<LabelledBodyComponentListState> _mapDeleteLabelledBodyComponentListToState(DeleteLabelledBodyComponentList event) async* {
    var value = event.value;
    if (value != null) 
      _labelledBodyComponentRepository.delete(value);
  }

  Stream<LabelledBodyComponentListState> _mapLabelledBodyComponentListUpdatedToState(
      LabelledBodyComponentListUpdated event) async* {
    yield LabelledBodyComponentListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<LabelledBodyComponentListState> mapEventToState(LabelledBodyComponentListEvent event) async* {
    if (event is LoadLabelledBodyComponentList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadLabelledBodyComponentListToState();
      } else {
        yield* _mapLoadLabelledBodyComponentListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadLabelledBodyComponentListWithDetailsToState();
    } else if (event is LabelledBodyComponentChangeQuery) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadLabelledBodyComponentListToState();
      } else {
        yield* _mapLoadLabelledBodyComponentListWithDetailsToState();
      }
    } else if (event is AddLabelledBodyComponentList) {
      yield* _mapAddLabelledBodyComponentListToState(event);
    } else if (event is UpdateLabelledBodyComponentList) {
      yield* _mapUpdateLabelledBodyComponentListToState(event);
    } else if (event is DeleteLabelledBodyComponentList) {
      yield* _mapDeleteLabelledBodyComponentListToState(event);
    } else if (event is LabelledBodyComponentListUpdated) {
      yield* _mapLabelledBodyComponentListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _labelledBodyComponentsListSubscription?.cancel();
    return super.close();
  }
}


