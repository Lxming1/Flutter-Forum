import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/theme_config.dart';
import '../../store/state/UserState.dart';

class MomentTop extends StatefulWidget{

  final Map momentItem;
  final UserState userInfo;
  const MomentTop({Key? key, required this.momentItem, required this.userInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MomentTopState();
  }
}

class MomentTopState extends State<MomentTop> {

  late Map momentItem;
  late UserState userInfo;
  bool showTool = false;

  popMenuButton(){
    return PopupMenuButton<String>(
      //这是点击弹出菜单的操作，点击对应菜单后，改变屏幕中间文本状态，将点击的菜单值赋予屏幕中间文本
        onSelected: (String value) {
          setState(() {
            // _bodyText = value;
          });
        },
        //这是弹出菜单的建立，包含了两个子项，分别是增加和删除以及他们对应的值
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('增加'),
                Icon(Icons.add_circle)
              ],
            ),
            value: '这是增加',
          ),
          PopupMenuItem(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text('增加'),
                new Icon(Icons.remove_circle)
              ],
            ),
            value: '这是删除',
          )
        ]
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    momentItem = widget.momentItem;
    userInfo = widget.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                GestureDetector(
                  child: ClipOval(
                    child: momentItem['author']['avatarUrl'] != null ?
                    Image.network(
                        momentItem['author']['avatarUrl'],
                        width: 50
                    ) : Image.asset('lib/assets/img/img.png', width: 50)
                  ),
                  onTap: () async {
                    return showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: momentItem['author']['avatarUrl'] != null ?
                          Image.network(
                            momentItem['author']['avatarUrl']
                          ) : Image.asset('lib/assets/img/img.png'),
                        );
                      },
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      momentItem['author']['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ]
          ),
          userInfo.name == momentItem['author']['name'] ? IconButton(
            icon: Icon(
              !showTool ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
              color: ColorConfig.bottomBarBg,
            ),
            //去除特效
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                showTool = !showTool;
                // popMenuButton();
              });
            },
          ) : SizedBox.shrink()
        ],
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}