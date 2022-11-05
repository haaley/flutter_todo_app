import 'package:flutter/material.dart';
import 'package:flutter_todo_app/page/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/ui/display_task.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;

    return Row(
      children: [
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Todo List"),
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: displayMobileLayout,
            ),
            floatingActionButton: ResponsiveVisibility(
              visible: false,
              visibleWhen: const [Condition.smallerThan(name: DESKTOP)],
              child: FloatingActionButton(
                onPressed: () {Navigator.of(context).pushNamed('/new_todo');},
                child: (const Icon(Icons.add)),
              ),
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedState) {
                  return renderTodos(context);
                }
                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}
