/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_profile_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/member_profile_repository.dart';
import 'package:eliud_pkg_feed/model/member_profile_list_event.dart';
import 'package:eliud_pkg_feed/model/member_profile_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _memberProfileLimit = 5;

class MemberProfileListBloc extends Bloc<MemberProfileListEvent, MemberProfileListState> {
  final MemberProfileRepository _memberProfileRepository;
  StreamSubscription? _memberProfilesListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;

  MemberProfileListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required MemberProfileRepository memberProfileRepository})
      : assert(memberProfileRepository != null),
        _memberProfileRepository = memberProfileRepository,
        super(MemberProfileListLoading());

  Stream<MemberProfileListState> _mapLoadMemberProfileListToState() async* {
    int amountNow =  (state is MemberProfileListLoaded) ? (state as MemberProfileListLoaded).values!.length : 0;
    _memberProfilesListSubscription?.cancel();
    _memberProfilesListSubscription = _memberProfileRepository.listen(
          (list) => add(MemberProfileListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * _memberProfileLimit : null
    );
  }

  Stream<MemberProfileListState> _mapLoadMemberProfileListWithDetailsToState() async* {
    int amountNow =  (state is MemberProfileListLoaded) ? (state as MemberProfileListLoaded).values!.length : 0;
    _memberProfilesListSubscription?.cancel();
    _memberProfilesListSubscription = _memberProfileRepository.listenWithDetails(
            (list) => add(MemberProfileListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * _memberProfileLimit : null
    );
  }

  Stream<MemberProfileListState> _mapAddMemberProfileListToState(AddMemberProfileList event) async* {
    var value = event.value;
    if (value != null) 
      _memberProfileRepository.add(value);
  }

  Stream<MemberProfileListState> _mapUpdateMemberProfileListToState(UpdateMemberProfileList event) async* {
    var value = event.value;
    if (value != null) 
      _memberProfileRepository.update(value);
  }

  Stream<MemberProfileListState> _mapDeleteMemberProfileListToState(DeleteMemberProfileList event) async* {
    var value = event.value;
    if (value != null) 
      _memberProfileRepository.delete(value);
  }

  Stream<MemberProfileListState> _mapMemberProfileListUpdatedToState(
      MemberProfileListUpdated event) async* {
    yield MemberProfileListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<MemberProfileListState> mapEventToState(MemberProfileListEvent event) async* {
    if (event is LoadMemberProfileList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadMemberProfileListToState();
      } else {
        yield* _mapLoadMemberProfileListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadMemberProfileListWithDetailsToState();
    } else if (event is AddMemberProfileList) {
      yield* _mapAddMemberProfileListToState(event);
    } else if (event is UpdateMemberProfileList) {
      yield* _mapUpdateMemberProfileListToState(event);
    } else if (event is DeleteMemberProfileList) {
      yield* _mapDeleteMemberProfileListToState(event);
    } else if (event is MemberProfileListUpdated) {
      yield* _mapMemberProfileListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _memberProfilesListSubscription?.cancel();
    return super.close();
  }
}


