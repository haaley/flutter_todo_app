import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/page/home/home_bloc.dart';

import '../../model/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  DateTime selectedDate = DateTime.now();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hours = selectedDate.hour.toString().padLeft(2, '0');
    final minutes = selectedDate.minute.toString().padLeft(2, '0');

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if(state is HomeLoadedState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Todo'),
          ),
          body: Column(
            children: [
              TextField(
                decoration: const InputDecoration(helperText: "Title"),
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(helperText: "Description"),
                controller: descriptionController,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final date = await pickDate();

                      if (date == null) return;
                      final newDateTime = DateTime(date.year, date.month,
                          date.day, selectedDate.hour, selectedDate.minute);
                      setState(() {
                        selectedDate = newDateTime;
                      });
                    }, // Refer step 3
                    child: Text(
                      selectedDate.toString().split(" ").first,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final time = await pickTime();
                      if (time == null) return;

                      final newDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          time.hour,
                          time.minute);
                      setState(() {
                        selectedDate = newDateTime;
                      });
                    }, // Refer step 3
                    child: Text(
                      '$hours:$minutes',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<HomeBloc>(context).add(
                          CreateNewTodoEvent(Todo(titleController.text,
                              descriptionController.text, selectedDate)));
                    }, // Refer step 3
                    child: Text(
                      'Create',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute));
}
