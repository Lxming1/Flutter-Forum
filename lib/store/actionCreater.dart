// action.dart
import 'package:untitled/store/state/CreateMomentContent.dart';
import 'package:untitled/store/state/UserState.dart';
import 'package:untitled/utils/share_preferences.dart';

enum UserAction {
  SetUserInfo,
  ClearUserInfo,
}

class SetUserInfo {
  final UserState userModel;

  SetUserInfo(this.userModel);
}

class ClearUserInfo {}

enum GlobalAction {
  SetLoginFlag,
  LogoutSystem
}

class SetLoginFlag {
  final bool loginFlag;
  SetLoginFlag(this.loginFlag);
}

class LogoutSystem {}


enum MomentAction {
  SetMoment,
  ClearMoment
}

class SetMoment{
  final CreateMomentContentState momentState;
  SetMoment(this.momentState);
}

class ClearMoment{}
