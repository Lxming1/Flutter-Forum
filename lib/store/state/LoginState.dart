/// store global state
class GlobalState {
  late bool loginFlag;

  GlobalState({
    required this.loginFlag
  });

  GlobalState.initState(): loginFlag = false;

  GlobalState copyWith(loginFlag) {
    return GlobalState(
      loginFlag: loginFlag ?? this.loginFlag
    );
  }
}
