import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/config/theme_config.dart';

class InputText extends StatelessWidget {
  final String? title;
  final ValueChanged<String> changeValue;
  final String? value;
  TextEditingController controller;
  bool showPass;
  Icon passIcon;
  Function() setShowPass;

  defaultFun(){}

  void clearValue() {
    controller.clear();
  }

  InputText({
    Key? key,
    this.title,
    required this.changeValue,
    required this.value,
    required this.controller,
    this.showPass = false,
    this.passIcon = const Icon(Icons.visibility_off),
    required this.setShowPass
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: '请输入$title',
        hintStyle: const TextStyle(
          color: Colors.white
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(title == '用户名' ? Icons.person_outline : Icons.lock_open, color: Colors.white,),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0), //内边距设置
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.white)
        ),
        suffixIcon: title == '密码' ? IconButton(
          onPressed: () {
            setShowPass();
          },
          icon: passIcon,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: Colors.white,
        ) : null,
        suffixIconColor: Colors.white
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      obscureText: title == '密码' && !showPass,
      onChanged: (val){
        changeValue(val);
      },
    );
  }
}
