/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'post_like_list_bloc.dart';
import 'post_like_list_event.dart';
import 'post_like_list_state.dart';
import 'post_like_model.dart';

class PostLikeComponentSelector extends ComponentSelector {
  @override
  Widget createSelectWidget(BuildContext context, AppModel app, double height,
      SelectComponent selected, editorConstructor) {
    var appId = app.documentID!;
    return BlocProvider<PostLikeListBloc>(
          create: (context) => PostLikeListBloc(
            postLikeRepository:
                postLikeRepository(appId: appId)!,
          )..add(LoadPostLikeList()),
      child: SelectPostLikeWidget(app: app,
          height: height,
          selected: selected,
          editorConstructor: editorConstructor),
    );
  }
}

class SelectPostLikeWidget extends StatefulWidget {
  final AppModel app;
  final double height;
  final SelectComponent selected;
  final ComponentEditorConstructor editorConstructor;

  const SelectPostLikeWidget(
      {Key? key,
      required this.app,
      required this.height,
      required this.selected,
      required this.editorConstructor})
      : super(key: key);

  @override
  _SelectPostLikeWidgetState createState() {
    return _SelectPostLikeWidgetState();
  }
}

class _SelectPostLikeWidgetState extends State<SelectPostLikeWidget> {
  Widget theList(BuildContext context, List<PostLikeModel?> values) {
    var app = widget.app; 
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: values.length,
        itemBuilder: (context, index) {
          final value = values[index];
          if (value != null) {
            return getListTile(
              context,
              widget.app,
              trailing: PopupMenuButton<int>(
                  child: Icon(Icons.more_vert),
                  elevation: 10,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: text(widget.app, context, 'Add to page'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: text(widget.app, context, 'Update'),
                        ),
                      ],
                  onSelected: (selectedValue) {
                    if (selectedValue == 1) {
                      widget.selected(value.documentID!);
                    } else if (selectedValue == 2) {
                      widget.editorConstructor.updateComponent(widget.app, context, value, (_) {});
                    }
                  }),
              title: value.timestamp != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.timestamp!.toString())) : Container(),
              subtitle: value.documentID != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.documentID!)) : Container(),
            );
          } else {
            return Container();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostLikeListBloc, PostLikeListState>(
        builder: (context, state) {
      var children = <Widget>[];
      if ((state is PostLikeListLoaded) && (state.values != null)) {
        children.add(Container(
            height: widget.height - 45,
            child: theList(
              context,
              state.values!,
            )));
      } else {
        children.add(Container(
            height: widget.height - 45,
            ));
      }
      children.add(Column(children: [
        divider(widget.app, context),
        Center(
            child: iconButton(widget.app, 
          context,
          onPressed: () {
            widget.editorConstructor.createNewComponent(widget.app, context, (_) {});
          },
          icon: Icon(Icons.add),
        ))
      ]));
      return ListView(
          physics: ScrollPhysics(), shrinkWrap: true, children: children);
    });
  }
}



