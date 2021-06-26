import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/editable_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/media_buttons.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatefulWidget {
  Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  double? progressProfilePhoto;
  double? progressProfileVideo;

  static double heightBackgroundPhoto(BuildContext context) =>
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
        (memberProfileModel.profileBackground != null) &&
        (memberProfileModel.profileBackground!.url != null));
  }

  DecorationImage? _background(
      BuildContext context, MemberProfileModel? memberProfileModel) {
    if (memberProfileModel == null) return null;
    if (!_hasProfileBackground(memberProfileModel)) {
      return DecorationImage(
          image: _defaultBackgroundPhoto(context), fit: BoxFit.cover);
    } else {
      return DecorationImage(
          image: _backgroundPhoto(
              context, memberProfileModel.profileBackground!.url),
          fit: BoxFit.cover);
    }
  }

  Widget _progress(
      Widget original, double? progress, double height, double width) {
    if (progress == null) {
      return original;
    } else {
      return Stack(children: [
        original,
        Container(
            height: height,
            child: Align(
                alignment: Alignment.center,
                child: Container(
                    width: width,
                    child:
                        LinearProgressIndicator(value: progressProfileVideo))))
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var pageContextInfo = PageParamHelper.getPagaContextInfo(context);
    var pageId = pageContextInfo.pageId;
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileError)
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .h5(context, 'No profile');
      if (state is ProfileInitialised) {
        List<Widget> allRows = [];

        // Add profile photo
        List<Widget> rows = [];

        var memberId = state.memberId();
        if (memberId != null) {
          var avatarWidget = _progress(
            Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 110, maxHeight: 110),
                  child: AvatarHelper.avatar(
                      context,
                      55,
                      pageId,
                      memberId,
                      state.profileUrl(),
                      state.appId,
                      state.feedId),
                )),
            progressProfilePhoto,
            110,
            70,
          );
          var container = Container(
              height: heightBackgroundPhoto(context),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 110, maxHeight: 110),
                    child: state.canEditThisProfile()
                        ? Stack(
                      children: [
                        avatarWidget,
                        Align(
                          alignment: Alignment.topRight,
                          child: EditableButton(
                              button: _button(
                                  context,
                                  state,
                                  false,
                                  'Update profile photo',
                                      (progress) =>
                                      setState(() {
                                        progressProfilePhoto = progress;
                                      }))),
                        ) // EditableButton(editFunction: () {})
                      ],
                    )
                        : avatarWidget),
              ));
          rows.add(container);

        // Add the background photo
        allRows.add(EditableWidget(
            child: _progress(
                StyleRegistry.registry()
                    .styleWithContext(context)
                    .frontEndStyle()
                    .containerStyle()
                    .topicContainer(context,
                        children: rows,
                        image: _background(context, state.watchingThisProfile())),
                progressProfileVideo,
                heightBackgroundPhoto(context),
                width(context) / 2),
            button: _button(
                context,
                state,
                true,
                'Update profile background',
                (progress) => setState(() {
                      progressProfileVideo = progress;
                    }))));
        }

        var name;
        var watchingThisProfile = state.watchingThisProfile();
        if ((watchingThisProfile != null) && (watchingThisProfile.author != null)) {
          name = watchingThisProfile.author!.name!;
        } else {
          name = 'PUBLIC';
        }
        // Add the name
        allRows.add(Align(
            alignment: Alignment.bottomCenter,
            child: StyleRegistry.registry()
                .styleWithContext(context)
                .frontEndStyle()
                .containerStyle()
                .actionContainer(context,
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: StyleRegistry.registry()
                            .styleWithContext(context)
                            .frontEndStyle()
                            .textStyle()
                            .h1(
                              context,
                              name,
                            )))));
        return Column(children: allRows);
      }
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .progressIndicatorStyle()
          .progressIndicator(context);
    });
  }

  Widget _button(BuildContext context, ProfileInitialised profileInitialised,
      bool isBG, String tooltip, FeedbackProgress progressFct) {
    return MediaButtons.mediaButtons(
        context,
        profileInitialised.appId,
        profileInitialised.watchingThisProfile()!.author!.documentID!,
        profileInitialised.watchingThisProfile()!.readAccess!,
        allowCrop: !isBG,
        tooltip: tooltip, photoFeedbackFunction: (photo) {
      if (!isBG) {
        BlocProvider.of<ProfileBloc>(context)
            .add(ProfilePhotoChangedProfileEvent(photo));
      } else {
        BlocProvider.of<ProfileBloc>(context)
            .add(ProfileBGPhotoChangedProfileEvent(photo));
      }
      progressProfilePhoto = null;
      progressProfileVideo = null;
    }, photoFeedbackProgress: progressFct, icon: getEditIcon());
  }
}
