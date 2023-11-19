import 'package:eliud_core/core/base/model_base.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core/model/display_conditions_model.dart';
import 'package:eliud_core/tools/action/action_entity.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_entity.dart';

// Post the current page to your feed
class PostActionModel extends ActionModel {
  // Post to which feed, which could be the feed of a different app
  final FeedModel? feed;

  PostActionModel(super.app, {this.feed, super.conditions})
      : super(actionType: PostActionEntity.label);

  @override
  ActionEntity toEntity({String? appId}) {
    return PostActionEntity(
        feedId: (feed != null) ? feed!.documentID : null,
        conditions: (conditions != null) ? conditions!.toEntity() : null,
        appId: appId);
  }

  @override
  Future<List<ModelReference>> collectReferences({
    String? appId,
  }) async {
    List<ModelReference> referencesCollector = [];
    if (feed != null) {
      referencesCollector
          .add(ModelReference(FeedModel.packageName, FeedModel.id, feed!));
    }
    return referencesCollector;
  }

  static Future<ActionModel?> fromEntity(
      AppModel app, PostActionEntity entity) async {
    if (entity.appID == null) {
      throw Exception('entity PostActionModel.appID is null');
    }
    return PostActionModel(
      app,
      conditions: await DisplayConditionsModel.fromEntity(entity.conditions),
    );
  }

  static Future<ActionModel> fromEntityPlus(
      AppModel app, PostActionEntity entity,
      {String? appId}) async {
    if (entity.appID == null) {
      throw Exception('entity PostActionModel.appID is null');
    }
    FeedModel? feedModel;
    if (entity.feedId != null) {
      try {
        await feedRepository(appId: entity.appID)!
            .get(entity.feedId)
            .then((val) {
          feedModel = val;
        }).catchError((error) {});
      } catch (_) {}
    }

    return PostActionModel(app,
        conditions: await DisplayConditionsModel.fromEntity(entity.conditions),
        feed: feedModel);
  }

  @override
  String message() {
    return "Post";
  }

  @override
  String describe() => 'Post the current page to feed';

  @override
  ActionModel copyWith(AppModel newApp) =>
      PostActionModel(newApp, feed: feed, conditions: conditions);
}

class PostActionMapper implements ActionModelMapper {
  @override
  Future<ActionModel?> fromEntity(AppModel app, ActionEntity entity) =>
      PostActionModel.fromEntity(app, entity as PostActionEntity);

  @override
  Future<ActionModel> fromEntityPlus(AppModel app, ActionEntity entity) =>
      PostActionModel.fromEntityPlus(app, entity as PostActionEntity);

  @override
  ActionEntity fromMap(Map map) => PostActionEntity.fromMap(map);
}
