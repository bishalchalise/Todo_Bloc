import 'package:flutter/material.dart';
import '../bloc/bloc_exports.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTasks;
  static const routeName = '/edit-task-screen';
  const EditTaskScreen({
    required this.oldTasks,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: oldTasks.title);
    TextEditingController descriptionController = TextEditingController(text: oldTasks.description );
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Edit  Task",
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
          const SizedBox(
            height: 15,
          ),
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
                    var editedTask = Task(
                        id: oldTasks.id,
                        isFavourite: oldTasks.isFavourite,
                        isDone: false,
                        date: DateTime.now().toString(),
                        description: descriptionController.text,
                        title: titleController.text);

                    context.read<TasksBloc>().add(
                          EditTaskEvent(
                            
                            oldTask: oldTasks,
                            newTask: editedTask,
                            ),
                        );
                    Navigator.pop(context);
                  },
                  child: const Text('Save')),
            ],
          )
        ],
      ),
    );
  }
}
