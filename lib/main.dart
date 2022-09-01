import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:untitled/pages/index.dart';
import 'package:untitled/store/actionCreater.dart';
import 'package:untitled/store/index.dart';
import 'package:untitled/store/state/CreateMomentContent.dart';
import 'package:untitled/store/state/index.dart';
import 'package:untitled/store/state/LoginState.dart';
import 'package:untitled/store/state/UserState.dart';
import 'package:untitled/utils/share_preferences.dart';
import 'package:untitled/utils/toast.dart';

void main() {
  final store = Store<AppState>(
      appReducer,
      initialState: AppState(
        globalState: GlobalState.initState(),
        userState: UserState.initState(),
        createMomentContentState: CreateMomentContentState.initState()
      )
  );
  runApp(
    StoreProvider(
      store: store,
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  @override
  void initState(){
    setUserInfo();
    super.initState();
  }

  setUserInfo () async {
    try {
      var strUserInfo = await SharedPreferencesUtil.getStorage('userInfo');
      var userObj = json.decode(strUserInfo);
      UserState userState = UserState(id: userObj['id'], name: userObj['name'], avatarUrl: userObj['avatarUrl']);

      StoreProvider.of<AppState>(context).dispatch(SetLoginFlag(true));
      StoreProvider.of<AppState>(context).dispatch(SetUserInfo(userState));
    }catch(err) {
      print('未获取到登录数据');
    }
  }

  int last = 0;

  Future<bool> doubleClickBack() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 1000) {
      last = DateTime.now().millisecondsSinceEpoch;
      ToastUtil.showMes('再按一次退出');
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        home: WillPopScope(
          child: View(),
          onWillPop: doubleClickBack,
        ),
      ),
    );
  }
}


