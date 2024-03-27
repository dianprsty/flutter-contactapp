// ignore_for_file: unnecessary_this

class Todo {
  int? id;
  String? userEmail;
  String title;
  String description;
  bool isDone;
  DateTime? createdAt;
  DateTime? updatedAt;

  Todo({
    this.id,
    this.userEmail,
    required this.title,
    required this.description,
    required this.isDone,
    this.createdAt,
    this.updatedAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userEmail: json['user_email'],
      title: json['title']! ?? "",
      description: json['description']! ?? "",
      isDone: json['is_done'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'user_email': this.userEmail,
      'title': this.title,
      'description': this.description,
      'is_done': this.isDone,
      'created_at': this.createdAt.toString(),
      'updated_at': this.updatedAt.toString()
    };
  }
}
