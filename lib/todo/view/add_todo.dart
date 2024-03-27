import 'package:contactapp/todo/bloc/todo_bloc.dart';
import 'package:contactapp/todo/model/todo_model.dart';
import 'package:contactapp/todo/view/todo_list_screen.dart';
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late TodoBloc todoBloc;

  @override
  void initState() {
    super.initState();
    setState(() {
      todoBloc = TodoBloc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                const Text(
                  "Create Todo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Title can't be empty";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null) {
                            return "Description can't be empty";
                          }

                          return null;
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: const InputDecoration(
                          labelText: "Description",
                          hintText: "Description",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          contentPadding: EdgeInsets.all(16),
                        ),
                        minLines: 4,
                        maxLines: 20,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          Todo newTodo = Todo(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            isDone: false,
                          );

                          todoBloc.add(TodoAddDataEvent(todo: newTodo));

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TodoListScreen(),
                            ),
                            (route) => route.isFirst,
                          );
                        },
                        style: const ButtonStyle(
                          minimumSize:
                              MaterialStatePropertyAll(Size.fromHeight(48)),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                          iconColor: MaterialStatePropertyAll(Colors.white),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue),
                        ),
                        child: const Text(
                          "Create",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TodoListScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                            Colors.white,
                          ),
                          foregroundColor: const MaterialStatePropertyAll(
                            Colors.black,
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: const BorderSide(color: Colors.black)),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
