import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_event.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_container_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_state.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:eliud_pkg_text/platform/widgets/bloc/html_with_platform_medium_component_bloc.dart';
import 'package:eliud_pkg_text/platform/widgets/html_text_dialog.dart';
import 'package:eliud_pkg_text/platform/widgets/html_util.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_core/core/registry.dart';
import 'bloc/post_medium_component_bloc.dart';

/*
 * Unfortunately this is a copy of HtmlWithPlatformMediumComponents from eliud_pkg_text. Copied because abstracting was too complex
 */
class PostWithMemberMediumComponents extends StatefulWidget {
  static Future<void> openIt(
    AppModel app,
    BuildContext context,
    PostModel model,
    EditorFeedback editorFeedback, {
    AddMediaHtml? addMediaHtml,
  }) async {
    await openComplexDialog(
      app,
      context,
      app.documentID + '/html_components',
      title: 'Images and Videos',
      includeHeading: false,
      widthFraction: .9,
      child: getWidget(app, context, model, editorFeedback,
          addMediaHtml: addMediaHtml),
    );
  }

  static Widget getWidget(
    AppModel app,
    BuildContext context,
    PostModel model,
    EditorFeedback editorFeedback, {
    AddMediaHtml? addMediaHtml,
  }) {
    return PointerInterceptor(
        child: BlocProvider<HtmlPostMediumBloc>(
            create: (context) => HtmlPostMediumBloc(
                  app.documentID,
                )..add(ExtEditorBaseInitialise<PostModel>(
                    model,
                    reretrieveModel: false)),
            child: PostWithMemberMediumComponents._(
              app: app,
              addMediaHtml: addMediaHtml,
              editorFeedback: editorFeedback,
            )));
  }

  final AppModel app;
  final AddMediaHtml? addMediaHtml;
  final EditorFeedback editorFeedback;

