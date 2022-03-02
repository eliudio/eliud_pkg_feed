import 'package:eliud_core/core/wizards/builders/page_builder.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/header_component.dart';

import 'components/feed_menu.dart';
import 'components/header_component.dart';
import 'components/profile_component.dart';

class FeedPageBuilder extends PageBuilder {
  FeedPageBuilder(
      String uniqueId,
      String pageId,
      AppModel app,
      String memberId,
      HomeMenuModel theHomeMenu,
      AppBarModel theAppBar,
      DrawerModel leftDrawer,
      DrawerModel rightDrawer,
      PageProvider pageProvider,
      ActionProvider actionProvider)
      : super(uniqueId, pageId, app, memberId, theHomeMenu, theAppBar,
            leftDrawer, rightDrawer, pageProvider, actionProvider);

  Future<PageModel> _setupPage(
      {required String feedMenuComponentIdentifier,
      required String headerComponentIdentifier}) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(app.documentID!)!
        .add(_page(
            feedMenuComponentIdentifier: feedMenuComponentIdentifier,
            headerComponentIdentifier: headerComponentIdentifier));
  }

  PageModel _page(
      {required String feedMenuComponentIdentifier,
      required String headerComponentIdentifier}) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractFeedMenuComponent.componentName,
        componentId: constructDocumentId(uniqueId: uniqueId, documentId: feedMenuComponentIdentifier)));
    components.add(BodyComponentModel(
        documentID: "2",
        componentName: AbstractHeaderComponent.componentName,
        componentId: constructDocumentId(uniqueId: uniqueId, documentId: headerComponentIdentifier)));
    components.add(BodyComponentModel(
        documentID: "3",
        componentName: AbstractFeedComponent.componentName,
        componentId: constructDocumentId(uniqueId: uniqueId, documentId: pageId)));

    return PageModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageId),
        appId: app.documentID!,
        title: "Feed",
        drawer: leftDrawer,
        endDrawer: rightDrawer,
        appBar: theAppBar,
        homeMenu: theHomeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.Level1PrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  FeedModel feedModel() => FeedModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageId),
        appId: app.documentID!,
        description: "My Feed",
        thumbImage: ThumbStyle.Thumbs,
        photoPost: true,
        videoPost: true,
        messagePost: true,
        audioPost: false,
        albumPost: true,
        articlePost: true,
        conditions: StorageConditionsModel(
            privilegeLevelRequired:
                PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
      );

  Future<FeedModel> _setupFeed() async {
    return await AbstractRepositorySingleton.singleton
        .feedRepository(app.documentID!)!
        .add(feedModel());
  }

  Future<FeedModel> run(
      {required String feedMenuComponentIdentifier,
      required String headerComponentIdentifier,
      required String profileComponentIdentifier,
      required String feedPageId,
      required String profilePageId,
      required String followRequestPageId,
      required String followersPageId,
      required String followingPageId,
      required String fiendFriendsPageId,
      required String appMembersPageId}) async {
    var feed = await _setupFeed();
    await FeedMenu(
      uniqueId,
      app,
      feedPageId: feedPageId,
      profilePageId: profilePageId,
      followRequestPageId: followRequestPageId,
      followersPageId: followersPageId,
      followingPageId: followingPageId,
      fiendFriendsPageId: fiendFriendsPageId,
      appMembersPageId: appMembersPageId,
    ).run(feed: feed, feedMenuComponentIdentifier: feedMenuComponentIdentifier);
    await ProfileComponent(uniqueId, app.documentID!)
        .run(feed: feed, profileComponentId: profileComponentIdentifier);
    await HeaderComponent(uniqueId, app.documentID!)
        .run(feed: feed, headerComponentIdentifier: headerComponentIdentifier);

    // Specific to feed page
    await _setupPage(
      feedMenuComponentIdentifier: feedMenuComponentIdentifier,
      headerComponentIdentifier: headerComponentIdentifier,
    );
    return feed;
  }
}
