import 'package:flutter/material.dart';
import 'package:week_06_sqlite/controllers/todo_controller.dart';
import 'package:week_06_sqlite/models/todo.dart';
import 'package:week_06_sqlite/services/db.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> _todos = [];
  late int _counter;
  late TodoController _controller;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  Future<void> _initState() async {
    _controller = TodoController.getInstance(await getDatabase());
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final todos = await _controller.getTodos();
    setState(() {
      _todos = todos;
      _counter = _todos.length;
    });
  }

  Future<void> _addTodo(Todo todo) async {
    await _controller.insert(todo);
    _fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos Application'),
      ),
      body: Center(
        child: Column(
          children: [
            _todos.isEmpty
                ? const Text('No todos')
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _todos[index].description,
                            style: TextStyle(
                                decoration: _todos[index].done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          trailing: Checkbox(
                            value: _todos[index].done,
                            onChanged: (value) async {
                              setState(() {
                                _todos[index].done = value!;
                                _controller.update(_todos[index]);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
            if (_todos.isNotEmpty)
              ElevatedButton(
                onPressed: () async {
                  await _controller.deleteAll();
                  _fetchTodos();
                },
                child: const Text('Delete All'),
              ),
            const SizedBox(height: 96.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addTodo(Todo(description: 'Todo $_counter', done: false));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
