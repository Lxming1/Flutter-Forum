import 'package:untitled/store/state/CreateMomentContent.dart';

import './content.dart';
import 'package:redux/redux.dart';

import 'actionCreater.dart';
import 'state/LoginState.dart';
import 'state/UserState.dart';

UserState userSetUpReducer(UserState userState, action) {
  if (action is SetUserInfo) {
    return userState.copyWith(action.userModel);
  } else if (action is ClearUserInfo) {
    return UserState.initState();
  } else {
    return userState;
  }
}

GlobalState globalStatusReducer(GlobalState globalState, action) {
  if (action is SetLoginFlag) {
    return globalState.copyWith(action.loginFlag);
  } else if (action is LogoutSystem) {
    return GlobalState.initState();
  } else {
    return globalState;
  }
}

CreateMomentContentState createMomentContentStateReducer(CreateMomentContentState createMomentContentState, action) {
  if (action is SetMoment) {
    return createMomentContentState.copyWith(action.momentState);
  } else if (action is ClearMoment) {
    return CreateMomentContentState.initState();
  } else {
    return createMomentContentState;
  }
}

// void main(){
//   Map state = {
//     'userInfo': {
//       'name': 'lxm',
//       'age': 21
//     },
//     'otherInfo': [
//       1,2,3,4
//     ]
//   };
//
//   Map userInfo = {
//     'name': 'asdasd',
//     'age': 2112
//   };
// }