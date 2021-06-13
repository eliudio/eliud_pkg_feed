import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/components/util/component_info.dart';
import 'package:eliud_core/core/components/util/page_body.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/page_component_bloc.dart';
import 'package:eliud_core/model/page_component_event.dart';
import 'package:eliud_core/model/page_component_state.dart';
import 'package:eliud_core/tools/registry.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmbeddedPageHelper {
  static Widget postDetails(String? memberId, PostModel? postModel,
      AccessBloc? originalAccessBloc, BuildContext? context, String parentPageId) {
    if (postModel == null) return Text("Can't construct post details without postModel");
    if ((postModel.appId == postModel.postAppId) && (postModel.postPageId == parentPageId)) return Text("Not showing recursive posts");
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

  static Widget _body(
      BuildContext context,
      AccessBloc? originalAccessBloc,
      AccessState? accessState,
      String? appId,
      String? pageId,
      Map<String, dynamic>? parameters) {
    if (accessState == null) return Text("Access state is not available");
    if (accessState is AppLoaded) {
      return Stack(
        children: <Widget>[
          MultiBlocProvider(
              providers: [
                BlocProvider<PageComponentBloc>(
                  create: (context) =>
                  PageComponentBloc(
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
                        var componentInfo = ComponentInfo.getComponentInfo(
                            state.value!.bodyComponents!, parameters,
                            accessState, fromPageLayout(state.value!.layout),
                            state.value!.backgroundOverride, state.value!.gridView);
                        var widget;
                        if (state.value!.widgetWrapper != null) {
                          widget = Registry.registry()!.wrapWidgetInBloc(
                              state.value!.widgetWrapper!, context,
                              componentInfo);
                        }
                        if (widget == null) {
                          return PageBody(componentInfo: componentInfo,);
                        } else {
                          return widget;
                        }
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
    } else {
      return Text("App loaded");
    }
  }

}
