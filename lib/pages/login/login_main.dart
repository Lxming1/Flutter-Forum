import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:untitled/config/theme_config.dart';
import 'package:untitled/network/login.dart';
import 'package:untitled/store/state/UserState.dart';

import '../../network/http_request.dart';
import '../../store/actionCreater.dart';
import '../../store/state/index.dart';
import '../../utils/share_preferences.dart';
import '../../utils/toast.dart';
import 'input_text.dart';

class LoginMain extends StatefulWidget{
  const LoginMain({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginMain>{
  String? username;
  String? password;
  bool isLogin = true;
  double bodyHeight = window.padding.top / window.devicePixelRatio;
  bool showPass = false;
  Icon passIcon = Icon(Icons.visibility_off);

  setShowPass () {
    setState(() {
      showPass = !showPass;
      passIcon = showPass ? Icon(Icons.visibility) : Icon(Icons.visibility_off);
    });
  }

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  changeUser(val){
    username = val;
  }

  changePass(val){
    password = val;
  }

  submit (){
    isLogin ? login() : register();
  }

  login() async {
    try{
      var result = await LoginReq.submitLogin(username, password);
      if (result["status"] == 200) {
        await SharedPreferencesUtil.setStorage('token', result['data']['token']);
        Map userInfo = result['data'];
        UserState userModel = UserState(id: userInfo['id'], name: userInfo['name'], avatarUrl: userInfo['avatarUrl'] ?? '');
        Object userObj = {
          'id': userInfo['id'],
          'name': userInfo['name'],
          'avatarUrl': userInfo['avatarUrl'] ?? ''
        };

        String userInfoToJson = json.encode(userObj);
        await SharedPreferencesUtil.setStorage('userInfo', userInfoToJson);

        //存入store
        StoreProvider.of<AppState>(context).dispatch(SetLoginFlag(true));
        StoreProvider.of<AppState>(context).dispatch(SetUserInfo(userModel));

        // Navigator.of(context).pushReplacementNamed('/');//要跳转的页面
        ToastUtil.showMes('登录成功');
        Navigator.pop(context);
      }
    }catch(err) {
      print(err);
      ToastUtil.showMes('用户名或密码错误');
    }
  }

  register() async {
    var result = await LoginReq.submitRegister(username, password);
    if (result["status"] == 200) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        ToastUtil.showMes('注册成功');
        userController.clear();
        passController.clear();
        isLogin = true;
      });
    }
  }

  titleCpn(){
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
              'lib/assets/img/logo.jpg',
              width: 120),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            isLogin ? '用户登录' : '用户注册',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white
            ),
          ),
        ),
      ],
    );
  }

  fromMain(){
    return Form(
      child: Column(
        children: [
          InputText(
            title: '用户名',
            changeValue: changeUser,
            value: username,
            controller: userController,
            setShowPass: () {  },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 30),
            child: InputText(
              title: '密码',
              changeValue: changePass,
              value: password,
              controller: passController,
              showPass: showPass,
              passIcon: passIcon,
              setShowPass: setShowPass
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  submit();
                },
                child: Text(
                  isLogin ? "登录" : '注册',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  primary: ColorConfig.themeColor
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  myTextButton(){
    return TextButton(
        onPressed: (){
          setState(() {
            userController.clear();
            passController.clear();
            isLogin = !isLogin;
          });
        },
        child: Text(
          isLogin ? '快速注册' : '账号登录',
          style: const TextStyle(
            color: Colors.white
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height - 56.0 - bodyHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            titleCpn(),
            fromMain(),
            myTextButton()
          ],
        ),
      ),
    );
  }
}
