import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/album_component.dart';
import 'package:eliud_pkg_feed/model/album_model.dart';
import 'package:eliud_pkg_feed/model/album_repository.dart';
import 'post/post_contents_widget.dart';
import 'package:flutter/material.dart';

class AlbumComponentConstructorDefault implements ComponentConstructor {
  AlbumComponentConstructorDefault();

  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return AlbumComponent(id: id);
  }
}

class AlbumComponent extends AbstractAlbumComponent {
  String? parentPageId;

  AlbumComponent({String? id}) : super(albumID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, AlbumModel? albumModel) {
    if (albumModel == null) return Text("Album is not avalable");
    var accessBloc = AccessBloc.getBloc(context);
    var member = AccessBloc.memberFor(AccessBloc.getState(context));
    var postModel = albumModel.post;
    if (postModel == null) {
      print("postModel is null");
    } else {
      print("postModel is not null");
    }

    return PostContentsWidget(
      member: member,
      postModel: postModel,
      accessBloc: accessBloc,
      parentPageId: null,
    );
  }

  @override
  AlbumRepository getAlbumRepository(BuildContext context) {
    return albumRepository(appId: AccessBloc.appId(context))!;
  }
}