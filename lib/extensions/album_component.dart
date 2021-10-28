import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_pkg_feed/extensions/util/post_contents_widget.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/album_component.dart';
import 'package:eliud_pkg_feed/model/album_model.dart';
import 'package:eliud_pkg_feed/model/album_repository.dart';
import 'package:flutter/material.dart';

class AlbumComponentConstructorDefault implements ComponentConstructor {
  AlbumComponentConstructorDefault();

  @override
  Widget createNew({Key? key, required String id, Map<String, dynamic>? parameters}) {
    return AlbumComponent(key: key, id: id);
  }

  @override
  Future<dynamic> getModel({required String appId, required String id}) async => await albumRepository(appId: appId)!.get(id);
}

class AlbumComponent extends AbstractAlbumComponent {
  String? parentPageId;

  AlbumComponent({Key? key, required String id}) : super(key: key, albumID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, AlbumModel? albumModel) {
    if (albumModel == null) {
      return text(context, "Album is not avalable");
    }
    var accessBloc = AccessBloc.getBloc(context);
    var member = AccessBloc.memberFor(AccessBloc.getState(context));
    var postModel = albumModel.post;
    if (postModel == null) {
      return text(context, 'No post');
    } else {
      return topicContainer(context, children: [PostContentsWidget(
        memberID: member!.documentID!,
        postModel: postModel,
        accessBloc: accessBloc,
        parentPageId: null,
      )]);
    }
  }



  @override
  AlbumRepository getAlbumRepository(BuildContext context) {
    return albumRepository(appId: AccessBloc.appId(context))!;
  }
}
