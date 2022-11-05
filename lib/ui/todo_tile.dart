import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:intl/intl.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.grey[200],
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(12.0),
            ),
            Center(
              child: FittedBox(
                child: Text(
                  todo.title,
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
            ),
            Text(todo.descritpion),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
            ),
            Text(DateFormat('yyyy-MM-dd hh:mm:ss').format(todo.dueTime)),
          ],
        ),
      ),
    );
  }
}
