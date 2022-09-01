import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:untitled/store/actionCreater.dart';
import 'package:untitled/store/state/MomentState.dart';

import '../../config/theme_config.dart';
import '../../store/state/CreateMomentContent.dart';
import '../../store/state/index.dart';
import 'create_moment.dart';

class CreateMoment extends StatefulWidget{
  const CreateMoment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateMomentState();
  }
}

class CreateMomentState extends State<CreateMoment>{

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final TextEditingController momentController = TextEditingController();
  final TextEditingController labelController = TextEditingController();


  alertSaveMoment(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Center(
            heightFactor: 2,
            child: Text("保留此次编辑？")
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text(
                    "不保留",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                    ),
                  ),
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(ClearMoment());
                    Navigator.of(context).pushReplacementNamed('/');//要跳转的页面
                  },
                ),
                TextButton(
                  child: const Text(
                    "保留",
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                  onPressed: () {
                    CreateMomentContentState createMoment = CreateMomentContentState(
                      content: momentController.text,
                      labels: labelController.text
                    );
                    StoreProvider.of<AppState>(context).dispatch(SetMoment(createMoment));
                    Navigator.of(context).pushReplacementNamed('/');//要跳转的页面
                  },
                ),
              ],
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ColorConfig.bgDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorConfig.bgColor,
        appBar: AppBar(
          // elevation: 10,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              String content = momentController.text;
              String labels = momentController.text;
              content != '' && labels != '' ?
                alertSaveMoment() :
                Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          title: Text('新建动态', style: TextStyle(fontSize: 16),),
          backgroundColor: ColorConfig.commonTopBarColor,
          centerTitle: true,
        ),
        body: GestureDetector(
          //点击空白处关闭键盘
          onTap: (){
            _focusNode1.unfocus();
            _focusNode2.unfocus();
          },
          child: CreateMomentCpn(
              focusNode1: _focusNode1,
              focusNode2: _focusNode2,
              momentController: momentController,
              labelController: labelController
          ),
        ),
        // floatingActionButton: createMoment(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

}