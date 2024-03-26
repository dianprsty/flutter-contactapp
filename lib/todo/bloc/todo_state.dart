part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();
  
  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}
final class TodoLoading extends TodoState {}
final class TodoFinish extends TodoState {
  final List<Map<String, dynamic>>? todos;

  const TodoFinish({required this.todos});
}
