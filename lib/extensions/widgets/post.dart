import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/components/page_body_helper.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/page_component_bloc.dart';
import 'package:eliud_core/model/page_component_event.dart';
import 'package:eliud_core/model/page_component_state.dart';
import 'package:eliud_pkg_feed/constants/size.dart';
import 'package:eliud_pkg_feed/extensions/widgets/rounded_avatar.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'comment.dart';

class Post extends StatelessWidget {
  final bool recursive;
  final PostModel post;
  Size size;

  Post(
    this.post, {
    Key key,
    this.recursive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;
    var originalAccessBloc = BlocProvider.of<AccessBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        recursive
            ? Text(
                "This link is a reference to this feed. I'm not show recursive pages.")
            : _postDetails(originalAccessBloc, context),
        _postActionBtns(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postActionBtns() {
    return Row(
      children: <Widget>[
        IconButton(
            icon: ImageIcon(
              AssetImage("assets/images/basicons.xyz/ThumbsUp.png",
                  package: "eliud_pkg_feed"),
            ),
            onPressed: null,
            color: Colors.black),

        Spacer(),
        IconButton(
            icon: ImageIcon(
              AssetImage(
                  "assets/images/basicons.xyz/CommentCircleChatMessage.png",
                  package: "eliud_pkg_feed"),
            ),
            onPressed: null,
            color: Colors.black),

        Spacer(),
        IconButton(
            icon: ImageIcon(
              AssetImage("assets/images/basicons.xyz/Forward.png",
                  package: "eliud_pkg_feed"),
            ),
            onPressed: null,
            color: Colors.black),
        // if thumbsdown is allowed?
        Spacer(),
        IconButton(
            icon: ImageIcon(
              AssetImage("assets/images/basicons.xyz/ThumbsDown.png",
                  package: "eliud_pkg_feed"),
            ),
            onPressed: null,
            color: Colors.black),
      ],
    );
  }

  Widget _postHeader() {
    String formattedDate = post.timestamp;
    var children2 = [
      Padding(
        padding: const EdgeInsets.all(COMMON_XXS_GAP),
        child: RoundedAvatar(),
      ),
      Expanded(child: Text(formattedDate)),
      IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: null,
      )
    ];
    return Row(
      children: children2,
    );
  }

/*
  Widget _postImage() {
    return CachedNetworkImage(
        imageUrl: "https://picsum.photos/600/600?random=0",
        placeholder: (BuildContext context, String url) {
          return LodingIndicator(
            containerSize: size.width,
            progressSize: 80,
          );
        },
        imageBuilder: (
          BuildContext context,
          ImageProvider imageProvider,
        ) {
          return AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ));
        });
  }



*/
  Widget _postDetails(AccessBloc originalAccessBloc, BuildContext context) {
    String appId = post.postAppId;
    String pageId = post.postPageId;
    Map<String, Object> parameters = post.pageParameters;
    //var navigatorBloc; //NavigatorBloc(navigatorKey: navigatorKey);
    var asPlaystore = false;
    // BlocProvider.of<NavigatorBloc>(context)
    var blocProviders = <BlocProvider>[];
    blocProviders.add(BlocProvider<AccessBloc>(
        create: (context) =>
            AccessBloc(null)..add(InitApp(appId, asPlaystore))));
    //blocProviders.add(BlocProvider<NavigatorBloc>(create: (context) => navigatorBloc));
    return MultiBlocProvider(
        providers: blocProviders,
        child: BlocBuilder<AccessBloc, AccessState>(builder: (context, state) {
          if (state is AppLoaded) {
            return BlocBuilder<AccessBloc, AccessState>(
                builder: (accessContext, accessState) {
              if (accessState is AppLoaded) {
                return Container(
                    height: 300,
                    child: _body(context, originalAccessBloc, accessState,
                        appId, pageId, parameters));
              } else {
                return Center(
                  child: DelayedCircularProgressIndicator(),
                );
              }
            });
          } else {
            return Center(
              child: DelayedCircularProgressIndicator(),
            );
          }
        }));
  }

  Widget _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: COMMON_GAP),
      child: Text(
        "12000 likes",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _postCaption() {
    return Comment(
        showImage: false,
        username: "someone",
        text: "Hello, World. I want to make a lot of money!");
  }

  Widget _body(
      BuildContext context,
      AccessBloc originalAccessBloc,
      AccessState accessState,
      String appId,
      String pageId,
      Map<String, Object> parameters) {
    return Stack(
      children: <Widget>[
        MultiBlocProvider(
            providers: [
              BlocProvider<PageComponentBloc>(
                create: (context) => PageComponentBloc(
                    pageRepository: pageRepository(appId: appId))
                  ..add(FetchPageComponent(id: pageId)),
              ),
            ],
            child: BlocBuilder<PageComponentBloc, PageComponentState>(
                builder: (context, state) {
              if (state is PageComponentLoaded) {
                if (state.value == null) {
                  return AlertWidget(
                      title: 'Error', content: 'No page defined');
                } else {
                  var helper = PageBodyHelper();
                  var components = helper.getComponents(
                      state.value.bodyComponents, parameters);
                  return helper.theBody(context, accessState,
                      backgroundDecoration: state.value.background,
                      components: components,
                      layout: fromPageLayout(state.value.layout),
                      gridView: state.value.gridView);
                }
              } else {
                return Center(
                  child: DelayedCircularProgressIndicator(),
                );
              }
            })),
        InkWell(
            onTap: () {
              originalAccessBloc
                  .add(SwitchAppAndPageEvent(appId, pageId, parameters));
            },
            child: new Container(
              width: 1000,
              height: 1000,
//            color: Colors.green,
            ))
      ],
    );
  }
}
