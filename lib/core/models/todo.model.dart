class Todo {
  final String title;
  final String subtitle;
  final String about;
  final bool done;

  Todo({
    required this.title,
    required this.subtitle,
    required this.about,
    this.done = false,
  });

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      title: data['title'],
      subtitle: data['subtitle'],
      about: data['about'],
      done: data['done'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'about': about,
      'done': done,
    };
  }

  Todo copyWith({String? title, String? subtitle, String? about, bool? done}) {
    return Todo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      about: about ?? this.about,
      done: done ?? this.done,
    );
  }
}
