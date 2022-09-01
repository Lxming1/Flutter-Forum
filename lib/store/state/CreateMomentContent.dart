class CreateMomentContentState{
  String? content;
  String? labels;

  CreateMomentContentState({
    required this.content,
    required this.labels,
  });

  // state初始化
  factory CreateMomentContentState.initState() => CreateMomentContentState(
    content: '',
    labels: ''
  );

  CreateMomentContentState copyWith(CreateMomentContentState createMomentContent) {
    return CreateMomentContentState(
      content: createMomentContent.content,
      labels: createMomentContent.labels
    );
  }
}