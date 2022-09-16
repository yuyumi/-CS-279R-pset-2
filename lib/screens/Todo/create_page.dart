import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Row(children: const [
          //Icon(Icons.check_box),
          SizedBox(
            width: 9,
          ),
          Text('Create Todo')
        ]),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const Center(
              child: Text(
            'Create new',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Material(
                          elevation: 2.0,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          child: TextFormField(
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
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Material(
                          elevation: 2.0,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          child: TextFormField(
                            maxLines: 4,
                            decoration: const InputDecoration(
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
                        Todo.add_task(name, description);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added Successfully')),
                        );
                      }
                    },
                    child: const Text('Add'),
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
