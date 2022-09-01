import 'package:flutter/material.dart';
import 'package:untitled/config/theme_config.dart';

class ModalBottomSheet {
  static show(context, String tipStr,TextEditingController commentController, Function request){
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: tipStr,
                      border: null,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 1000,
                    maxLines: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: ()  {
                    request(commentController.text);
                    commentController.text = '';
                    Navigator.of(context).pop();
                  },
                  child: Text('发表',),
                  style: ButtonStyle(
                    // foregroundColor: MaterialStateProperty.all(ColorConfig.themeColor)
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      //设置按下时的背景颜色
                      if (states.contains(MaterialState.pressed)) {
                        return ColorConfig.themeColor;
                      }
                      //默认不使用背景颜色
                      return null;
                    }),
                  ),
                )
              ],
            ),
            padding: EdgeInsets.all(7),
          ),
        );
      }
    );
  }
}