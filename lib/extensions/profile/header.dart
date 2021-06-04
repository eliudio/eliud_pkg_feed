import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_pkg_feed/extensions/profile/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/profile/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/util/editable_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';

class Header extends StatefulWidget {
  Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height / 2.5;
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // Profile Background
  ImageProvider _defaultBackgroundPhoto(BuildContext context) {
    return AssetImage(
        'assets/images/pexels.com/pexels-bri-schneiter-346529.jpg',
        package: "eliud_pkg_feed");
  }

  ImageProvider _backgroundPhoto(BuildContext context, String? url) {
    return Image.network(url!).image;
  }

  bool _hasProfileBackground(MemberProfileModel? memberProfileModel) {
    return ((memberProfileModel != null) &&
        (memberProfileModel!.profileBackground != null) &&
        (memberProfileModel.profileBackground!.url != null));
  }

  DecorationImage _background(
      BuildContext context, MemberProfileModel? memberProfileModel) {
    if (!_hasProfileBackground(memberProfileModel)) {
      return DecorationImage(
          image: _defaultBackgroundPhoto(context), fit: BoxFit.cover);
    } else {
      return DecorationImage(
          image: _backgroundPhoto(
              context, memberProfileModel!.profileBackground!.url),
          fit: BoxFit.cover);
    }
  }

  // Profile photo
  Widget _profileWidget(BuildContext context, SwitchFeedHelper switchFeedHelper,
      bool isEditable) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 130, maxHeight: 130),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 130, maxHeight: 130),
                        child: switchFeedHelper.getFeedWidget2(context, 45,
                            backgroundColor: Colors.black,
                            backgroundColor2: Colors.white))),
                Align(
                  alignment: Alignment.topRight,
                  child: EditableButton(
                    editFunction: () {},
                  ),
                )// EditableButton(editFunction: () {})
              ],
            )));
/*
    var avatar = Align(
        alignment: Alignment.bottomCenter,
        child: switchFeedHelper.getFeedWidget2(context, 45,
            backgroundColor: Colors.black, backgroundColor2: Colors.white));
*/
/*

        EditableWidget(
            child: x,
            editFunction: isEditable ? () {} : null));
*/
  }

  //
  Widget _container(BuildContext context, SwitchFeedHelper switchFeedHelper,
      bool isEditable) {
    return Container(
            height: height(context),
            width: width(context),
            child: EditableWidget(
                child: _profileWidget(context, switchFeedHelper, isEditable),
        editFunction: isEditable ? () {} : null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileError) return Text("No profile");
      if (state is ProfileInitialised) {
        List<Widget> allRows = [];
        var isEditable = state.allowedToUpdate();

        // Construct profile photo + background photo
        List<Widget> rows = [];
        rows.add(_container(context, state.switchFeedHelper, isEditable));

        // Add the profile photo + background photo
        allRows.add(PostHelper.getFormattedPost(rows,
            image: _background(context, state.memberProfileModel)));

        // Add the name
        allRows.add(Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              state.switchFeedHelper.memberOfFeed.name!,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )));
        return Column(children: allRows);
      }
      return Center(child: DelayedCircularProgressIndicator());
    });
  }
}
