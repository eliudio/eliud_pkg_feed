import 'package:eliud_core/core/wizards/tools/document_identifier.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';

class FeedBuilder {
  final String uniqueId;
  final String componentIdentifier;
  final AppModel app;

  FeedBuilder(this.app, this.uniqueId, this.componentIdentifier);

  FeedModel feedModel() => FeedModel(
        documentID: constructDocumentId(
            uniqueId: uniqueId, documentId: componentIdentifier),
        appId: app.documentID,
        description: "My Feed",
        thumbImage: ThumbStyle.thumbs,
        photoPost: true,
        videoPost: true,
        messagePost: true,
        audioPost: false,
        albumPost: true,
        articlePost: true,
      );

  Future<FeedModel> _setupFeed() async {
    return await AbstractRepositorySingleton.singleton
        .feedRepository(app.documentID)!
        .add(feedModel());
  }

  Future<FeedModel> run() async {
    return await _setupFeed();
  }
}
