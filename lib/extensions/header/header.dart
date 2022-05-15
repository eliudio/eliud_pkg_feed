import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/editable_widget.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class Header extends StatefulWidget {
  final AppModel app;
  final BackgroundModel? backgroundOverride;
  Header({Key? key, required this.app, required this.backgroundOverride}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  static double NOT_UPLOADING = -2.0;

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
    if ((progress == null) || (progress == NOT_UPLOADING)) {
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
                    child: LinearProgressIndicator(
                        value: progress >= 0 ? progress : null))))
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is AccessDetermined) {
        var pageContextInfo = eliudrouter.Router.getPageContextInfo(context);
        var pageId = pageContextInfo.pageId;
        return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
          if (state is ProfileError)
            return h5(widget.app, context, 'No profile');
          if (state is ProfileInitialised) {
            List<Widget> allRows = [];

            // Add profile photo
            List<Widget> rows = [];

            var currentMemberId = state.memberId();
            var memberId = state.watchingThisMember();
            if (memberId != null) {
              var avatarWidget = _progress(
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 110, maxHeight: 110),
                      child: AvatarHelper.avatar(context, 55, pageId, memberId,
                          currentMemberId, widget.app, state.feedId),
                    )),
                state.uploadingProfilePhotoProgress,
                110,
                70,
              );
              var container = Container(
                  height: heightBackgroundPhoto(context),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 110, maxHeight: 110),
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
                                    )),
                                  ) // EditableButton(editFunction: () {})
                                ],
                              )
                            : avatarWidget),
                  ));
              rows.add(container);
              var backgroundPhoto = topicContainer(widget.app, context,
                  children: rows,
                  backgroundOverride: widget.backgroundOverride,
                  image: _background(context, state.watchingThisProfile()));

              // Add the background photo
              if (state.canEditThisProfile()) {
                allRows.add(EditableWidget(
                    child: _progress(backgroundPhoto, state.uploadingBGProgress,
                        heightBackgroundPhoto(context), width(context) / 2),
                    button: _button(
                      context,
                      state,
                      true,
                      'Update profile background',
                    )));
              } else {
                allRows.add(backgroundPhoto);
              }
            }

            var watchingThisProfile = state.watchingThisProfile();
            if (watchingThisProfile != null) {
              // Add the name
              allRows.add(Align(
                  alignment: Alignment.bottomCenter,
                  child: actionContainer(widget.app, context,
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: AvatarHelper.nameH1(
                              context,
                              watchingThisProfile.authorId!,
                              widget.app,
                              state.feedId)))));
            }
            return Column(children: allRows);
          }
          return progressIndicator(widget.app, context);
        });
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }

  Widget _button(BuildContext context, ProfileInitialised profileInitialised,
      bool isBG, String tooltip) {
    return MediaButtons.mediaButtons(
        context,
        widget.app,
        profileInitialised.watchingThisProfile()!.authorId!,
        () => Tuple2(toMemberMediumAccessibleByGroup(
            profileInitialised.watchingThisProfile()!.accessibleByGroup!.index),
            profileInitialised.watchingThisProfile()!.accessibleByMembers),
        allowCrop: !isBG,
        tooltip: tooltip, photoFeedbackFunction: (photo) {
      if (!isBG) {
        if (photo != null) {
          BlocProvider.of<ProfileBloc>(context)
              .add(ProfilePhotoChangedProfileEvent(photo));
        } else {
          BlocProvider.of<ProfileBloc>(context)
              .add(UploadingProfilePhotoEvent(NOT_UPLOADING));
        }
      } else {
        if (photo != null) {
          BlocProvider.of<ProfileBloc>(context)
              .add(ProfileBGPhotoChangedProfileEvent(photo));
        } else {
          BlocProvider.of<ProfileBloc>(context)
              .add(UploadingBGPhotoEvent(NOT_UPLOADING));
        }
      }
    }, photoFeedbackProgress: (progress) {
      if (!isBG) {
        BlocProvider.of<ProfileBloc>(context)
            .add(UploadingProfilePhotoEvent(progress));
      } else {
        BlocProvider.of<ProfileBloc>(context)
            .add(UploadingBGPhotoEvent(progress));
      }
    }, icon: getEditIcon());
  }
}
