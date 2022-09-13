// Import packages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nanoid/nanoid.dart';

// Creates a stateless widget class named App
class App extends StatelessWidget {
  // Tells the Dart analyzer to override interface build methods with this method
  @override
  // Create a MaterialApp interface with title 'To-Do List' and create  an instance of the TodoList class
  Widget build(BuildContext context) {
    return MaterialApp(title: 'To-Do List', home: TodoList());
  }
}

// Creates a stateful widget class named TodoList
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  // Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(title: Text(title));
  }

  // Generate a single item widget
  Future<dynamic> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}

// Runs the main application
void main() => runApp(App());
