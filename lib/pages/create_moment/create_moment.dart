import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:untitled/network/moment.dart';
import 'package:untitled/utils/toast.dart';

import '../../config/theme_config.dart';
import '../../store/state/index.dart';
import '../../store/viewModel/PreviewModel.dart';

class CreateMomentCpn extends StatefulWidget{
  FocusNode focusNode1;
  FocusNode focusNode2;
  TextEditingController momentController;
  TextEditingController labelController;

  CreateMomentCpn({
    Key? key,
    required this.focusNode1,
    required this.focusNode2,
    required this.momentController,
    required this.labelController
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateMomentCpnState();
  }

}

class CreateMomentCpnState extends State<CreateMomentCpn> with WidgetsBindingObserver {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Store<AppState> store =
    // widget.momentController.text = '测试数据';
    // widget.labelController.text = '测试数据';
  }

  createMoment() async {
    String content = widget.momentController.text;
    String labelsStr = widget.labelController.text;

    List labels = labelsStr.split(' ');
    //去除空标签
    labels.removeWhere((element) => element == '' || element.trim() == '');

    if (content == '' || content.trim() == '') {
      ToastUtil.showMes('内容不为空');
      return;
    }

    try{
      var resp = await MomentReq.addMoment(content);
      if(resp['status'] != 200) return Error();
      int momentId = resp['data']['insertId'];

      var result = await MomentReq.setLabel(labels, momentId);
      if(result['status'] != 200) return Error();
      ToastUtil.showMes('发布成功');
      Navigator.of(context).pushReplacementNamed('/');//要跳转的页面

    }catch(err){
      ToastUtil.showMes('发布失败');
      return;
    }
  }

  _initBuild(PreviewViewModel model) {
    widget.momentController.text = model.momentModel.content!;
    widget.labelController.text = model.momentModel.labels!;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PreviewViewModel>(
      onInitialBuild: _initBuild,
      converter: (Store<AppState> store) => PreviewViewModel.create(store),
      builder: (BuildContext context, PreviewViewModel model) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '动态内容：',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: widget.momentController,
                      decoration: InputDecoration(
                          hintText: '说些什么吧...',
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          filled: true,
                          fillColor: Color(0xFFDBDBDB)
                      ),
                      maxLength: 1000,
                      maxLines: 10,
                      focusNode: widget.focusNode1,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '动态标签：',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: widget.labelController,
                    decoration: InputDecoration(
                        hintText: '多个标签以空格分离',
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        filled: true,
                        fillColor: Color(0xFFDBDBDB)
                    ),
                    focusNode: widget.focusNode2,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                child: ElevatedButton(
                  onPressed: (){
                    createMoment();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '发   布',
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorConfig.themeColor),
                  ),
                ),
              )
            ],
          )
      );
      }
    );
  }
}