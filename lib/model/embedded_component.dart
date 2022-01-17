/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/embedded_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/model/app_model.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';

import '../model/member_profile_list_bloc.dart';
import '../model/member_profile_list.dart';
import '../model/member_profile_list_event.dart';
import '../model/member_profile_model.dart';
import '../model/member_profile_repository.dart';

typedef MemberProfileListChanged(List<MemberProfileModel> values);

memberProfilesList(app, context, value, trigger) => EmbeddedComponentFactory.memberProfilesList(app, context, value, trigger);

class EmbeddedComponentFactory {

static Widget memberProfilesList(AppModel app, BuildContext context, List<MemberProfileModel> values, MemberProfileListChanged trigger) {
  MemberProfileInMemoryRepository inMemoryRepository = MemberProfileInMemoryRepository(trigger, values,);
  return MultiBlocProvider(
    providers: [
      BlocProvider<MemberProfileListBloc>(
        create: (context) => MemberProfileListBloc(
          memberProfileRepository: inMemoryRepository,
          )..add(LoadMemberProfileList()),
        )
        ],
    child: MemberProfileListWidget(app: app, isEmbedded: true),
  );
}


}

class MemberProfileInMemoryRepository implements MemberProfileRepository {
    final List<MemberProfileModel> items;
    final MemberProfileListChanged trigger;
    Stream<List<MemberProfileModel>>? theValues;

    MemberProfileInMemoryRepository(this.trigger, this.items) {
        List<List<MemberProfileModel>> myList = <List<MemberProfileModel>>[];
        if (items != null) myList.add(items);
        theValues = Stream<List<MemberProfileModel>>.fromIterable(myList);
    }

    int _index(String documentID) {
      int i = 0;
      for (final item in items) {
        if (item.documentID == documentID) {
          return i;
        }
        i++;
      }
      return -1;
    }

    Future<MemberProfileModel> add(MemberProfileModel value) {
        items.add(value.copyWith(documentID: newRandomKey()));
        trigger(items);
        return Future.value(value);
    }

    Future<void> delete(MemberProfileModel value) {
      int index = _index(value.documentID!);
      if (index >= 0) items.removeAt(index);
      trigger(items);
      return Future.value(value);
    }

    Future<MemberProfileModel> update(MemberProfileModel value) {
      int index = _index(value.documentID!);
      if (index >= 0) {
        items.replaceRange(index, index+1, [value]);
        trigger(items);
      }
      return Future.value(value);
    }

    Future<MemberProfileModel> get(String? id, { Function(Exception)? onError }) {
      int index = _index(id!);
      var completer = new Completer<MemberProfileModel>();
      completer.complete(items[index]);
      return completer.future;
    }

    Stream<List<MemberProfileModel>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!;
    }
    
    Stream<List<MemberProfileModel>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!;
    }
    
    @override
    StreamSubscription<List<MemberProfileModel>> listen(trigger, { String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!.listen((theList) => trigger(theList));
    }
  
    @override
    StreamSubscription<List<MemberProfileModel>> listenWithDetails(trigger, { String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!.listen((theList) => trigger(theList));
    }
    
    void flush() {}

    Future<List<MemberProfileModel>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return Future.value(items);
    }
    
    Future<List<MemberProfileModel>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return Future.value(items);
    }

    @override
    getSubCollection(String documentId, String name) {
      throw UnimplementedError();
    }

  @override
  String timeStampToString(timeStamp) {
    throw UnimplementedError();
  }
  
  @override
  StreamSubscription<MemberProfileModel> listenTo(String documentId, MemberProfileChanged changed) {
    throw UnimplementedError();
  }

  @override
  Future<MemberProfileModel> changeValue(String documentId, String fieldName, num changeByThisValue) {
    throw UnimplementedError();
  }
  

    Future<void> deleteAll() async {}
}

