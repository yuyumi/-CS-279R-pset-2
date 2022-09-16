import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';

// Make stateful widget that creates a page for editing todos
class UpdatePage extends StatefulWidget {
  final int id;

  const UpdatePage({required this.id, Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

// State object that handles the updateable interface details
class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';

  // Initialize the state by using the id from the constructor of the UpdatePage and query the name and description of the todo task
  @override
  void initState() {
    name = Todo.todos[widget.id]['name'].toString();
    description = Todo.todos[widget.id]['description'].toString();

    super.initState();
  }

  // Override the default widget build method
  @override
  Widget build(BuildContext context) {
    // Create a visual scaffold with Material Design
    return Scaffold(
      // Create an application header with a back arrow and a title
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Back arrow returns the user to the previous page (index page)
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Row(children: const [
          SizedBox(
            width: 9,
          ),
          Text('Update Todo')
        ]),
      ),
      // Body of the editing page
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
          // Form for task name, description
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
                          // Field for editing task name
                          child: TextFormField(
                            // Initially fill the form with the old name
                            initialValue: Todo.todos[widget.id]['name'],
                            decoration: const InputDecoration(
                                // Form description
                                hintText: 'Name',
                                // Decorative icon
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
                          // Field for editing description
                          child: TextFormField(
                            // Initially fill the form with the old description
                            initialValue: Todo.todos[widget.id]['description'],
                            maxLines: 4,
                            decoration: const InputDecoration(
                                // Form description
                                hintText: 'Description',
                                // Decorative icon
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
                            // Make sure the text is nonempty and alert the user otherwise
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
                  // Update button onclick validates the form fields and updates the todo task in the list, returns user to the index page
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Todo.editTodo(widget.id, name, description,
                            Todo.todos[widget.id]['complete']);
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
                  // Cancel button that returns the user to the previous screen (index page)
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
