import 'package:untitled/store/state/CreateMomentContent.dart';
import 'package:untitled/store/state/UserState.dart';

import 'LoginState.dart';

/// model/app_model.dart

/// APP global
class AppState {
  UserState userState;
  GlobalState globalState;
  CreateMomentContentState createMomentContentState;

  AppState({ required this.userState, required this.globalState, required this.createMomentContentState });

  AppState copyWith({
    required UserState userState,
    required GlobalState globalState,
    required CreateMomentContentState createMomentContentState
  }) {
    return AppState(
      userState: userState,
      globalState: globalState,
      createMomentContentState: createMomentContentState
    );
  }
}
