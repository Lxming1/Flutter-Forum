import 'package:flutter/material.dart';
import 'package:untitled/network/home.dart';
import 'package:untitled/network/http_request.dart';

import 'moment_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  late List momentMes;
  late int pagenum;
  late int pagesize;
  late int allCount;
  var _futureFun;

  void myInitState(){
    momentMes = [];
    pagenum = 1;
    pagesize = 10;
    allCount = 0;
    _futureFun = getMoment(pagenum, pagesize);
  }

  @override
  void initState(){
    //上拉加载时会调用两次，这样可以让他只调用一次
    myInitState();
    super.initState();
  }

  getMoment(int pagenum, int pagesize) async {
    final result = await HomeReq.getMoments(pagesize, pagenum);
    if (result['status'] == 200) {
      momentMes.addAll(result['data']['moments']);
      allCount = result['data']['allCount'];
      return momentMes;
    }
  }

  _loadWords() {
    Future.delayed(Duration(milliseconds: 700)).then((e) async {
      pagenum += 1;
      await getMoment(pagenum, pagesize);
      setState(() {});
    });
  }


  Future<Null> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        myInitState();
      });
    });
  }

  PullUpLoading(){
    //  index等于list最后一个item，且count小于80时，返回Loading对话框
    _loadWords();
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  NoMoreMoment(){
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: const Text(
        '没有更多数据了...',
        style: TextStyle(color: Colors.white)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('进入首页');
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
            future: _futureFun,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              /*表示数据成功返回*/
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == snapshot.data.length - 1) {
                      if(snapshot.data.length < allCount){
                        return PullUpLoading();
                      }else{
                        return NoMoreMoment();
                      }
                    }
                    // 返回item数据
                    return MomentItem(momentItem: snapshot.data[index], index: index,);
                  },
                  itemCount: snapshot.data.length,
                );
              }else {
                return Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: Colors.white,),
                );
              }
            },
      )
          )
        ],
      ),
    );
  }
}