import 'package:flutter/material.dart';
import 'package:task_app/services/guid_generator.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
    static const routeName = '/add-task-screen'; 
  const AddTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Add Task",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              label: Text(
                'Title',
              ),
              border: OutlineInputBorder(),
            ),
          ),
         const  SizedBox(height: 15,),
           TextField(
            autofocus: true,
            minLines: 3,
            maxLines: 5, 
            controller: descriptionController,
            decoration: const InputDecoration(
              label: Text(
                'Description',
              ),
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var task = Task(
                      id: GUIDGen.generate(),
                      date: DateTime.now().toString(),
                      description: descriptionController.text,
                      title: titleController.text);


                    context.read<TasksBloc>().add(
                          AddTask(task: task),
                        );
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ],
          )
        ],
      ),
    );
  }
}
