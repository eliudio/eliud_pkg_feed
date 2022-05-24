import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/widgets/condition_simple_widget.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/notification_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_bloc.dart';
import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_event.dart';
import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_state.dart';

class FeedDashboardBloc
    extends EditorBaseBloc<FeedModel> {

  FeedDashboardBloc(String appId, EditorFeedback feedback)
      : super(appId, feedRepository(appId: appId)!, feedback);

  @override
  FeedModel newInstance(StorageConditionsModel conditions) {
    return FeedModel(
        documentID: newRandomKey(),
      appId: appId,
        thumbImage: ThumbStyle.Thumbs,
        photoPost: true,
        videoPost: true,
        messagePost: true,
        audioPost: true,
        albumPost: true,
        articlePost: true,
        );
  }

  @override
  FeedModel setDefaultValues(
      FeedModel t, StorageConditionsModel conditions) {
    return t.copyWith(
        description: t.description ?? '?',
        appId: t.appId,
        thumbImage: t.thumbImage ?? ThumbStyle.Thumbs,
        photoPost: t.photoPost ?? true,
        videoPost: t.videoPost ?? true,
        messagePost: t.messagePost ?? true,
        audioPost: t.audioPost ?? true,
        albumPost: t.albumPost ?? true,
        articlePost: t.articlePost ?? true,
        );
  }
}

