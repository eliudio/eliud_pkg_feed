import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/navigate/navigate_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_entity.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_handler.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_model.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_singleton.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliud_router;
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_feed/model/component_registry.dart';

abstract class FeedPackage extends Package {
  @override
  BlocProvider? createMainBloc(NavigatorBloc navigatorBloc, AccessBloc accessBloc) => null;

  @override
  Future<bool?> isConditionOk(String packageCondition, AppModel app, MemberModel? member, bool isOwner, bool? isBlocked, PrivilegeLevel? privilegeLevel) async => null;

  @override
  List<String>? retrieveAllPackageConditions() => null;

  @override
  void init() {
    ComponentRegistry().init();

    AbstractRepositorySingleton.singleton = RepositorySingleton();

    // Register action handler for the feed action
    eliud_router.Router.register(PostActionHandler());

    // Register a mapper for an extra action: the mapper for the WorkflowAction
    ActionModelRegistry.registry()!.addMapper(PostActionEntity.label, PostActionMapper());
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() => AbstractRepositorySingleton.collections;
}
