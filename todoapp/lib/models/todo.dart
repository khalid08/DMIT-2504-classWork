class Todo {
  int? id;
  String description;
  bool done;

  Todo({this.id, required this.description, required this.done});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'done': done ? 1 : 0,
    };
  }
}
