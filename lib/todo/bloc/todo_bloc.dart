import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    final supabase = Supabase.instance.client;
    on<TodoGetDataEvent>((event, emit) async {
      emit(TodoLoading());
      var todos = await supabase.from("todos").select();
      emit(TodoFinish(todos: todos));
    });
  }
}
