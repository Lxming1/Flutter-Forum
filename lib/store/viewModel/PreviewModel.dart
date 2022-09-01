import 'package:redux/redux.dart';

import '../actionCreater.dart';
import '../state/UserState.dart';
import '../state/index.dart';
import '../state/CreateMomentContent.dart';

class PreviewViewModel {
  final UserState userModel;
  final bool loginFlag;
  final CreateMomentContentState momentModel;
  final Function() clearUserInfo;
  final Function() logout;
  final Function() clearMoment;

  PreviewViewModel({
    required this.userModel,
    required this.loginFlag,
    required this.clearUserInfo,
    required this.logout,
    required this.clearMoment,
    required this.momentModel,
  });

  factory PreviewViewModel.create(Store<AppState> store) {
    _clearUserInfo() {
      store.dispatch(ClearUserInfo());
    }

    _logout() {
      store.dispatch(LogoutSystem());
    }

    _clearMoment(){
      store.dispatch(ClearMoment());
    }

    return PreviewViewModel(
      userModel: store.state.userState,
      loginFlag: store.state.globalState.loginFlag,
      momentModel: store.state.createMomentContentState,
      clearUserInfo: _clearUserInfo,
      logout: _logout,
      clearMoment: _clearMoment,
    );
  }
}
