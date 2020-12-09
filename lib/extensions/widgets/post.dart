import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/components/page_body_helper.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/page_component_bloc.dart';
import 'package:eliud_core/model/page_component_event.dart';
import 'package:eliud_core/model/page_component_state.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_pkg_feed/constants/size.dart';
import 'package:eliud_pkg_feed/extensions/widgets/rounded_avatar.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliud_router;

import 'comment.dart';

class Post extends StatelessWidget {
  final PostModel post;
  Size size;

  Post(
    this.post, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postDetails(context),
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
            icon: Icon(Icons
                .add) /*ImageIcon(
              AssetImage("assets/images/heart_selected.png"),
            )*/
            ,
            onPressed: null,
            color: Colors.black87),
        IconButton(
            icon: Icon(Icons
                .add) /*ImageIcon(
              AssetImage("assets/images/comment.png"),
            )*/
            ,
            onPressed: null,
            color: Colors.black87),
        IconButton(
            icon: Icon(Icons
                .add) /*ImageIcon(
              AssetImage("assets/images/direct_message.png"),
            )*/
            ,
            onPressed: null,
            color: Colors.black87),
        Spacer(),
        IconButton(
            icon: Icon(Icons
                .add) /*ImageIcon(
              AssetImage("assets/images/bookmark.png"),
            )*/
            ,
            onPressed: null,
            color: Colors.black87),
      ],
    );
  }

  Widget _postHeader() {
    var children2 = [
      Padding(
        padding: const EdgeInsets.all(COMMON_XXS_GAP),
        child: RoundedAvatar(),
      ),
      Expanded(child: Text("username")),
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
  Widget _postDetails(BuildContext context) {
    String appId = post.postAppId;
    String pageId = post.postPageId;
    Map<String, Object> parameters = post.pageParameters;
    var navigatorBloc; //NavigatorBloc(navigatorKey: navigatorKey);
    var asPlaystore = false;
    var blocProviders = <BlocProvider>[];
    blocProviders.add(BlocProvider<AccessBloc>(
        create: (context) =>
            AccessBloc(navigatorBloc)..add(InitApp(appId, asPlaystore))));
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
                    child:
                        _body(context, accessState, appId, pageId, parameters));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
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
        username: "sjquant",
        text: "Hello, World. I want to make a lot of money!");
  }

  Widget _body(BuildContext context, AccessState accessState, String appId,
      String pageId, Map<String, Object> parameters) {
    return Stack(
      children: <Widget>[
        MultiBlocProvider(
            providers: [
              BlocProvider<PageComponentBloc>(
                create: (context) => PageComponentBloc(
                    pageRepository: AbstractRepositorySingleton.singleton
                        .pageRepository(appId))
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
                  return helper.body(context, accessState,
                      backgroundDecoration: state.value.background,
                      components: components,
                      pageModel: state.value);
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
        InkWell(
            onTap: () {
              var gotoPage = GotoPage(appId, pageID: pageId);
              eliud_router.Router.navigateTo(context, gotoPage, parameters: parameters);
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
