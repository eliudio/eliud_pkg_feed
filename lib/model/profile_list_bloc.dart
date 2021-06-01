/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_feed/model/profile_repository.dart';
import 'package:eliud_pkg_feed/model/profile_list_event.dart';
import 'package:eliud_pkg_feed/model/profile_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _profileLimit = 5;

class ProfileListBloc extends Bloc<ProfileListEvent, ProfileListState> {
  final ProfileRepository _profileRepository;
  StreamSubscription? _profilesListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;

  ProfileListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required ProfileRepository profileRepository})
      : assert(profileRepository != null),
        _profileRepository = profileRepository,
        super(ProfileListLoading());

  Stream<ProfileListState> _mapLoadProfileListToState() async* {
    int amountNow =  (state is ProfileListLoaded) ? (state as ProfileListLoaded).values!.length : 0;
    _profilesListSubscription?.cancel();
    _profilesListSubscription = _profileRepository.listen(
          (list) => add(ProfileListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * _profileLimit : null
    );
  }

  Stream<ProfileListState> _mapLoadProfileListWithDetailsToState() async* {
    int amountNow =  (state is ProfileListLoaded) ? (state as ProfileListLoaded).values!.length : 0;
    _profilesListSubscription?.cancel();
    _profilesListSubscription = _profileRepository.listenWithDetails(
            (list) => add(ProfileListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * _profileLimit : null
    );
  }

  Stream<ProfileListState> _mapAddProfileListToState(AddProfileList event) async* {
    var value = event.value;
    if (value != null) 
      _profileRepository.add(value);
  }

  Stream<ProfileListState> _mapUpdateProfileListToState(UpdateProfileList event) async* {
    var value = event.value;
    if (value != null) 
      _profileRepository.update(value);
  }

  Stream<ProfileListState> _mapDeleteProfileListToState(DeleteProfileList event) async* {
    var value = event.value;
    if (value != null) 
      _profileRepository.delete(value);
  }

  Stream<ProfileListState> _mapProfileListUpdatedToState(
      ProfileListUpdated event) async* {
    yield ProfileListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<ProfileListState> mapEventToState(ProfileListEvent event) async* {
    if (event is LoadProfileList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadProfileListToState();
      } else {
        yield* _mapLoadProfileListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadProfileListWithDetailsToState();
    } else if (event is AddProfileList) {
      yield* _mapAddProfileListToState(event);
    } else if (event is UpdateProfileList) {
      yield* _mapUpdateProfileListToState(event);
    } else if (event is DeleteProfileList) {
      yield* _mapDeleteProfileListToState(event);
    } else if (event is ProfileListUpdated) {
      yield* _mapProfileListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _profilesListSubscription?.cancel();
    return super.close();
  }
}


