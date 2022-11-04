
import 'package:flutter_todo_app/model/todo.dart';
import 'package:hive/hive.dart';

class TodoService {

  late Box<Todo> _todos;

  Future<void> init() async {
    Hive.registerAdapter(TodoAdapter());
    _todos = await Hive.openBox<Todo>('todos');
    _todos.clear();
  }

  List<Todo> getTodos()  {
    return _todos.values.toList();
  }

  void newTask(Todo todo) {
    _todos.add(todo);
  }
}