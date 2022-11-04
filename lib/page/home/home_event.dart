part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class BootstrapAppEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class LoadTodosEvent extends HomeEvent {
  @override
  List<Object?> get props => [];

}

class CreateNewTodoEvent extends HomeEvent {
  final Todo todo;

  const CreateNewTodoEvent(this.todo);
  @override
  List<Object?> get props => [todo];

}

class NewTodoCreatedEvent extends HomeEvent{
  @override
  List<Object?> get props => [];

}