class TaskModel {
  String title ;
  String description ;
  DateTime dateTime ;
  bool isDone ;

  TaskModel({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
});
}