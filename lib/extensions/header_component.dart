import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/model/header_component.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';
import 'package:eliud_pkg_feed/model/header_repository.dart';

import 'header/header.dart';

class HeaderComponentConstructorDefault implements ComponentConstructor {
  HeaderComponentConstructorDefault();

  Widget createNew({Key? key, required String id, Map<String, dynamic>? parameters}) {
    return HeaderComponent(key: key, id: id);
  }
}

class HeaderComponent extends AbstractHeaderComponent {
  HeaderComponent({Key? key, required String id}) : super(key: key, headerID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, HeaderModel? headerModel) {
    return Header();
  }

  @override
  HeaderRepository getHeaderRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .headerRepository(AccessBloc.appId(context))!;
  }
}
