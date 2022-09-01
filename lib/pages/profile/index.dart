import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:redux/redux.dart';
import 'package:untitled/config/http_config.dart';
import 'package:untitled/config/theme_config.dart';
import 'package:untitled/network/profile.dart';
import 'package:untitled/pages/login/index.dart';
import 'package:untitled/utils/share_preferences.dart';
import 'package:untitled/utils/toast.dart';

import '../../store/actionCreater.dart';
import '../../store/state/index.dart';
import '../../store/viewModel/PreviewModel.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage>{

  late var myImage;

  //拍照
  Future _getImageFromCamera(userInfo) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 400);
    sendImage(image, userInfo);
  }

  //相册选择
  Future _getImageFromGallery(userInfo) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    sendImage(image, userInfo);
  }

  Future sendImage(image, userInfo) async {
    String path = image?.path as String;
    var croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      myImage = croppedFile;
      sendAvatar(myImage, userInfo);
    });
  }

  Future sendAvatar(file, userInfo) async {
    var res = await ProfileReq.sendAvatar(myImage);
    if (res['status'] == 200) {
      userInfo.avatarUrl = '${HTTPConfig.baseURL}/users/${userInfo.id}/avatar';
      //存入全局store
      await StoreProvider.of<AppState>(context).dispatch(SetUserInfo(userInfo));
      Object userObj = {
        'id': userInfo.id,
        'name': userInfo.name,
        'avatarUrl': userInfo.avatarUrl
      };
      String userInfoToJson = json.encode(userObj);
      //更新本地存储的信息
      await SharedPreferencesUtil.setStorage('userInfo', userInfoToJson);
      //清除图片缓存
      await evictImage(userInfo.avatarUrl, {});
      //改变图片的key，会重新渲染
      await refreshImage();
      Navigator.pop(context);
      ToastUtil.showMes('修改成功');
    }
  }
  var imgKey = UniqueKey();

  refreshImage(){
    setState((){
      imgKey = UniqueKey();
    });
  }

  //清除图片缓存
  Future<bool> evictImage(String imageURL, Map<String, String> headers) async {
    final NetworkImage provider = NetworkImage(imageURL, headers: headers);
    return await provider.evict();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PreviewViewModel>(
        converter: (Store<AppState> store) => PreviewViewModel.create(store),
        builder: (BuildContext context, PreviewViewModel model) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color: Colors.black26
                  ))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: model.loginFlag ? GestureDetector(
                        child:
                          ClipOval(
                            child : model.userModel.avatarUrl != '' ?
                              Image.network(model.userModel.avatarUrl, width: 80, height: 80, key: imgKey,) :
                              Image.asset('lib/assets/img/img.png', width: 80, height: 80)
                          ),
                        onTap: () async {
                          return showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context){
                              List list = [
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 10, top: 16),

                                    child: Text('拍照', textAlign: TextAlign.center,),
                                  ),
                                  onTap: (){
                                    _getImageFromCamera(model.userModel);
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('从相册中选择', textAlign: TextAlign.center),
                                  ),
                                  onTap: () {
                                    _getImageFromGallery(model.userModel);
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 16),
                                    child: Text('取消', textAlign: TextAlign.center),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ];
                              return AnimatedPadding(
                                padding: MediaQuery.of(context).viewInsets,
                                duration: Duration(milliseconds: 100),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return list[index];
                                  },
                                  itemCount: 3,
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Divider(color: Colors.black);
                                  },
                                )
                              );
                            }
                          );
                        },
                      ) : null,
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      alignment: Alignment.center,
                      child: Text(
                        model.loginFlag ? model.userModel.name : '未登录',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ),
                      )
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (model.loginFlag){
                    SharedPreferencesUtil.removeAllStorage();
                    model.clearUserInfo();
                    model.logout();
                    model.clearMoment();
                    ToastUtil.showMes('退出登录');
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage())
                  );
                },
                child: Text(
                  model.loginFlag ? '退出登录' : '登录',
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorConfig.themeColor)
                ),
              )
            ],
          );
        }
    );
  }
}