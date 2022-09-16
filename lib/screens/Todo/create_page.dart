import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';

// Make stateful widget that creates a page for creating todos
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  // Override the default state creation function to have a custom state
  @override
  State<CreatePage> createState() => _CreatePageState();
}

// State object that handles the updateable interface details
class _CreatePageState extends State<CreatePage> {
  // Access the key to make sure the form details can be accessed globally
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';

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
          Text('Create Todo')
        ]),
      ),
      // Body of the creation page
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
                          // Field for making a task name
                          child: TextFormField(
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
                            // Make sure the text is nonempty and alert the user otherwise
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
                          // Field for making a task description
                          child: TextFormField(
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
                  // Add button onclick validates the form fields and adds the todo task to the list, returns user to the index page
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Todo.addTodo(name, description);
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
