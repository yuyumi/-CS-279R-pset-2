import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo/services/save_data.dart';

// Todo item object that interacts with the TodoList
class Todo {
  // Initialize the todo item list
  static List<dynamic> todos = [];

  // CRUD Operations

  // Set the todos of the todo list to be the input
  static void setTodos(List<dynamic> todos) {
    TodoList.setData(todos);
  }

  // Add a todo, default marking the todo as incomplete
  static void addTodo(String name, String description) {
    todos.add({'name': name, 'description': description, 'complete': '0'});
    TodoList.setData(todos);
  }

  // Update a todo queried by id
  static void editTodo(int id, String name, String description, complete) {
    todos[id] = {
      'name': name,
      'description': description,
      'complete': complete
    };
    TodoList.setData(todos);
  }

  // Mark a todo queried by id as complete
  static void markComplete(int id) {
    todos[id]['complete'] = todos[id]['complete'] == '0' ? '1' : '0';
    TodoList.setData(todos);
  }

  // Determine whether a todo queried by id is complete
  static bool isCompleted(int id) {
    return todos[id]['complete'] == '1' ? true : false;
  }

  // Delete a todo queried by id
  static void deleteTodo(BuildContext context, int id) {
    todos.removeAt(id);
    TodoList.setData(todos);
  }
}
