/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_pkg_feed/model/profile_component_bloc.dart';
import 'package:eliud_pkg_feed/model/profile_component_event.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';
import 'package:eliud_pkg_feed/model/profile_repository.dart';
import 'package:eliud_pkg_feed/model/profile_component_state.dart';

abstract class AbstractProfileComponent extends StatelessWidget {
  static String componentName = "profiles";
  final String? profileID;

  AbstractProfileComponent({Key? key, this.profileID}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileComponentBloc> (
          create: (context) => ProfileComponentBloc(
            profileRepository: getProfileRepository(context))
        ..add(FetchProfileComponent(id: profileID)),
      child: _profileBlockBuilder(context),
    );
  }

  Widget _profileBlockBuilder(BuildContext context) {
    return BlocBuilder<ProfileComponentBloc, ProfileComponentState>(builder: (context, state) {
      if (state is ProfileComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No Profile defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is ProfileComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is ProfileComponentError) {
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, ProfileModel? value);
  Widget alertWidget({ title: String, content: String});
  ProfileRepository getProfileRepository(BuildContext context);
}

