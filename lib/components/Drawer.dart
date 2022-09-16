import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';

class Todo_Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Directionality(
      textDirection: TextDirection.ltr,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Colors.indigo,
            height: 140,
            child: DrawerHeader(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.check_box, color: Colors.white),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    Todo.appTitle,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(0),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Todo.appColor1,
            ),
            title: Text(
              'Home',
              style:
                  TextStyle(color: Todo.appColor1, fontFamily: 'AvenirArabic'),
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add,
              color: Todo.appColor1,
            ),
            title: Text(
              'Create new',
              style: TextStyle(color: Todo.appColor1),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/create');
            },
          ),
        ],
      ),
    ));
  }
}
