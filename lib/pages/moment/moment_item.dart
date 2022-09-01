import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:untitled/config/theme_config.dart';
import 'package:untitled/pages/moment/moment_comment.dart';

import '../../store/state/index.dart';
import '../../store/viewModel/PreviewModel.dart';
import 'moment_item_cpn.dart';
import 'moment_top.dart';

class MomentItem extends StatefulWidget{
  final Map momentItem;
  final int index;
  const MomentItem({Key? key, required this.momentItem, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MomentItemState();
  }
}

class MomentItemState extends State<MomentItem>{
  MomentCpn m = MomentCpn();
  FocusNode addCommentFocusNode = FocusNode();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var momentItem = widget.momentItem;

    return StoreConnector(
      converter: (Store<AppState> store) => PreviewViewModel.create(store),
      builder: (BuildContext context, PreviewViewModel model) {
        return Container(
          color: ColorConfig.bgColor,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MomentTop(momentItem: momentItem, userInfo: model.userModel),
              m.momentContent(momentItem),
              m.momentTags(momentItem),
              m.momentTime(momentItem),
              m.momentAddComment(momentItem, addCommentFocusNode, context, commentController),
              // m.momentShowComments(momentItem, commentController)
              ShowComment(momentItem: momentItem, index: widget.index,)
            ],
          ),
        );
      }
    );
  }
}