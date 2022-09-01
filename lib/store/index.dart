
import 'package:untitled/store/state/index.dart';

import 'reducer.dart';


AppState appReducer(AppState appState, action) {
  return appState.copyWith(
      userState: userSetUpReducer(appState.userState, action),
      globalState: globalStatusReducer(appState.globalState, action),
      createMomentContentState: createMomentContentStateReducer(appState.createMomentContentState, action)
  );
}