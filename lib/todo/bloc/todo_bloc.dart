import 'package:bloc/bloc.dart';
import 'package:contactapp/todo/model/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    final supabase = Supabase.instance.client;
    SharedPreferences pref;
    on<TodoGetDataEvent>((event, emit) async {
      emit(TodoLoading());
      pref = await SharedPreferences.getInstance();
      String userEmail = pref.getString("email") ?? "";

      var todos = await supabase
          .from("todos")
          .select()
          .eq("user_email", userEmail)
          .order("created_at", ascending: true)
          .order("is_done", ascending: true);
      List<Todo>? todosObject = [];
      for (var todo in todos) {
        Todo todoObject = Todo.fromJson(todo);
        todosObject.add(todoObject);
      }
      emit(TodoFinish(todos: todosObject));
    });
    on<TodoAddDataEvent>((event, emit) async {
      emit(TodoLoading());
      pref = await SharedPreferences.getInstance();
      String? userEmail = pref.getString("email");

      var todos = await supabase
          .from('todos')
          .insert([
            {
              "title": event.todo.title,
              "description": event.todo.description,
              "is_done": event.todo.isDone,
              "user_email": userEmail ?? "",
            }
          ])
          .eq("user_emai", userEmail!)
          .select();
      List<Todo>? todosObject = [];
      for (var todo in todos) {
        Todo todoObject = Todo.fromJson(todo);
        todosObject.add(todoObject);
      }
      emit(TodoFinish(todos: todosObject));
    });
    on<TodoUpdateDataEvent>((event, emit) async {
      emit(TodoLoading());
      pref = await SharedPreferences.getInstance();
      String? userEmail = pref.getString("email");
      await supabase.from('todos').update({
        "title": event.todo.title,
        "description": event.todo.description,
        "is_done": event.todo.isDone,
        "user_email": userEmail ?? "",
        "updated_at": DateTime.now().toString(),
      }).eq("id", event.todo.id!);

      add(const TodoGetDataEvent());
    });
    on<TodoDeleteDataEvent>((event, emit) async {
      emit(TodoLoading());
      await supabase.from('todos').delete().eq("id", event.id);

      add(const TodoGetDataEvent());
    });
  }
}
