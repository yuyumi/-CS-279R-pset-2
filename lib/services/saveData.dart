import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Saved_Data {
  static Future<void> set_data(List<dynamic> _data) async {
    String d = json.encode(_data);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('all_tasks', d);
  }

  static Future<void> get_data() async {
    final prefs = await SharedPreferences.getInstance();
    String all_tasks = '';
    all_tasks = (prefs.getString('all_tasks') != null
        ? prefs.getString('all_tasks')
        : '')!;
    print(all_tasks);
    if (all_tasks != '') {
      Todo.all_tasks = json.decode(all_tasks) as List<dynamic>;
      //return json.decode(all_tasks);
    } else {
      //return [];
    }
  }
}
