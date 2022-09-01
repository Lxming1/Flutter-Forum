import 'package:flutter/material.dart';
import 'package:untitled/config/theme_config.dart';
import 'package:untitled/store/state/UserState.dart';
import 'package:untitled/utils/format_time.dart';
import 'package:untitled/utils/require_login.dart';
import '../../network/home.dart';
import '../../utils/event_bus.dart';
import '../../utils/modal_bottom_sheet.dart';
import '../../utils/toast.dart';
import '../login/index.dart';

class MomentCpn {

  momentContent(momentItem) {
    return Text(
      momentItem['content'],
      textAlign: TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.w600
      ),
    );
  }

  momentTime(momentItem) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      alignment: Alignment.bottomRight,
      child: Text(
        '发表于: ${FormatTime.formatTime(momentItem['createTime'])}',
        style: TextStyle(fontSize: 10, color: Colors.black45,),
      ),
    );
  }

  momentAddComment(momentItem, focusNode, context, commentController){
    return Padding(padding: const EdgeInsets.only(top: 10),
      child: TextField(
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          focusColor: Colors.grey,
          hintText: '发表评论',
          hintStyle: const TextStyle(
              color: Colors.black45
          ),
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(vertical:5, horizontal: 8), //内边距设置
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(width: 0)
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
        onTap: (){
          ModalBottomSheet.show(context, '说些什么吧...', commentController, (content) async {
            try{
              var resp = await HomeReq.comment(content, momentItem['id']);
              if (resp['status'] == 200) {
                ToastUtil.showMes('发表成功');
                eventBus.fire(RebuildEvent(momentItem['id']));
              }else {
                print('未知问题');
              }
            }catch(err) {
              RequireLogin.requireLogin(context);
              return ;
            }
          });
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }

  momentTags(momentItem){
    if (momentItem['labels'] != null) {
      return Container(
          height: 20,
          margin: const EdgeInsets.only(top: 5),
          alignment: Alignment.bottomRight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                '#${momentItem['labels'][index]['name']} ',
                style: TextStyle(color: Colors.black45, fontSize: 10),
              );
            },
            itemCount: momentItem['labelCount'],
          )
      );
    }
    return SizedBox.shrink();
  }
}

