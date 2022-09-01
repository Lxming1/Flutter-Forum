// user 全局共享数据模型
class UserState {
  int id;
  String name;
  String avatarUrl;

  UserState({
    required this.id,
    required this.name,
    required this.avatarUrl
  });

  // state初始化
  factory UserState.initState() => UserState(
    id: 0,
    name: '',
    avatarUrl: ''
  );

  UserState copyWith(UserState userModel) {
    return UserState(
      id: userModel.id,
      name: userModel.name,
      avatarUrl:  userModel.avatarUrl
    );
  }
}