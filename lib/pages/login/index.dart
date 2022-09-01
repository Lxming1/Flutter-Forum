import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/config/theme_config.dart';
import '../../utils/event_bus.dart';
import 'login_main.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ColorConfig.bgDecoration(),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: ColorConfig.bgColor,
            appBar: AppBar(
              title: const Text('Leisure Time'),
              backgroundColor: ColorConfig.commonTopBarColor,
              centerTitle: true,
            ),
            body: const LoginMain()
        )
    );
  }
}


