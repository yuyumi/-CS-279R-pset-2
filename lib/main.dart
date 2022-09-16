// Import the Material package for app design and layout
import 'package:flutter/material.dart';
import 'package:flutter_todo/services/save_data.dart';
import 'package:flutter_todo/theme/style.dart';
import 'package:flutter_todo/routes.dart';

// Asynchronously get the TodoList data from SharedPreferences and run the main application
Future<void> main() async {
  // Ensure that the Flutter engine is running so SharedPreferences functions can be called
  WidgetsFlutterBinding.ensureInitialized();

  // Get the data from SharedPreferences
  await TodoList.getData();

  // Run the Todo list app
  runApp(TodoApp());
}

// Create a Stateless widget of the TodoApp, essentially the outermost interface layer of the application
class TodoApp extends StatelessWidget {
  // Override the default build method and create a Material style app
  @override
  Widget build(BuildContext context) {
    // Create a Material style app with initial routing being the index page
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: appTheme(),
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
