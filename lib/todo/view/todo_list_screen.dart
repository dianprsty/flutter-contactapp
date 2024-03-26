import 'package:contactapp/todo/bloc/todo_bloc.dart';
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
        title: const Text(
          "Todo List",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
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
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: state.todos![index]["is_done"],
                                  semanticLabel: state.todos![index]["title"],
                                  onChanged: (value) {
                                    //
                                  },
                                ),
                                Flexible(
                                    child: Text(
                                  state.todos![index]["title"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: state.todos![index]["is_done"]
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  //
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  //
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
              return const Center(
                child: CircularProgressIndicator(),
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
