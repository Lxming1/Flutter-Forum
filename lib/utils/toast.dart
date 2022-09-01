import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil{
  static showMes(String mes) {
    Fluttertoast.showToast(
      msg: mes,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black26,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }
}