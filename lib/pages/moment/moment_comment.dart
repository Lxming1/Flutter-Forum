import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/utils/require_login.dart';
import '../../network/home.dart';
import '../../utils/event_bus.dart';
import '../../utils/modal_bottom_sheet.dart';
import '../../utils/toast.dart';
import '../login/index.dart';


class ShowComment extends StatefulWidget{
  final Map momentItem;
  final int index;
  const ShowComment({Key? key, required this.momentItem, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShowCommentState();
  }

}
class ShowCommentState extends State<ShowComment>{
  late Map momentItem;
  TextEditingController commentController = TextEditingController();
  late List comment = [];
  late int commentCount = 0;
  late bool showComment;
  var _future;
  int flag = 0;
  var discrip;
  late int initHasComment;

  Future<List?> getComment(int momentId) async {
    var resp = await HomeReq.getComment(momentId);
    if(resp['status'] != 200) return ToastUtil.showMes('获取评论失败');
    return resp['data']['comments'];
  }

  rebuildComment(momentId){
    if(mounted){
      // 只更新发表了评论的momentItem
      if (momentItem['id'] == momentId) {
        setState(() {
          commentCount ++;
          _future = getComment(momentId);
        });
      }
    }
  }

  @override
  void initState() {
    showComment = false;
    discrip = eventBus.on<RebuildEvent>().listen((event) => rebuildComment(event.momentId));
    super.initState();
    momentItem = widget.momentItem;
    commentCount = momentItem['commentCount'];
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅
    discrip.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (commentCount == 0) {
      return Container(
        margin: EdgeInsets.only(top: 18),
        alignment: Alignment.center,
        child: const Text(
          '暂无评论',
          style: TextStyle(
              color: Colors.black45,
              fontSize: 12
          ),
        ),
      );
    }

    return Column(
      children: [
        !showComment ? SizedBox.shrink() :
        FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return Container(
                  margin: const EdgeInsets.only(top: 18),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final commentInfo = snapshot.data[index];
                      String user = commentInfo['author']['name'];
                      String commentMes = commentInfo['content'];
                      var replyCommentId = commentInfo['commentId'];
                      String publishUser = '';

                      if (replyCommentId != null) {
                        for (var item in snapshot.data) {
                          if (item['id'] == replyCommentId) {
                            publishUser = item['author']['name'];
                          }
                        }
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              replyCommentId == null ? '$user 回复：' : '$user 回复 $publishUser：',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  ModalBottomSheet.show(context, '回复${user}：', commentController, (content) async {
                                    try{
                                      var resp = await HomeReq.replyComment(commentInfo['id'], content, momentItem['id']);
                                      if (resp['status'] == 200) {
                                        setState(() {
                                          _future = getComment(momentItem['id']);
                                          ToastUtil.showMes('发表成功');
                                        });
                                      }else {
                                        print('未知问题');
                                      }
                                    }catch (err) {
                                      RequireLogin.requireLogin(context);
                                    }
                                  });
                                },
                                onLongPress: (){
                                  Clipboard.setData(ClipboardData(text: commentInfo['content']));
                                  ToastUtil.showMes('复制成功');
                                },
                                child: Text(
                                  commentMes,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  )
              );
            }else {
              return SizedBox.shrink();
            }
          },
          future: _future,
        )
        ,
        Center(
          child: TextButton(
            onPressed: ()async {
              setState(() {
                _future = getComment(momentItem['id']);
                showComment = !showComment;
              });
            },
            child: Text(
              showComment ? '收起评论' : '查看评论',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12
              ),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Color(0xffc8c6e0)),
              minimumSize: MaterialStateProperty.all(Size(0, 0)),
            ),
          ),
        ),
      ],
    );
  }
}