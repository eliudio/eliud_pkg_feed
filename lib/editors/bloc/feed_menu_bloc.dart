import 'package:bloc/bloc.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/pos_size_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_etc/model/member_action_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

class FeedMenuBloc extends ExtEditorBaseBloc<FeedMenuModel, LabelledBodyComponentModel> {

  FeedMenuBloc(String appId, EditorFeedback feedback)
      : super(appId, feedMenuRepository(appId: appId)!, feedback);

  @override
  FeedMenuModel addItem(FeedMenuModel model, LabelledBodyComponentModel newItem) {
    List<LabelledBodyComponentModel> newItems = model.bodyComponentsCurrentMember == null
        ? []
        : model.bodyComponentsCurrentMember!.map((e) => e).toList();
    newItems.add(newItem);
    var newModel = model.copyWith(bodyComponentsCurrentMember:  newItems);
    return newModel;
  }

  @override
  FeedMenuModel deleteItem(FeedMenuModel model, LabelledBodyComponentModel deleteItem) {
    var newItems = <LabelledBodyComponentModel>[];
    for (var item in model.bodyComponentsCurrentMember!) {
      if (item != deleteItem) {
        newItems.add(item);
      }
    }
    var newModel = model.copyWith(bodyComponentsCurrentMember: newItems);
    return newModel;
  }

  @override
  FeedMenuModel newInstance(StorageConditionsModel conditions) {
    return FeedMenuModel(
      appId: appId,
      documentID: newRandomKey(),
      conditions: conditions,
    );
  }

  @override
  FeedMenuModel setDefaultValues(FeedMenuModel t, StorageConditionsModel conditions) {
    return t.copyWith(
        conditions: t.conditions ?? conditions);
  }

  @override
  FeedMenuModel updateItem(FeedMenuModel model, LabelledBodyComponentModel oldItem, LabelledBodyComponentModel newItem) {
    List<LabelledBodyComponentModel> currentItems = model.bodyComponentsCurrentMember == null
        ? []
        : model.bodyComponentsCurrentMember!;
    var index = currentItems.indexOf(oldItem);
    if (index != -1) {
      var newItems = currentItems.map((e) => e).toList();
      newItems[index] = newItem;
      var newModel = model.copyWith(bodyComponentsCurrentMember: newItems);
      return newModel;
    } else {
      throw Exception("Could not find " + oldItem.toString());
    }
  }

  @override
  List<LabelledBodyComponentModel> copyOf(List<LabelledBodyComponentModel> ts) {
    return ts.map((e) => e).toList();
  }

}
