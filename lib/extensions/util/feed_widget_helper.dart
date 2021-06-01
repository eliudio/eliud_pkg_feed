import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:flutter/material.dart';

typedef Widget WidgetProvider(SwitchFeedHelper switchFeedHelper);

class FeedWidgetHelper extends StatefulWidget {
  final WidgetProvider widgetProvider;

  FeedWidgetHelper({Key? key, required this.widgetProvider}) : super(key: key);

  @override
  _FeedWidgetHelperState createState() => _FeedWidgetHelperState();
}

class _FeedWidgetHelperState extends State<FeedWidgetHelper> {
  @override
  Widget build(BuildContext context) {
      AccessState state = AccessBloc.getState(context);
      var pageContextInfo = PageParamHelper.getPagaContextInfo(context);
      if (state is LoggedIn) {
        return FutureBuilder<SwitchFeedHelper>(
            future: SwitchFeedHelper.construct(pageContextInfo, state),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SwitchFeedHelper switchFeedHelper = snapshot.data!;
                return widget.widgetProvider(switchFeedHelper);
              }
              return Center(child: DelayedCircularProgressIndicator());
            }
        );
      } else if (state is AppLoaded) {
        return Text("No feed, not logged in");
      } else {
        return Center(child: DelayedCircularProgressIndicator());
      }
  }
}
