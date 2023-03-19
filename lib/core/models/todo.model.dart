class Todo {
  final String title;
  final String subtitle;
  final String about;

  Todo({required this.title, required this.subtitle, required this.about});

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      title: data['title'],
      subtitle: data['subtitle'],
      about: data['about'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'about': about,
    };
  }
}
