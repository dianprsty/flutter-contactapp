import 'package:contactapp/core/shared_components/bloc/theme_bloc.dart';
import 'package:contactapp/todo/bloc/todo_bloc.dart';
import 'package:contactapp/todo/model/todo_model.dart';
import 'package:contactapp/todo/view/add_todo.dart';
import 'package:contactapp/todo/view/detail_todo_screen.dart';
import 'package:contactapp/todo/view/edit_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late TodoBloc todoBloc;

  @override
  void initState() {
    super.initState();

    todoBloc = TodoBloc();
    context.read<TodoBloc>().add(const TodoGetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Todo List",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodo(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      body: SafeArea(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoFinish) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: state.todos != null ? state.todos!.length : 0,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.watch<ThemeBloc>().state is ThemeDark
                              ? Colors.white38
                              : Colors.black38,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: state.todos![index].isDone
                            ? Colors.green[300]
                            : context.watch<ThemeBloc>().state is ThemeDark
                                ? Colors.black
                                : Colors.white,
                      ),
                      duration: const Duration(milliseconds: 400),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: state.todos![index].isDone,
                                  semanticLabel: state.todos![index].title,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    Todo todo = state.todos![index];
                                    todo.isDone = !todo.isDone;
                                    context
                                        .read<TodoBloc>()
                                        .add(TodoUpdateDataEvent(todo: todo));
                                  },
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailTodoScreen(
                                              todo: state.todos![index],
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      state.todos![index].title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: state.todos![index].isDone
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                      softWrap: true,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      Todo todo = state.todos![index];
                                      return EditTodoScreen(todo: todo);
                                    }),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<TodoBloc>().add(
                                        TodoDeleteDataEvent(
                                            id: state.todos![index].id!),
                                      );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }

            if (state is TodoLoading) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      margin: const EdgeInsets.only(bottom: 8),
                      height: 65,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.watch<ThemeBloc>().state is ThemeDark
                              ? Colors.white38
                              : Colors.black38,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color:  context.watch<ThemeBloc>().state is ThemeDark
                                ? Colors.white12
                                : Colors.black12,
                      ),
                      duration: const Duration(microseconds: 300),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Flexible(
                            fit: FlexFit.tight,
                            child:  Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Text(""), //LinearProgressIndicator(),
                            ),
                          ),

                        ],
                      ),
                    
                      );
                  },
                ),
              );
            }

            return const Center(
              child: Text("No Todo Data"),
            );
          },
        ),
      ),
    );
  }
}
