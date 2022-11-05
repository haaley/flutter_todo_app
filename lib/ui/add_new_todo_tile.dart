import 'package:flutter/material.dart';

class AddNewTodoTile extends StatelessWidget {
  const AddNewTodoTile({Key? key, required this.onTap}) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.grey[200],
      margin: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Center(child: Icon(Icons.add, size: 60.0,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
