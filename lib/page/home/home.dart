import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_app/page/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/page/home/new_todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadedState) {
            return ListView(children: [
              ListTile(
                title: const Text("Create new task"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (
                      context) => const NewTodo()));
                },
              ),
              ...state.todos.map((e) => ListTile(title: Text(e.title))),
            ]);
          }
          return Container();
        },
      ),
    );
  }
}