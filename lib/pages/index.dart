import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:untitled/config/theme_config.dart';
import 'package:untitled/pages/profile/index.dart';
import 'package:untitled/utils/require_login.dart';
import '../store/state/index.dart';
import '../store/viewModel/PreviewModel.dart';
import '../utils/keep_alive.dart';
import 'create_moment/index.dart';
import 'moment/index.dart';

class View extends StatefulWidget{
  const View({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ViewState();
}

class ViewState extends State<View>{
  int _currentIndex = 0;
  late PageController _pageController;

  get changeIndex => (int index){
    setState(() {
      _currentIndex = index;
    });
  };

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PreviewViewModel>(
      converter: (Store<AppState> store) => PreviewViewModel.create(store),
      builder: (BuildContext context, PreviewViewModel model) {
        return Container(
          decoration: ColorConfig.bgDecoration(1),
          child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  // elevation: 0,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Text('Leisure Time'),
                  backgroundColor: ColorConfig.appBarColor,
                ),
                body: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                    ),
                    child: MyPageView(
                        pageController: _pageController,
                        currentIndex: _currentIndex,
                        childPage: const <Widget>[
                          HomePage(),
                          ProfilePage(),
                        ],
                        changeIndex: changeIndex
                    )

                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    model.loginFlag ? Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateMoment())
                    ) : RequireLogin.requireLogin(context);
                  },
                  child: Icon(
                    Icons.add,
                    size: 35,
                  ),
                  backgroundColor: ColorConfig.themeColor,
                ),
                // floatingActionButton: _customFloatingActionButton(),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: ColorConfig.bottomBarBg,
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Color(0xFF6CB6EF),
                  unselectedIconTheme: IconThemeData(color: Colors.white),
                  selectedIconTheme: IconThemeData(color: Color(0xFF6CB6EF)),
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: '动态'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
                  ],
                  onTap: (index){
                    _pageController.jumpToPage(index);
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
        );
      }
    );
  }
}
