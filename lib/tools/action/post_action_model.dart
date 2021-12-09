import 'package:eliud_core/model/display_conditions_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/action/action_entity.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_entity.dart';
import 'package:flutter/material.dart';

// Post the current page to your feed
class PostActionModel extends ActionModel {
  // Post to which feed, which could be the feed of a different app
  final FeedModel? feed;

  PostActionModel(String appId, { this.feed, DisplayConditionsModel? conditions} ) : super(appId, actionType: PostActionEntity.label, conditions: conditions);

  @override
  ActionEntity toEntity({String? appId}) {
    return PostActionEntity(
        feedId: (feed != null) ? feed!.documentID : null,
        conditions: (conditions != null) ? conditions!.toEntity(): null,
        appId: appId);
  }

  static ActionModel? fromEntity(PostActionEntity entity) {
    if (entity.appID == null) throw Exception('entity PostActionModel.appID is null');
    return PostActionModel(
      entity.appID!,
      conditions: DisplayConditionsModel.fromEntity(entity.conditions),
    );
  }

  static Future<ActionModel> fromEntityPlus(PostActionEntity entity, { String? appId}) async {
    if (entity.appID == null) throw Exception('entity PostActionModel.appID is null');
    FeedModel? feedModel;
    if (entity.feedId != null) {
      try {
        await feedRepository(appId: entity.appID)!.get(entity.feedId).then((val) {
          feedModel = val;
        }).catchError((error) {});
      } catch (_) {}
    }

    return PostActionModel(
        entity.appID!,
        conditions: DisplayConditionsModel.fromEntity(entity.conditions),
        feed: feedModel
    );
  }

  String message() {
    return "Post";
  }

  @override
  String describe() => 'Post the current page to feed';
}

class PostActionMapper implements ActionModelMapper {
  @override
  ActionModel? fromEntity(ActionEntity entity) => PostActionModel.fromEntity(entity as PostActionEntity);

  @override
  Future<ActionModel> fromEntityPlus(ActionEntity entity) => PostActionModel.fromEntityPlus(entity as PostActionEntity);

  @override
  ActionEntity fromMap(Map map) => PostActionEntity.fromMap(map);
}
