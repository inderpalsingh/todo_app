import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, dynamic>> todoList = [];
  List<TodoModel> todoList = [];

  TextEditingController todoTitleController = TextEditingController();
  TextEditingController descTitleController = TextEditingController();

  DateFormat dateFormat = DateFormat.Hm();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            // return CheckboxListTile(
            //   controlAffinity: ListTileControlAffinity.leading,
            //   value: todoList[index].isCompleted,
            //   onChanged: (value) {
            //     setState(() {
            //       todoList[index].isCompleted = value!;
            //     });
            //   },
            //   title: Text(todoList[index].title),
            //   subtitle: Text(todoList[index].desc),
            //   secondary: IconButton(
            //     onPressed: () {
            //       todoList.removeAt(index);
            //       setState(() {});
            //     },
            //     icon: const Icon(Icons.delete, color: Colors.red),
            //   ),
            // );

            return ListTile(
              onTap: () {
                todoTitleController.text = todoList[index].title;
                descTitleController.text = todoList[index].desc;
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return customBottomSheet(
                          isUpdate: true, updateIndex: index, createdAt: todoList[index].createdAt, updatedAt: todoList[index].updatedAt);
                    });
              },
              title: Text(todoList[index].title),
              subtitle: Text(todoList[index].desc),
              
              leading: Checkbox(
                value: todoList[index].isCompleted,
                onChanged: (value) {
                  setState(() {
                    todoList[index].isCompleted = value!;
                  });
                },
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(todoList[index].createdAt))),
                  InkWell(
                    onTap: () {
                      todoList.removeAt(index);
                      setState(() {});
                    },
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                  Text(dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(todoList[index].updatedAt))),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoTitleController.clear();
          descTitleController.clear();

          setState(() {});
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return customBottomSheet();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Custom Function
  Widget customBottomSheet(
      {bool isUpdate = false, int updateIndex = -1,int createdAt =0 ,int updatedAt =0 }) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 600,
        child: Column(
          children: [
            Text(isUpdate ? 'Update Task' : 'Add Task'),
            const SizedBox(height: 20),
            TextField(
              controller: todoTitleController,
              decoration: const InputDecoration(
                  hintText: 'Task ..', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descTitleController,
              decoration: const InputDecoration(
                  hintText: 'Desc ..', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (!isUpdate) {
                        /*todoList.add({
                          'todoTitle': todoTitleController.text,
                          'descTitle': descTitleController.text,
                    
                        });*/

                        todoList.add(TodoModel(
                            title: todoTitleController.text,
                            desc: descTitleController.text,
                            createdAt: DateTime.now().microsecondsSinceEpoch,
                            
                        ));
                      } else {
                        /*todoList[updateInder] = {
                          'todoTitle': todoTitleController.text,
                          'descTitle': descTitleController.text
                        };*/

                        todoList[updateIndex] = TodoModel(
                            title: todoTitleController.text,
                            desc: descTitleController.text,
                            createdAt: createdAt,
                            updatedAt: DateTime.now().microsecondsSinceEpoch
                        );
                      }
                      setState(() {});

                      Navigator.pop(context);
                    },
                    child: Text(isUpdate ? 'Update Task' : 'Add Task')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text('Cancel'))
              ],
            )
          ],
        ));
  }
}
