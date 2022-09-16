import 'package:flutter_todo/screens/Home/index.dart';
import 'package:flutter_todo/screens/Todo/create_page.dart';
import 'package:flutter_todo/screens/Todo/edit_page.dart';

// Routing for the pages in the Flutter app
class Routes {
  static int id = 0;

  // Upon access to a particular route, execute a particular function
  static var routes = {
    '/': (context) => const HomePage(),
    '/create': (context) => const CreatePage(),
    '/update': (context) => UpdatePage(
          id: id,
        ),
  };
}
