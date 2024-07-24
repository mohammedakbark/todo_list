class EventModel {
  bool isDone;
  String dueDate;
  String title;

  EventModel(
      {required this.dueDate, required this.isDone, required this.title});

  Map<String, dynamic> toJson() =>
      {'isDone': isDone, 'dueDate': dueDate, 'title': title};

  factory EventModel.fromjson(Map<String, dynamic> json) {
    return EventModel(
        dueDate: json["dueDate"], isDone: json["isDone"], title: json["title"]);
  }
}
