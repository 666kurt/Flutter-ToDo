import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_flutter/bloc/todo_event.dart';
import 'package:todolist_flutter/bloc/todo_state.dart';
import 'package:todolist_flutter/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoCurrentState> {
  TodoBloc() : super(const TodoCurrentState()) {
    _loadTodo();

    // Обработчик события добавления
    on<AddTodoEvent>((event, emit) {
      final currentTodo = List<Todo>.from(state.todo)..add(event.todo);
      emit(TodoCurrentState(todo: currentTodo));
      _saveTodo(currentTodo);
    });
    // Обработчик события удаления
    on<DeleteTodoEvent>((event, emit) {
      final currentTodo = state.todo;
      final updatedTodo =
          currentTodo.where((todo) => todo.id != event.id).toList();
      emit(TodoCurrentState(todo: updatedTodo));
      _saveTodo(updatedTodo);
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
      _saveTodo(updatedTodo);
    });
  }

  // Сохранения списка задач
  Future<void> _saveTodo(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedDate =
        jsonEncode(todos.map((todo) => todo.toMap()).toList());
    await prefs.setString('todo_list', encodedDate);
  }

  // Загрузка списка задач
  Future<void> _loadTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('todo_list');
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      final List<Todo> loadedData =
          decodedData.map((todo) => Todo.fromMap(todo)).toList();
      emit(TodoCurrentState(todo: loadedData));
    }
  }
}
