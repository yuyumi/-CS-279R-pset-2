import 'package:flutter/material.dart';
import 'package:flutter_todo/services/saveData.dart';
import 'package:flutter_todo/theme/style.dart';
import 'package:flutter_todo/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Saved_Data.get_data();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: appTheme(),
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
