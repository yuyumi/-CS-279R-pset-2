import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(children: const [
            SizedBox(
              width: 9,
            ),
            Text('Todo App')
          ]),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
          color: Colors.white,
          child: ReorderableListView(
            onReorder: (int start, int current) {
              // dragging from top to bottom
              if (start < current) {
                int end = current - 1;
                dynamic startItem = Todo.all_tasks[start];
                int i = 0;
                int local = start;
                do {
                  Todo.all_tasks[local] = Todo.all_tasks[++local];
                  i++;
                } while (i < end - start);
                Todo.all_tasks[end] = startItem;
              }
              // dragging from bottom to top
              else if (start > current) {
                dynamic startItem = Todo.all_tasks[start];
                for (int i = start; i > current; i--) {
                  Todo.all_tasks[i] = Todo.all_tasks[i - 1];
                }
                Todo.all_tasks[current] = startItem;
              }
              setState(() {
                Todo.set_all_tasks(Todo.all_tasks);
              });
            },
            children: [
              for (int i = 0; i < Todo.all_tasks.length; i++)
                ListTile(
                  key: Key("${i}"),
                  leading: InkWell(
                      child: Icon(
                        Todo.is_task_completed(i)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      onTap: () {
                        setState(() {
                          Todo.task_complete(i);
                        });
                      }),
                  title: Text("${Todo.all_tasks[i]['name']}",
                      style: TextStyle(
                          decoration: Todo.is_task_completed(i)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  subtitle: Text("${Todo.all_tasks[i]['description']}",
                      style: TextStyle(
                          decoration: Todo.is_task_completed(i)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  trailing: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Row(
                      children: [
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
                                              Todo.del_task(context, i);
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
              //_list.map((item) => .toList()
            ],
          ),
        ),
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
