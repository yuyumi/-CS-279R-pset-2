import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/routes.dart';

// Create a homepage that has updatable states
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // Override the default createState method to execute the _HomePageState constructor
  @override
  State<HomePage> createState() => _HomePageState();
}

// The state object of the homepage
class _HomePageState extends State<HomePage> {
  // Override default initialization to initialize the HomePage class
  @override
  void initState() {
    super.initState();
  }

  // Override the default build method
  @override
  Widget build(BuildContext context) {
    // Use the SafeArea method to create a homepage that works for most standard operating systems
    return SafeArea(
      // Creates a visual scaffold for Material Design widgets.
      child: Scaffold(
        // Creates a Material Design application header bar
        appBar: AppBar(
          title: Row(children: const [
            SizedBox(
              width: 9,
            ),
            Text('Todo App')
          ]),
        ),
        // Updateable container
        body: Container(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
          color: Colors.white,
          // Allows reordering of todo items
          child: ReorderableListView(
            onReorder: (int start, int current) {
              // Allows dragging a todo task from top to bottom
              if (start < current) {
                int end = current - 1;
                dynamic startItem = Todo.todos[start];
                int i = 0;
                int local = start;
                // Swap the selected todo item with the other items in the list
                do {
                  Todo.todos[local] = Todo.todos[++local];
                  i++;
                } while (i < end - start);
                Todo.todos[end] = startItem;
              }
              // Allows dragging a todo task from bottom to top
              else if (start > current) {
                dynamic startItem = Todo.todos[start];
                // Swap the selected todo item with the other items in the list
                for (int i = start; i > current; i--) {
                  Todo.todos[i] = Todo.todos[i - 1];
                }
                Todo.todos[current] = startItem;
              }
              // Update the list of todos
              setState(() {
                Todo.setTodos(Todo.todos);
              });
            },
            // Decorate each todo list item with mark as completed box, an edit icon, and a delete icon
            children: [
              for (int i = 0; i < Todo.todos.length; i++)
                ListTile(
                  key: Key("$i"),
                  // Checkbox icon
                  leading: InkWell(
                      child: Icon(
                        Todo.isCompleted(i)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      onTap: () {
                        setState(() {
                          Todo.markComplete(i);
                        });
                      }),
                  // Todo item name and description
                  title: Text("${Todo.todos[i]['name']}",
                      style: TextStyle(
                          decoration: Todo.isCompleted(i)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  subtitle: Text("${Todo.todos[i]['description']}",
                      style: TextStyle(
                          decoration: Todo.isCompleted(i)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  trailing: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Row(
                      children: [
                        // Edit icon that onclick routes to the '/update' page
                        InkWell(
                            child: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onTap: () {
                              Routes.id = i;
                              Navigator.pushNamed(context, '/update');
                            }),
                        const SizedBox(
                          width: 5,
                        ),
                        // Delete icon that onclick shows a confirmation screen, clicking 'Yes' triggers the delete function of the Todo class
                        InkWell(
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirmation"),
                                      content: const Text(
                                          "Are you sure you want to delete?"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text("Yes"),
                                          onPressed: () {
                                            setState(() {
                                              Todo.deleteTodo(context, i);
                                            });
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Deleted Successfully')),
                                            );
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("No"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            })
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
        // '+' icon which onclick sends the user to the '/create' page to create a new todo task
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create');
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
