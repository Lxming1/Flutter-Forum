class MomentState{
  int? id;
  String? content;
  int? commentCount;
  int? labelCount;
  int? total;
  List? labels;

  MomentState({
    required this.id,
    required this.content,
    required this.commentCount,
    required this.labelCount,
    required this.total,
    required this.labels,
  });

  // state初始化
  factory MomentState.initial() => MomentState(
    id: 0,
    content: '',
    commentCount: 0,
    labelCount: 0,
    total: 0,
    labels: []
  );
}