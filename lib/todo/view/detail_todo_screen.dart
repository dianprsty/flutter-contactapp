import 'package:contactapp/todo/model/todo_model.dart';
import 'package:contactapp/todo/view/todo_list_screen.dart';
import 'package:flutter/material.dart';

class DetailTodoScreen extends StatefulWidget {
  const DetailTodoScreen({Key? key, required this.todo}) : super(key: key);
  final Todo todo;
  @override
  _DetailTodoScreenState createState() => _DetailTodoScreenState();
}

class _DetailTodoScreenState extends State<DetailTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Detail Todo",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoListScreen(),
                ),
                (route) => route.isFirst,
              );
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.todo.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                widget.todo.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ));
  }
}
