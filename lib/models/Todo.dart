import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo/services/save_data.dart';

class Todo {
  static String appTitle = "Todo App";

  static List<dynamic> all_tasks = [];

  static void set_all_tasks(List<dynamic> t) {
    all_tasks = t;
    TodoList.set_data(all_tasks);
  }

  static void task_complete(int id) {
    all_tasks[id]['complete'] = all_tasks[id]['complete'] == '0' ? '1' : '0';
    TodoList.set_data(all_tasks);
  }

  static bool is_task_completed(int id) {
    return all_tasks[id]['complete'] == '1' ? true : false;
  }

  static void add_task(String name, String description) {
    all_tasks.add({'name': name, 'description': description, 'complete': '0'});
    TodoList.set_data(all_tasks);
  }

  static void upd_task(int id, String name, String description, complete) {
    all_tasks[id] = {
      'name': name,
      'description': description,
      'complete': complete
    };
    TodoList.set_data(all_tasks);
  }

  static void del_task(BuildContext context, int id) {
    all_tasks.removeAt(id);
    TodoList.set_data(all_tasks);
  }
}
