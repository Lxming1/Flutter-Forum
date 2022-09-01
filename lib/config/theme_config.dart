import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConfig {
  static Color themeColor = Color(0xFF6CB6EF);
  static Color bgColor = Color(0x33E6E6FF);
  static Color bottomBarBg = Color(0x7F123132);
  static Color appBarColor = Colors.white10;
  static BoxDecoration bgDecoration([num = '']){
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage('lib/assets/img/login_bg$num.png'),
            fit: BoxFit.cover
        )
    );
  }
  static Color commonTopBarColor = Color(0xff2b6c8e);
}