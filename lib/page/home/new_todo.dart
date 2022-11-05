import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/page/home/home_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

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

    final formKey = GlobalKey<FormState>();

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadedState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Todo'),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(

              child: Container(
                width: ResponsiveWrapper.of(context).isDesktop
                    ? 600
                    : MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(helperText: "Title"),
                      controller: titleController,
                      maxLength: 178,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the title";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(helperText: "Description"),
                      controller: descriptionController,
                      maxLength: 240,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("DATE:"),
                          ElevatedButton(
                            onPressed: () async {
                              final date = await pickDate();

                              if (date == null) return;
                              final newDateTime = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  selectedDate.hour,
                                  selectedDate.minute);
                              setState(() {
                                selectedDate = newDateTime;
                              });
                            }, // Refer step 3
                            child: Text(
                              selectedDate.toString().split(" ").first,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(8.0)),
                          const Text("TIME:"),
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
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Todo Created")));
                          BlocProvider.of<HomeBloc>(context).add(
                              CreateNewTodoEvent(Todo(titleController.text,
                                  descriptionController.text, selectedDate)));
                        }
                      }, // Refer step 3
                      child: const Text(
                        'Create',
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
