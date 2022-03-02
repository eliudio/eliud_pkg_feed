import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/wizards/builders/helpers/profile_and_feed_to_action.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_follow/model/follow_requests_dashboard_model.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_model.dart';
import 'package:eliud_pkg_follow/model/invite_dashboard_model.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

class FollowingDashboard {
  final String uniqueId;
  final AppModel app;
  final String componentIdentifier;
  final String title;
  final FollowingView view;
  final String? profilePageId;
  final String? feedPageId;

  FollowingDashboard(
    this.uniqueId,
    this.app,
    this.componentIdentifier,
    this.title,
    this.view,
    this.profilePageId,
    this.feedPageId,
  );

  FollowingDashboardModel _dashboardModel() {
    return FollowingDashboardModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: componentIdentifier),
      appId: app.documentID!,
      description: title,
      view: view,
      memberActions: ProfileAndFeedToAction.getMemberActionModels(
          uniqueId, app, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<FollowingDashboardModel> _setupDashboard() async {
    return await followingDashboardRepository(appId: app.documentID!)!
        .add(_dashboardModel());
  }

  Future<FollowingDashboardModel> run() async {
    return await _setupDashboard();
  }
}

class FollowRequestDashboard {
  final String uniqueId;
  final AppModel app;
  final String componentIdentifier;
  final String? profilePageId;
  final String? feedPageId;

  FollowRequestDashboard(this.uniqueId, this.app, this.componentIdentifier,
      this.profilePageId, this.feedPageId);

  FollowRequestsDashboardModel _dashboardModel() {
    return FollowRequestsDashboardModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: componentIdentifier),
      appId: app.documentID!,
      description: "Follow requests",
      memberActions: ProfileAndFeedToAction.getMemberActionModels(
          uniqueId, app, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<FollowRequestsDashboardModel> _setupDashboard() async {
    return await followRequestsDashboardRepository(appId: app.documentID!)!
        .add(_dashboardModel());
  }

  Future<FollowRequestsDashboardModel> run() async {
    return await _setupDashboard();
  }
}

class InviteDashboard {
  final String uniqueId;
  final AppModel app;
  final String componentIdentifier;
  final String? profilePageId;
  final String? feedPageId;

  InviteDashboard(this.uniqueId, this.app, this.componentIdentifier,
      this.profilePageId, this.feedPageId);

  InviteDashboardModel _dashboardModel() {
    return InviteDashboardModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: componentIdentifier),
      appId: app.documentID!,
      description: "Follow members",
      memberActions: ProfileAndFeedToAction.getMemberActionModels(
          uniqueId, app, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<InviteDashboardModel> _setupDashboard() async {
    return await inviteDashboardRepository(appId: app.documentID!)!
        .add(_dashboardModel());
  }

  Future<InviteDashboardModel> run() async {
    return await _setupDashboard();
  }
}

class MembershipDashboard {
  final String uniqueId;
  final AppModel app;
  final String componentIdentifier;
  final String? profilePageId;
  final String? feedPageId;

  MembershipDashboard(this.uniqueId, this.app, this.componentIdentifier,
      this.profilePageId, this.feedPageId);

  MembershipDashboardModel _dashboardModel() {
    return MembershipDashboardModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: componentIdentifier),
      appId: app.documentID!,
      description: "Members",
      memberActions: ProfileAndFeedToAction.getMemberActionModels(
          uniqueId, app, profilePageId, feedPageId),
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<MembershipDashboardModel> _setupDashboard() async {
    return await membershipDashboardRepository(appId: app.documentID!)!
        .add(_dashboardModel());
  }

  Future<MembershipDashboardModel> run() async {
    return await _setupDashboard();
  }
}
