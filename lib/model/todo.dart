import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String descritpion;
  @HiveField(2)
  final DateTime dueTime;

  Todo(this.title, this.descritpion, this.dueTime);
}