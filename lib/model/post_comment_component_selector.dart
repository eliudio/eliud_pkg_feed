/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/blocs/access/access_bloc.dart';
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
import 'post_comment_list_bloc.dart';
import 'post_comment_list_event.dart';
import 'post_comment_list_state.dart';
import 'post_comment_model.dart';

class PostCommentComponentSelector extends ComponentSelector {
  @override
  Widget createSelectWidget(BuildContext context, double height,
      SelectComponent selected, editorConstructor) {
    return BlocProvider<PostCommentListBloc>(
          create: (context) => PostCommentListBloc(
            postCommentRepository:
                postCommentRepository(appId: AccessBloc.currentAppId(context))!,
          )..add(LoadPostCommentList()),
      child: SelectPostCommentWidget(
          height: height,
          selected: selected,
          editorConstructor: editorConstructor),
    );
  }
}

class SelectPostCommentWidget extends StatefulWidget {
  final double height;
  final SelectComponent selected;
  final ComponentEditorConstructor editorConstructor;

  const SelectPostCommentWidget(
      {Key? key,
      required this.height,
      required this.selected,
      required this.editorConstructor})
      : super(key: key);

  @override
  _SelectPostCommentWidgetState createState() {
    return _SelectPostCommentWidgetState();
  }
}

class _SelectPostCommentWidgetState extends State<SelectPostCommentWidget> {
  Widget theList(BuildContext context, List<PostCommentModel?> values) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: values.length,
        itemBuilder: (context, index) {
          final value = values[index];
          if (value != null) {
            return getListTile(
              context,
              trailing: PopupMenuButton<int>(
                  child: Icon(Icons.more_vert),
                  elevation: 10,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: text(context, 'Add to page'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: text(context, 'Update'),
                        ),
                      ],
                  onSelected: (selectedValue) {
                    if (selectedValue == 1) {
                      widget.selected(value.documentID!);
                    } else if (selectedValue == 2) {
                      widget.editorConstructor.updateComponent(context, value, (_) {});
                    }
                  }),
              title: value.timestamp != null ? Center(child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, value.timestamp!.toString())) : Container(),
              subtitle: value.documentID != null ? Center(child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, value.documentID!)) : Container(),
            );
          } else {
            return Container();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCommentListBloc, PostCommentListState>(
        builder: (context, state) {
      if (state is PostCommentListLoading) {
        return progressIndicator(context);
      } else if (state is PostCommentListLoaded) {
        if (state.values == null) {
          return text(context, 'No items');
        } else {
          var children = <Widget>[];
          children.add(Container(
              height: widget.height - 45,
              child: theList(
                context,
                state.values!,
              )));
          children.add(Column(children: [
            divider(context),
            Center(
                child: iconButton(
              context,
              onPressed: () {
                widget.editorConstructor.createNewComponent(context, (_) {});
              },
              icon: Icon(Icons.add),
            ))
          ]));
          return ListView(
              physics: ScrollPhysics(), shrinkWrap: true, children: children);
        }
      }
      return Text("nothing");
    });
  }
}



