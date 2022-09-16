import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';

class UpdatePage extends StatefulWidget {
  final int id;

  const UpdatePage({required this.id, Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  @override
  void initState() {
    name = Todo.all_tasks[widget.id]['name'].toString();
    description = Todo.all_tasks[widget.id]['description'].toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Row(children: const [
          SizedBox(
            width: 9,
          ),
          Text('Update Todo')
        ]),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const Center(
              child: Text(
            'Update task',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          child: TextFormField(
                            initialValue: Todo.all_tasks[widget.id]['name'],
                            decoration: const InputDecoration(
                                hintText: 'Name',
                                prefixIcon: Material(
                                  elevation: 0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: Icon(
                                    Icons.task,
                                    color: Colors.cyan,
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 13)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              name = value.toString();
                            },
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          child: TextFormField(
                            initialValue: Todo.all_tasks[widget.id]
                                ['description'],
                            maxLines: 4,
                            decoration: const InputDecoration(
                                //labelText: 'Description',
                                hintText: 'Description',
                                prefixIcon: Material(
                                  elevation: 0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: Icon(
                                    Icons.description,
                                    color: Colors.cyan,
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 13)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              description = value.toString();
                            },
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Todo.upd_task(widget.id, name, description,
                            Todo.all_tasks[widget.id]['complete']);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Updated Successfully')),
                        );
                      }
                    },
                    child: const Text('Update'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
