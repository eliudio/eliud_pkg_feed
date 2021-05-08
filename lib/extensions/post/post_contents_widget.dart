import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/components/page_body_helper.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/page_component_bloc.dart';
import 'package:eliud_core/model/page_component_event.dart';
import 'package:eliud_core/model/page_component_state.dart';
import 'package:eliud_pkg_feed/tools/grid/photos_page.dart';
import 'package:eliud_pkg_feed/tools/grid/videos_page.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/filter_member_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContentsWidget extends StatefulWidget {
  final MemberModel? member;
  final PostModel? postModel;
  final AccessBloc? accessBloc;

  const PostContentsWidget({Key? key, this.member, this.postModel, this.accessBloc}) : super(key: key);

  @override
  _PostContentsWidgetState createState() {
    return _PostContentsWidgetState();
  }
}

class _PostContentsWidgetState extends State<PostContentsWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.postModel == null) return Text("No post defined");
    List<Tab> tabs = [];
    List<Widget> tabBarViewContents = [];

    Widget? singleWidget;
    Widget? postWidget;
    Widget? photosWidget;
    Widget? videosWidget;
    Widget? linkWidget;

    if (widget.postModel!.postPageId != null) {
      if (widget.member != null) {
        singleWidget = postWidget =
            _postDetails(widget.member!.documentID, widget.postModel,
                widget.accessBloc, context);
      }
    }

    if (widget.postModel!.memberMedia != null) {
      print("memberMedia");
      // Photos
      var filterMemberMedia = FilterMemberMedia(widget.postModel!.memberMedia!);

      var photos = filterMemberMedia.getPhotos();
      var videos = filterMemberMedia.getVideos();

      if (photos != null) {
        singleWidget = photosWidget =
            PhotosPage(memberMedia: photos,);
      }

      if (videos != null) {
        singleWidget = videosWidget =
            VideosPage(memberMedia: videos,);
      }
    }

/*
    // delaying the implementation of the externalLink, until I can test the webview for flutterweb
    if (state.postModel.externalLink != null) {
      singleWidget = linkWidget = WebView(
        initialUrl: state.postModel.externalLink,
        javascriptMode: JavascriptMode.unrestricted,
      );
    }

*/
    if (photosWidget != null) {
      print("photosWidget");
      tabs.add(Tab(icon: Icon(Icons.image, color: Colors.black),));
      tabBarViewContents.add(photosWidget);
    }

    if (videosWidget != null) {
      print("videosWidget");
      tabs.add(Tab(icon: Icon(Icons.movie, color: Colors.black),));
      tabBarViewContents.add(videosWidget);
    }

    if (linkWidget != null) {
      print("linkWidget");
      tabs.add(Tab(icon: Icon(Icons.link, color: Colors.black),));
      tabBarViewContents.add(linkWidget);
    }

    if (postWidget != null) {
      print("postWidget");
      tabs.add(Tab(icon: Icon(Icons.source, color: Colors.black,),));
      tabBarViewContents.add(postWidget);
    }

    if (tabs.length == 0) {
      return Text("No contents");
    }

    if (tabs.length == 1) {
      if (singleWidget != null)
        return singleWidget;
    } else {
      print("container");
      return Container(height: 500, child: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                    child: TabBar(
                        tabs: tabs
                    )
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                  children: tabBarViewContents
              ),
            ),
          ],
        ),
      ));
    }
    return Text("Could not create widget");
  }

  Widget _postDetails(String? memberId, PostModel? postModel,
      AccessBloc? originalAccessBloc, BuildContext? context) {
    if (postModel == null) return Text("Can't construct post details without postModel");
    String? appId = postModel.postAppId;
    String? pageId = postModel.postPageId;
    var parameters = postModel.pageParameters;
    var asPlaystore = false;
    var blocProviders = <BlocProvider>[];
    blocProviders.add(BlocProvider<AccessBloc>(
        create: (context) =>
        AccessBloc(null)..add(InitApp(appId, asPlaystore))));
    return MultiBlocProvider(
        providers: blocProviders,
        child: Container(
            child: BlocBuilder<AccessBloc, AccessState>(
                builder: (context, accessState) {
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
                })));
  }

  Widget _body(
      BuildContext context,
      AccessBloc? originalAccessBloc,
      AccessState? accessState,
      String? appId,
      String? pageId,
      Map<String, dynamic>? parameters) {
    if (accessState == null) return Text("Access state is not avalable");
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
                      var components = helper.getComponentInfo(
                          state.value!.bodyComponents, parameters).widgets;
                      return helper.theBody(context, accessState,
                          backgroundDecoration: state.value!.background,
                          components: components,
                          layout: fromPageLayout(state.value!.layout),
                          gridView: state.value!.gridView);
                    }
                  } else {
                    return Center(
                      child: DelayedCircularProgressIndicator(),
                    );
                  }
                })),
        InkWell(
            onTap: () {
              if (originalAccessBloc != null)
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
