import 'dart:convert';
import 'package:flutter_todo/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

// An object that stores the todo list items into a json that is fed into SharedPreferences for local storage
class TodoList {
  // Asynchronously store the data into SharedPreferences
  static Future<void> setData(List<dynamic> todos) async {
    // Create a json from the list of todo items
    String todoString = json.encode(todos);

    // Create an instance of SharedPreferences in local storage and store the json of the todo items with 'taskList' as the key
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('taskList', todoString);
  }

  // Asynchronously get the data from local storage
  static Future<void> getData() async {
    // Retrieve the instance of SharedPreferences from local storage
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the json of the todo list and store it as a renderable object
    // Silently fail if todo list does not exist in the local storage
    String taskList = (prefs.getString('taskList') ?? '');
    if (taskList != '') {
      Todo.todos = json.decode(taskList) as List<dynamic>;
    }
  }
}
