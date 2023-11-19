import 'package:eliud_core_model/model/storage_conditions_model.dart';
import 'package:eliud_core_model/tools/component/component_spec.dart';
import 'package:eliud_core_model/tools/etc/random.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';

import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_bloc.dart';

import '../../../model/feed_entity.dart';

class FeedDashboardBloc extends EditorBaseBloc<FeedModel, FeedEntity> {
  FeedDashboardBloc(String appId, EditorFeedback feedback)
      : super(appId, feedRepository(appId: appId)!, feedback);

  @override
  FeedModel newInstance(StorageConditionsModel conditions) {
    return FeedModel(
      documentID: newRandomKey(),
      appId: appId,
      thumbImage: ThumbStyle.thumbs,
      photoPost: true,
      videoPost: true,
      messagePost: true,
      audioPost: true,
      albumPost: true,
      articlePost: true,
    );
  }

  @override
  FeedModel setDefaultValues(FeedModel t, StorageConditionsModel conditions) {
    return t.copyWith(
      description: t.description ?? '?',
      appId: t.appId,
      thumbImage: t.thumbImage ?? ThumbStyle.thumbs,
      photoPost: t.photoPost ?? true,
      videoPost: t.videoPost ?? true,
      messagePost: t.messagePost ?? true,
      audioPost: t.audioPost ?? true,
      albumPost: t.albumPost ?? true,
      articlePost: t.articlePost ?? true,
    );
  }
}
