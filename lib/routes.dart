import 'package:flutter_todo/screens/Home/HomePage.dart';
import 'package:flutter_todo/screens/Todo/CreatePage.dart';
import 'package:flutter_todo/screens/Todo/EditPage.dart';

class Routes {
  static int id = 0;

  static var routes = {
    '/': (context) => HomePage(),
    '/create': (context) => CreatePage(),
    '/update': (context) => UpdatePage(
          id: id,
        ),
  };
}
