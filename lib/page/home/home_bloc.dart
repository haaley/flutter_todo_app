import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/service/notification_service.dart';
import 'package:flutter_todo_app/service/todo_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoService _service;
  final NotificationService _notificationService;

  HomeBloc(this._service, this._notificationService)
      : super(RegisterServicesState()) {
    on<BootstrapAppEvent>((event, emit) async {
      await _service.init();
      await _notificationService.initialize();
      add(LoadTodosEvent());
    });

    on<LoadTodosEvent>((event, emit) async {
      final todos = _service.getTodos();
      if(todos.isEmpty){
        emit(EmptyTodosState());
        return;
      }
      emit(HomeLoadedState(todos));
    });

    on<CreateNewTodoEvent>((event, emit) async {
      _service.newTask(event.todo);
      _notificationService.showScheduledNotification(
          id: 1,
          title: event.todo.title,
          body: event.todo.descritpion,
          dateTime: event.todo.dueTime);
      add(NewTodoCreatedEvent());
    });

    on<NewTodoCreatedEvent>((event, emit) async {
      add(LoadTodosEvent());
    });
  }
}
