import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_flutter/bloc/todo_bloc.dart';
import 'package:todolist_flutter/bloc/todo_event.dart';
import 'package:todolist_flutter/bloc/todo_state.dart';
import 'package:todolist_flutter/todo.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  // Свойство для хранения введенного текста
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todos")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: Column(
          children: [
            // TextField
            CupertinoTextField(
              padding: const EdgeInsets.all(10),
              placeholder: "Enter new todo",
              controller: _controller,
            ),
            const SizedBox(height: 10),
            // Add button
            GestureDetector(
              onTap: () {
                final int id = Random().nextInt(10000);
                final Todo todo = Todo(id: id, title: _controller.text);
                context.read<TodoBloc>().add(AddTodoEvent(todo: todo));
                _controller.clear();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "Add todo",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            ),
            // ListView
            Expanded(
              child: BlocBuilder<TodoBloc, TodoCurrentState>(
                builder: (context, state) {
                  final List<Todo> todos = state.todo;
                  if (todos.isEmpty) {
                    return const Center(child: Text("Todos is empty!"));
                  } else {
                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final Todo todo = todos[index];
                        return ListTile(
                          title: Text(todo.title),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(DeleteTodoEvent(id: todo.id));
                            },
                          ),
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (value) {
                              context
                                  .read<TodoBloc>()
                                  .add(ToggleStatusEvent(id: todo.id));
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
