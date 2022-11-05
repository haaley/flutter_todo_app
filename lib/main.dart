import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/page/home/home.dart';
import 'package:flutter_todo_app/page/home/home_bloc.dart';
import 'package:flutter_todo_app/page/home/new_todo.dart';
import 'package:flutter_todo_app/service/notification_service.dart';
import 'package:flutter_todo_app/service/todo_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';


void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TodoService(),
        ),
        RepositoryProvider(
          create: (context) => NotificationService(),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
        HomeBloc(RepositoryProvider.of<TodoService>(context), RepositoryProvider.of<NotificationService>(context))
          ..add(BootstrapAppEvent()),
        child: MaterialApp(
          builder: (context, child) => ResponsiveWrapper.builder(
              child,
              minWidth: 320,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(600, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1280, name: DESKTOP),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),

          initialRoute: "/",
          routes: {
            '/': (context) => const HomePage(),
            '/new_todo': (context) => const NewTodo(),
          },
        ),
      ),
    );
  }
}
