import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/page/home/home_bloc.dart';
import 'package:flutter_todo_app/ui/todo_tile.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'add_new_todo_tile.dart';

Widget renderTodos(BuildContext context) {

   void addNewTask() => {
    Navigator.of(context).pushNamed('/new_todo')
  };

  return BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      if (state is HomeLoadedState) {
        List<Widget> tiles = [];
        for (var element in state.todos) {
          tiles.add(
            TodoTile(todo: element),
          );
        }
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            ResponsiveValue(context, defaultValue: 1, valueWhen: [
              const Condition.largerThan(name: MOBILE, value: 3),
              const Condition.largerThan(name: TABLET, value: 5)
            ]).value ??
                1,
            childAspectRatio:
            ResponsiveValue(context, defaultValue: 1, valueWhen: [
              const Condition.smallerThan(name: TABLET, value: 3 / 2),
              const Condition.largerThan(name: TABLET, value: 2 / 3)
            ]).value?.toDouble() ??
                1.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          children: [
            if(ResponsiveWrapper.of(context).isLargerThan(
                TABLET)) AddNewTodoTile(onTap: addNewTask),
            ...tiles
          ],
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );


}