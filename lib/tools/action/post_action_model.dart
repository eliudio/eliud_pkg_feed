import 'package:eliud_core/model/conditions_model.dart';
import 'package:eliud_core/tools/action/action_entity.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_entity.dart';

// Post the current page to your feed
class PostActionModel extends ActionModel {
  // Post to which feed, which could be the feed of a different app
  final FeedModel feed;

  PostActionModel(String appId, { this.feed, ConditionsModel conditions} ) : super(appId, actionType: PostActionEntity.label, conditions: conditions);

  @override
  ActionEntity toEntity({String appId}) {
    return PostActionEntity(
        feedId: (feed != null) ? feed.documentID : null,
        conditions: (conditions != null) ? conditions.toEntity(): null,
        appId: appId);
  }

  static ActionModel fromEntity(PostActionEntity entity) {
    if (entity == null) return null;
    return PostActionModel(
      entity.appID,
      conditions: ConditionsModel.fromEntity(entity.conditions),
    );
  }
  static Future<ActionModel> fromEntityPlus(PostActionEntity entity, { String appId}) async {
    FeedModel feedModel;
    if (entity.feedId != null) {
      try {
        await feedRepository(appId: entity.appID).get(entity.feedId).then((val) {
          feedModel = val;
        }).catchError((error) {});
      } catch (_) {}
    }

    return PostActionModel(
        entity.appID,
        conditions: ConditionsModel.fromEntity(entity.conditions),
        feed: feedModel
    );
  }

  String message() {
    return "Post";
  }
}

class PostActionMapper implements ActionModelMapper {
  @override
  ActionModel fromEntity(ActionEntity entity) => PostActionModel.fromEntity(entity);

  @override
  Future<ActionModel> fromEntityPlus(ActionEntity entity) => PostActionModel.fromEntityPlus(entity);

  @override
  ActionEntity fromMap(Map map) => PostActionEntity.fromMap(map);
}
