import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_flutter/bloc/todo_event.dart';
import 'package:todolist_flutter/bloc/todo_state.dart';
import 'package:todolist_flutter/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoCurrentState> {
  TodoBloc() : super(const TodoCurrentState()) {
    // Обработчик события добавления
    on<AddTodoEvent>((event, emit) {
      final currentTodo = List<Todo>.from(state.todo)..add(event.todo);
      emit(TodoCurrentState(todo: currentTodo));
    });
    // Обработчик события удаления
    on<DeleteTodoEvent>((event, emit) {
      final currentTodo = state.todo;
      final updatedTodo =
          currentTodo.where((todo) => todo.id != event.id).toList();
      emit(TodoCurrentState(todo: updatedTodo));
    });
    // Обработчик события переключения статуса
    on<ToggleStatusEvent>((event, emit) {
      final currentTodo = state.todo;
      final updatedTodo = currentTodo.map((todo) {
        if (todo.id == event.id) {
          return todo.copyWith(isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList();
      emit(TodoCurrentState(todo: updatedTodo));
    });
  }
}