  const PostWithMemberMediumComponents._({
    Key? key,
    required this.app,
    this.addMediaHtml,
    required this.editorFeedback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _PostWithMemberMediumComponentsState();
}

class _PostWithMemberMediumComponentsState
    extends State<PostWithMemberMediumComponents> {
  double? uploadingProgress;
  Offset? onTapPosition;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HtmlPostMediumBloc,
            ExtEditorBaseState<PostModel>>(
        builder: (ppContext, htmlWithPMM) {
      if (htmlWithPMM
          is ExtEditorBaseInitialised<PostModel, dynamic>) {
        return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
          if (widget.addMediaHtml != null)
            HeaderWidget(
              title: 'Media',
              app: widget.app,
              okAction: () async {
                widget.editorFeedback(true, htmlWithPMM.model);
                return true;
              },
              cancelAction: () async {
                widget.editorFeedback(false, null);
                return true;
              },
            ),
          _images(context, htmlWithPMM.model, htmlWithPMM.model.memberMedia,
                  htmlWithPMM) ??
              text(widget.app, context, 'No media'),
        ]);
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }

  Widget? _images(
      BuildContext context,
      PostModel postModel,
      List<MemberMediumContainerModel>? memberMediumContainerModels,
      ExtEditorBaseInitialised htmlWithPMM) {
    var widgets = <Widget>[];
    if (memberMediumContainerModels != null) {
      for (var i = 0; i < memberMediumContainerModels.length; i++) {
        var item = memberMediumContainerModels[i];
        var medium = item.memberMedium;
        if (medium != null) {
          widgets.add(GestureDetector(
              onTapDown: (TapDownDetails details) => onTapPosition = details.globalPosition,
              onTap: () async {
                var x = onTapPosition == null
                    ? fullScreenWidth(context) / 2
                    : onTapPosition!.dx;
                var y = onTapPosition == null
                    ? fullScreenHeight(context) / 2
                    : onTapPosition!.dy;
                var value = await showMenu<int>(
                    context: context,
                    position: RelativeRect.fromLTRB(x, y, x, y),
                  items: [
                    if (widget.addMediaHtml != null)
                      PopupMenuItem<int>(child: const Text('Select'), value: 0),
                    if (widget.addMediaHtml == null)
                      PopupMenuItem<int>(child: const Text('View'), value: 1),
                    PopupMenuItem<int>(child: const Text('Move up'), value: 2),
                    PopupMenuItem<int>(
                        child: const Text('Move down'), value: 3),
                    PopupMenuItem<int>(
                        child: const Text('Delete'), value: 4),
                  ],
                  elevation: 8.0,
                );

                switch (value) {
                  case 0:
                    widget.editorFeedback(true, postModel);
                    if (medium.mediumType == MediumType.Photo) {
                      var htmlCode = constructHtmlForImg(medium.url!,
                          kDOCUMENT_LABEL_MEMBER, item.htmlReference!);
                      widget.addMediaHtml!(htmlCode);
                    } else {
                      var htmlCode = constructHtmlForVideo(medium.url!,
                          kDOCUMENT_LABEL_MEMBER, item.htmlReference!);
                      widget.addMediaHtml!(htmlCode);
                    }
                    Navigator.of(context).pop();
                    break;
                  case 1:
                    Registry.registry()!.getMediumApi().showPhotos(
                        context,
                        widget.app,
                        memberMediumContainerModels.map((e) => e.memberMedium!).toList(),
                        i);
                    break;
                  case 2:
                    BlocProvider.of<HtmlPostMediumBloc>(context).add(
                        HtmlMediaMoveEvent(
                            isUp: true, item: item));
                    break;
                  case 3:
                    BlocProvider.of<HtmlPostMediumBloc>(context).add(
                        HtmlMediaMoveEvent(
                            isUp: false, item: item));
                    break;
                  case 4:
                    if ((item.htmlReference == null) || ((htmlWithPMM.model.html != null) && (!htmlWithPMM.model.html.contains(item.htmlReference)))) {
                      BlocProvider.of<HtmlPostMediumBloc>(context).add(
                          DeleteItemEvent<PostModel,
                              MemberMediumContainerModel>(
                              itemModel: item));
                    } else {
                      openErrorDialog(widget.app, context, widget.app.documentID + '/_error', title: 'Problem', errorMessage: "This medium is used in the html so I can't delete it");
                    }
                    break;
                }
              },
              child: Tooltip(
                  message: _message(item), child : (item == htmlWithPMM.currentEdit
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      child: Image.network(
                        medium.urlThumbnail!,
                        //            height: height,
                      ))
                  : Image.network(
                      medium.urlThumbnail!,
                      //            height: height,
                    )))));
        }
      }
      if (uploadingProgress == null) {
        widgets.add(MediaButtons.mediaButtons(
          context,
          widget.app,
          () => Tuple2(postModel.accessibleByGroup == null ? MemberMediumAccessibleByGroup.Public : toMemberMediumAccessibleByGroup(postModel.accessibleByGroup!.index),
              postModel.accessibleByMembers),
          allowCrop: false,
          tooltip: 'Add photo',
          photoFeedbackFunction: (photo) {
            if (photo != null) {
              var newKey = newRandomKey();
              BlocProvider.of<HtmlPostMediumBloc>(context).add(AddItemEvent(
                  itemModel: MemberMediumContainerModel(
                      documentID: newKey,
                      htmlReference: newKey,
                      memberMedium: photo)));
            }
            uploadingProgress = null;
          },
          photoFeedbackProgress: (progress) {
            setState(() {
              uploadingProgress = progress;
            });
          },
          videoFeedbackFunction: (video) {
            if (video != null) {
              var newKey = newRandomKey();
              BlocProvider.of<HtmlPostMediumBloc>(context).add(AddItemEvent(
                  itemModel: MemberMediumContainerModel(
                      documentID: newKey,
                      htmlReference: newKey,
                      memberMedium: video)));
            }
            uploadingProgress = null;
          },
          videoFeedbackProgress: (progress) {
            setState(() {
              uploadingProgress = progress;
            });
          },
          icon: Icon(
            Icons.add,
          ),
        ));
      } else {
        widgets.add(progressIndicatorWithValue(widget.app, context,
            value: uploadingProgress!));
      }

      return GridView.extent(
          maxCrossAxisExtent: 200,
          padding: const EdgeInsets.all(0),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          physics: const ScrollPhysics(),
          // to disable GridView's scrolling
          shrinkWrap: true,
          children: widgets);
    } else {
      return null;
    }
  }

  String _message(MemberMediumContainerModel? item) {
    if (item == null) {
      return '?';
    } else {
      return (((item.memberMedium == null) || (item.memberMedium!.base == null)) ? 'no name' : item.memberMedium!.base!) + '.' + (((item.memberMedium == null) || (item.memberMedium!.ext == null)) ? 'no ext' : item.memberMedium!.ext!);
    }
  }
}
