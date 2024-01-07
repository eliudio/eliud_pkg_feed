import 'package:eliud_core/access/access_bloc.dart';
import 'package:eliud_core_main/apis/action_api/actions/action_model_registry.dart';
import 'package:eliud_core_main/apis/wizard_api/new_app_wizard_info.dart';
import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/eliud.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_core_main/tools/etc/member_collection_info.dart';
import 'package:eliud_pkg_etc/etc_package.dart';
import 'package:eliud_pkg_feed/editors/feed_front_component_editor.dart';
import 'package:eliud_pkg_feed/editors/profile_component_editor.dart';
import 'package:eliud_pkg_feed/extensions/feed_front_component.dart';
import 'package:eliud_pkg_feed/extensions/feed_menu_component.dart';
import 'package:eliud_pkg_feed/extensions/profile_component.dart';
import 'package:eliud_pkg_feed_model/tools/action/post_action_entity.dart';
import 'package:eliud_pkg_feed_model/tools/action/post_action_handler.dart';
import 'package:eliud_pkg_feed_model/tools/action/post_action_model.dart';
import 'package:eliud_pkg_feed/wizards/feed_wizard.dart';
import 'package:eliud_pkg_feed_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed_model/model/component_registry.dart';
import 'package:eliud_pkg_feed_model/model/repository_singleton.dart';
import 'package:eliud_pkg_follow/follow_package.dart';
import 'package:eliud_pkg_medium/medium_package.dart';
import 'package:eliud_pkg_membership/membership_package.dart';
import 'package:eliud_pkg_notifications/notifications_package.dart';
import 'package:eliud_pkg_text/text_package.dart';
import 'package:eliud_core_model/model/access_model.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliud_router;

import 'package:eliud_pkg_feed/feed_package_stub.dart'
    if (dart.library.io) 'feed_mobile_package.dart'
    if (dart.library.html) 'feed_web_package.dart';

import 'editors/feed_menu_component_editor.dart';

abstract class FeedPackage extends Package {
  FeedPackage() : super('eliud_pkg_feed');

  @override
  Future<List<PackageConditionDetails>>? getAndSubscribe(
          AccessBloc accessBloc,
          AppModel app,
          MemberModel? member,
          bool isOwner,
          bool? isBlocked,
          PrivilegeLevel? privilegeLevel) =>
      null;

  @override
  List<String>? retrieveAllPackageConditions() => null;

  @override
  void init() {
    ComponentRegistry().init(
      FeedFrontComponentConstructorDefault(),
      FeedFrontComponentEditorConstructor(),
      FeedMenuComponentConstructorDefault(),
      FeedMenuComponentEditorConstructor(),
      ProfileComponentConstructorDefault(),
      ProfileComponentEditorConstructor(),
    );

    AbstractRepositorySingleton.singleton = RepositorySingleton();

    // register new app wizard for feed
    Apis.apis().getWizardApi().register(FeedWizard());

    // Register action handler for the feed action
    eliud_router.Router.register(PostActionHandler());

/*
    Apis.apis().registerPageComponentsBloc('profile', ProfileWidgetWrapper('feed'));
*/

    // Register a mapper for an extra action: the mapper for the WorkflowAction
    ActionModelRegistry.registry()!
        .addMapper(PostActionEntity.label, PostActionMapper());
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() =>
      AbstractRepositorySingleton.collections;

  static FeedPackage instance() => getFeedPackage();

  /*
   * Register depending packages
   */
  @override
  void registerDependencies(Eliud eliud) {
    eliud.registerPackage(CorePackage.instance());
    eliud.registerPackage(FollowPackage.instance());
    eliud.registerPackage(MediumPackage.instance());
    eliud.registerPackage(MembershipPackage.instance());
    eliud.registerPackage(NotificationsPackage.instance());
    eliud.registerPackage(TextPackage.instance());
    eliud.registerPackage(EtcPackage.instance());
  }
}
