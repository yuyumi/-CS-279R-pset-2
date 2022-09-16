import 'package:flutter_todo/screens/Home/index.dart';
import 'package:flutter_todo/screens/Todo/create_page.dart';
import 'package:flutter_todo/screens/Todo/edit_page.dart';

class Routes {
  static int id = 0;

  static var routes = {
    '/': (context) => const HomePage(),
    '/create': (context) => const CreatePage(),
    '/update': (context) => UpdatePage(
          id: id,
        ),
  };
}
