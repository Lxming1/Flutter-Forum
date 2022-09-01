//封装组件返回PageView
// import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class MyPageView extends StatelessWidget{
  final PageController pageController;
  final int currentIndex;
  final List <Widget> childPage;
  final ValueChanged<int> changeIndex;

  const MyPageView({
    Key? key,
    required this.pageController,
    required this.currentIndex,
    required this.childPage,
    required this.changeIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (int i = 0; i < childPage.length; ++i) {
      //只需要用 KeepAliveWrapper 包装一下即可
      children.add(KeepAliveWrapper(child: childPage[i]));
    }
    return PageView(
      controller: pageController,
      children: children,
      onPageChanged: (index){
        changeIndex(index);
      },
    );
  }
}

//传入需要缓存的页面
class KeepAliveWrapper extends StatefulWidget{

  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);

  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if(oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}