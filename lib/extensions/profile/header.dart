import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_pkg_feed/extensions/profile/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/profile/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/util/editable_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/mediua_buttons.dart';
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
  static double heightBackgroundPhoto(BuildContext context) =>
      MediaQuery.of(context).size.height / 2.5;
  static double heightText = 66;
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
      bool isEditable, ProfileInitialised profileInitialised) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 110, maxHeight: 110),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 110, maxHeight: 110),
                        child: switchFeedHelper.getFeedWidget2(context, 39,
                            backgroundColor: Colors.black,
                            backgroundColor2: Colors.white))),
                Align(
                  alignment: Alignment.topRight,
                  child: EditableButton2(
                      button: _button(context, profileInitialised)),
                ) // EditableButton(editFunction: () {})
              ],
            )));
  }

  //
  Widget _container(BuildContext context, SwitchFeedHelper switchFeedHelper,
      bool isEditable, ProfileInitialised profileInitialised) {
    return Container(
        height: heightBackgroundPhoto(context),
        child: _profileWidget(
            context, switchFeedHelper, isEditable, profileInitialised));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // this container creates the space until blocbuilder has retrieved the data and image has been downloaded, preventing the screen to jump
        height: heightBackgroundPhoto(context) + heightText,
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileError) return Text("No profile");
          if (state is ProfileInitialised) {
            List<Widget> allRows = [];
            var isEditable = state.allowedToUpdate();

            // Construct profile photo + background photo
            List<Widget> rows = [];
            rows.add(
                _container(context, state.switchFeedHelper, isEditable, state));

            // Add the profile photo + background photo
            allRows.add(EditableWidget2(
              child: PostHelper.getFormattedPost(rows,
                  image: _background(context, state.memberProfileModel)),
              button: _button(context, state),
            ));

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
        }));
  }

  Widget _button(BuildContext context, ProfileInitialised profileInitialised) {
    return MediaButtons.mediaButtons(
        context,
        profileInitialised.appId,
        profileInitialised.switchFeedHelper.memberOfFeed.documentID!,
        profileInitialised.readAccess(), photoFeedbackFunction: (photo) {
      //
    },
        photoFeedbackProgress: _photoUploading,
        icon: Icon(Icons.edit, size: 14, color: Colors.white));
  }

  void _photoUploading(double progress) {
/*
    BlocProvider.of<FeedPostFormBloc>(context).add(UploadingMedium(progress: progress));
    setState(() {});
*/
  }
}
