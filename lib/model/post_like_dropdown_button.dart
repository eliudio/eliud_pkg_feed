/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/package/packages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';


import 'package:eliud_pkg_feed/model/post_like_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_like_list_state.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';


typedef PostLikeChanged(String? value);

class PostLikeDropdownButtonWidget extends StatefulWidget {
  final String? value;
  final PostLikeChanged? trigger;
  final bool? optional;

  PostLikeDropdownButtonWidget({ this.value, this.trigger, this.optional, Key? key }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PostLikeDropdownButtonWidgetState();
  }
}

class PostLikeDropdownButtonWidgetState extends State<PostLikeDropdownButtonWidget> {
  PostLikeListBloc? bloc;

  PostLikeDropdownButtonWidgetState();

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<PostLikeListBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (bloc != null) bloc!.close();
    super.dispose();
  }

List<Widget> widgets(PostLikeModel value) {
var widgets = <Widget>[];
widgets.add(value!.timestamp != null ? Center(child: StyleRegistry.registry().styleWithContext(context).adminListStyle().listItem(context, value!.timestamp!.toString())) : Container());
widgets.add(value!.documentID != null ? Center(child: StyleRegistry.registry().styleWithContext(context).adminListStyle().listItem(context, value!.documentID!)) : Container());
return widgets;
}


  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<PostLikeListBloc, PostLikeListState>(builder: (context, state) {
      if (state is PostLikeListLoading) {
        return StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context);
      } else if (state is PostLikeListLoaded) {
        String? valueChosen;
        if (state.values!.indexWhere((v) => (v!.documentID == widget.value)) >= 0)
          valueChosen = widget.value;
        else
          if (widget.optional != null && widget.optional!) valueChosen = null;
          
        final values = state.values;
        final items = <DropdownMenuItem<String>>[];
        if (state.values!.isNotEmpty) {
          if (widget.optional != null && widget.optional!) {
            items.add(new DropdownMenuItem<String>(
                value: null,
                child: new Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  height: 100.0,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [ new Text("None") ],
                  ),
                )));
          }
          state.values!.forEach((element) {
            items.add(new DropdownMenuItem<String>(
                value: element!.documentID,
                child: new Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  height: 100.0,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widgets(element),
                  ),
                )));
          });
        }
        DropdownButton button = 
                    DropdownButton<String>(
                      isDense: false,
                      isExpanded: false,
                      items: items,
                      value: valueChosen,
                      hint: Text('Select a postLike'),
                      onChanged: !accessState.memberIsOwner() ? null : _onChange,
                    );
        if (false) {
          return Container(height:48, child: Center(child: button));
        } else {
          return Center(child: button);
        }
      } else {
        return StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context);
      }
    });
  }

  void _onChange(String? value) {
    widget.trigger!(value);
  }
}

