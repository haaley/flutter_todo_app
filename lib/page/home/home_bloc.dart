import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/service/todo_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final TodoService _service;

  HomeBloc(this._service) : super(RegisterServicesState()) {

    on<BootstrapAppEvent>((event, emit) async {
      await _service.init();
      add(LoadTodosEvent());
    });

    on<LoadTodosEvent>((event, emit) async {
      final todos = _service.getTodos();
      emit(HomeLoadedState(todos));
    });

    on<CreateNewTodoEvent>((event, emit) async {
      _service.newTask(event.todo);
      add(NewTodoCreatedEvent());
    });

    on<NewTodoCreatedEvent>((event, emit) async {
      add(LoadTodosEvent());
    });
  }
}