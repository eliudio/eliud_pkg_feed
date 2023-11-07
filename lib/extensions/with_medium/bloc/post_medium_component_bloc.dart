import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_bloc.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_state.dart';
import 'package:eliud_core/model/member_medium_container_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_pkg_text/platform/widgets/bloc/html_with_platform_medium_component_bloc.dart';

import '../../../model/abstract_repository_singleton.dart';
import '../../../model/post_entity.dart';
import '../../../model/post_model.dart';

class HtmlPostMediumBloc extends ExtEditorBaseBloc<PostModel,
    MemberMediumContainerModel, PostEntity> {
  HtmlPostMediumBloc(String appId)
      : super(appId, postRepository(appId: appId)!, null) {
    on<HtmlMediaMoveEvent<PostModel, MemberMediumContainerModel>>(
        (event, emit) async {
      var theState = state as ExtEditorBaseInitialised;
      var items = theState.model.htmlMedia!;
      var newListedItems = copyOf(items);
      var index = items.indexOf(event.item);
      if (index != -1) {
        if (event.isUp) {
          if (index > 0) {
            var old = newListedItems[index - 1];
            newListedItems[index - 1] = newListedItems[index];
            newListedItems[index] = old;
            emit(ExtEditorBaseInitialised(
                model: theState.model.copyWith(htmlMedia: newListedItems),
                currentEdit: theState.currentEdit));
          }
        } else {
          if (index < newListedItems.length - 1) {
            var old = newListedItems[index + 1];
            newListedItems[index + 1] = newListedItems[index];
            newListedItems[index] = old;
            emit(ExtEditorBaseInitialised(
                model: theState.model.copyWith(htmlMedia: newListedItems),
                currentEdit: theState.currentEdit));
          }
        }
      }
    });
  }

  @override
  PostModel addItem(PostModel model, MemberMediumContainerModel newItem) {
    List<MemberMediumContainerModel> newItems = model.memberMedia == null
        ? []
        : model.memberMedia!.map((e) => e).toList();
    newItems.add(newItem);
    var newModel = model.copyWith(memberMedia: newItems);
    return newModel;
  }

  @override
  PostModel deleteItem(PostModel model, MemberMediumContainerModel deleteItem) {
    var newItems = <MemberMediumContainerModel>[];
    for (var item in model.memberMedia!) {
      if (item != deleteItem) {
        newItems.add(item);
      }
    }
    var newModel = model.copyWith(memberMedia: newItems);
    return newModel;
  }

  @override
  PostModel newInstance(StorageConditionsModel conditions) {
    throw Exception("Not implemented");
  }

  @override
  PostModel setDefaultValues(PostModel t, StorageConditionsModel conditions) {
    throw Exception("Not implemented");
  }

  @override
  PostModel updateItem(PostModel model, MemberMediumContainerModel oldItem,
      MemberMediumContainerModel newItem) {
    throw Exception("Not implemented");
  }

  @override
  List<MemberMediumContainerModel> copyOf(List<MemberMediumContainerModel> ts) {
    return ts.map((e) => e).toList();
  }
}
