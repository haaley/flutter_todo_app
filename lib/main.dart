import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/page/home/home.dart';
import 'package:flutter_todo_app/page/home/home_bloc.dart';
import 'package:flutter_todo_app/service/todo_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(create: (context) => TodoService(),
      child: BlocProvider(
        create: (context) => HomeBloc(RepositoryProvider.of<TodoService>(context))..add(BootstrapAppEvent()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
