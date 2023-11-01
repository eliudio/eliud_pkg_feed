import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

typedef PhotoWithThumbnailTrigger(
    PostModel postModel, PhotoWithThumbnail photoWithThumbnail);
typedef VideoWithThumbnailTrigger(
    PostModel postModel, VideoWithThumbnail videoWithThumbnail);

typedef void EditAction();

