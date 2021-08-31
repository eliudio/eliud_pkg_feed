/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_pkg_feed/model/header_component_bloc.dart';
import 'package:eliud_pkg_feed/model/header_component_event.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';
import 'package:eliud_pkg_feed/model/header_repository.dart';
import 'package:eliud_pkg_feed/model/header_component_state.dart';

abstract class AbstractHeaderComponent extends StatelessWidget {
  static String componentName = "headers";
  final String? headerID;

  AbstractHeaderComponent({Key? key, this.headerID}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HeaderComponentBloc> (
          create: (context) => HeaderComponentBloc(
            headerRepository: getHeaderRepository(context))
        ..add(FetchHeaderComponent(id: headerID)),
      child: _headerBlockBuilder(context),
    );
  }

  Widget _headerBlockBuilder(BuildContext context) {
    return BlocBuilder<HeaderComponentBloc, HeaderComponentState>(builder: (context, state) {
      if (state is HeaderComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No Header defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is HeaderComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is HeaderComponentError) {
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, HeaderModel? value);
  Widget alertWidget({ title: String, content: String});
  HeaderRepository getHeaderRepository(BuildContext context);
}

