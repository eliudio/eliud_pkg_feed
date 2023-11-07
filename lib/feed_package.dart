import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/eliud.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_pkg_etc/etc_package.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_entity.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_handler.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_model.dart';
import 'package:eliud_pkg_feed/wizards/feed_wizard.dart';
import 'package:eliud_pkg_follow/follow_package.dart';
import 'package:eliud_pkg_medium/medium_package.dart';
import 'package:eliud_pkg_membership/membership_package.dart';
import 'package:eliud_pkg_notifications/notifications_package.dart';
import 'package:eliud_pkg_text/text_package.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_singleton.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliud_router;
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_feed/model/component_registry.dart';

import 'package:eliud_pkg_feed/feed_package_stub.dart'
    if (dart.library.io) 'feed_mobile_package.dart'
    if (dart.library.html) 'feed_web_package.dart';

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
    ComponentRegistry().init();

    AbstractRepositorySingleton.singleton = RepositorySingleton();

    // register new app wizard for feed
    NewAppWizardRegistry.registry().register(FeedWizard());

    // Register action handler for the feed action
    eliud_router.Router.register(PostActionHandler());

/*
    Registry.registry()!.registerPageComponentsBloc('profile', ProfileWidgetWrapper('feed'));
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
