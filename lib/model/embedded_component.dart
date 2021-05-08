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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';

import '../model/post_medium_list_bloc.dart';
import '../model/post_medium_list.dart';
import '../model/post_medium_list_event.dart';
import '../model/post_medium_model.dart';
import '../model/post_medium_repository.dart';

typedef PostMediumListChanged(List<PostMediumModel> values);

postMediumsList(context, value, trigger) => EmbeddedComponentFactory.postMediumsList(context, value, trigger);

class EmbeddedComponentFactory {

static Widget postMediumsList(BuildContext context, List<PostMediumModel> values, PostMediumListChanged trigger) {
  PostMediumInMemoryRepository inMemoryRepository = PostMediumInMemoryRepository(trigger, values,);
  return MultiBlocProvider(
    providers: [
      BlocProvider<PostMediumListBloc>(
        create: (context) => PostMediumListBloc(
          postMediumRepository: inMemoryRepository,
          )..add(LoadPostMediumList()),
        )
        ],
    child: PostMediumListWidget(isEmbedded: true),
  );
}


}

class PostMediumInMemoryRepository implements PostMediumRepository {
    final List<PostMediumModel> items;
    final PostMediumListChanged trigger;
    Stream<List<PostMediumModel>>? theValues;

    PostMediumInMemoryRepository(this.trigger, this.items) {
        List<List<PostMediumModel>> myList = <List<PostMediumModel>>[];
        if (items != null) myList.add(items);
        theValues = Stream<List<PostMediumModel>>.fromIterable(myList);
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

    Future<PostMediumModel> add(PostMediumModel value) {
        items.add(value.copyWith(documentID: newRandomKey()));
        trigger(items);
        return Future.value(value);
    }

    Future<void> delete(PostMediumModel value) {
      int index = _index(value.documentID!);
      if (index >= 0) items.removeAt(index);
      trigger(items);
      return Future.value(value);
    }

    Future<PostMediumModel> update(PostMediumModel value) {
      int index = _index(value.documentID!);
      if (index >= 0) {
        items.replaceRange(index, index+1, [value]);
        trigger(items);
      }
      return Future.value(value);
    }

    Future<PostMediumModel> get(String? id, { Function(Exception)? onError }) {
      int index = _index(id!);
      var completer = new Completer<PostMediumModel>();
      completer.complete(items[index]);
      return completer.future;
    }

    Stream<List<PostMediumModel>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!;
    }
    
    Stream<List<PostMediumModel>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!;
    }
    
    @override
    StreamSubscription<List<PostMediumModel>> listen(trigger, { String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!.listen((theList) => trigger(theList));
    }
  
    @override
    StreamSubscription<List<PostMediumModel>> listenWithDetails(trigger, { String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!.listen((theList) => trigger(theList));
    }
    
    void flush() {}

    Future<List<PostMediumModel>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return Future.value(items);
    }
    
    Future<List<PostMediumModel>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
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
  StreamSubscription<PostMediumModel> listenTo(String documentId, PostMediumChanged changed) {
    throw UnimplementedError();
  }

  @override
  Future<PostMediumModel> changeValue(String documentId, String fieldName, num changeByThisValue) {
    throw UnimplementedError();
  }
  

    Future<void> deleteAll() async {}
}

