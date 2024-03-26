class TodoModel {
  String title;
  String desc;
  bool isCompleted;

  TodoModel({
    required this.title,
    required this.desc,
    this.isCompleted = false
  });
}
