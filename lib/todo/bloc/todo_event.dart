part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}


class TodoGetDataEvent extends TodoEvent{
  const TodoGetDataEvent();

  @override
  List<Object> get props => [];
}
