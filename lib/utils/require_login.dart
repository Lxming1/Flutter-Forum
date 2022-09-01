
import 'package:flutter/material.dart';
import 'package:untitled/pages/login/index.dart';
import 'package:untitled/utils/toast.dart';


class RequireLogin {
  static requireLogin(context){
    ToastUtil.showMes('请先登录');
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage())
    );
  }
}