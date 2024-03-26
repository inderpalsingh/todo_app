class TodoModel {
  String title;
  String desc;
  bool isCompleted;
  int createdAt;
  int updatedAt;

  TodoModel({
    required this.title,
    required this.desc,
    this.isCompleted = false,
    this.createdAt = 0,
    this.updatedAt = 0
  });
}
