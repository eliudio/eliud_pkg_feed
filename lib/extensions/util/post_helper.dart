import 'package:eliud_core_main/storage/medium_base.dart';
import 'package:eliud_pkg_feed_model/model/post_model.dart';

typedef PhotoWithThumbnailTrigger = Function(
    PostModel postModel, PhotoWithThumbnail photoWithThumbnail);
typedef VideoWithThumbnailTrigger = Function(
    PostModel postModel, VideoWithThumbnail videoWithThumbnail);

typedef EditAction = void Function();
