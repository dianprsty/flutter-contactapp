part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoGetDataEvent extends TodoEvent {
  const TodoGetDataEvent();

  @override
  List<Object> get props => [];
}

class TodoAddDataEvent extends TodoEvent {
  final Todo todo;

  const TodoAddDataEvent({required this.todo});

  @override
  List<Object> get props => [];
}


class TodoUpdateDataEvent extends TodoEvent {
  final Todo todo;
  
  const TodoUpdateDataEvent({required this.todo});

  @override
  List<Object> get props => [];
}


class TodoDeleteDataEvent extends TodoEvent {
  final int id;
  
  const TodoDeleteDataEvent({required this.id});

  @override
  List<Object> get props => [];
}
