class Todo {
  final int id;
  final String title;
  final bool isCompleted;

  const Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  // Метод для создании копии объекта с измененными значениями полей
  Todo copyWith({bool? isCompleted}) {
    return Todo(
      id: id,
      title: title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Конвертация объекта Todo в Map для сохранения в хранилище
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // Конвертация объекта Map в Todo для загрузки в хранилище
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }
}
