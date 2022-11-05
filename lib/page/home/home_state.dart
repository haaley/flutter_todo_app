part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class RegisterServicesState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final List<Todo> todos;

  const HomeLoadedState(this.todos);

  @override
  List<Object?> get props => [todos];

}

class EmptyTodosState extends HomeState {
  @override
  List<Object?> get props => [];

}

class CreateNewTodoState extends HomeState {
  @override
  List<Object?> get props => [];

}

class NewTodoCreatedState extends HomeState{
  @override
  List<Object?> get props => [];

}