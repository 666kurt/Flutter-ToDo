import 'package:todolist_flutter/todo.dart';

abstract class TodoEvent {
  const TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;
  const AddTodoEvent({required this.todo});
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  const DeleteTodoEvent({required this.id});
}

class ToggleStatusEvent extends TodoEvent {
  final int id;
  const ToggleStatusEvent({required this.id});
}
