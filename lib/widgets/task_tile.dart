import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/screens/edit_tasks_screen.dart';
import 'package:task_app/widgets/popup_menu.dart';

import '../bloc/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _onLongPress(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  _editTask(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: EditTaskScreen(oldTasks: task),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavourite == false
                    ? const Icon(
                        Icons.favorite_border_outlined,
                      )
                    : const Icon(
                        Icons.favorite,
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(DateFormat().add_yMEd().add_Hm().format(
                            DateTime.parse(
                              task.date,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TasksBloc>().add(
                              UpdateTask(task: task),
                            );
                      }
                    : null,
              ),
              PopupMenu(
                task: task,
                cancelOrDeleteCallBack: () => _onLongPress(context, task),
                likeOrDislike: () => context.read<TasksBloc>().add(
                      MarkFavouriteOrUnfavouriteEvent(task: task),
                    ),
                editTaskCallBack: () {
                  Navigator.of(context).pop();
                  _editTask(context);
                },
                restoreTaskCallBack: () {
                  context.read<TasksBloc>().add(
                        RestoreTaskEvent(task: task),
                      );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

//  ListTile(
//       title: Text(
//         task.title,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           decoration: task.isDone! ? TextDecoration.lineThrough : null,
//         ),
//       ),
//       trailing: Checkbox(
//         value: task.isDone,
//         onChanged: task.isDeleted == false ? (value)  {
//           context.read<TasksBloc>().add(
//               UpdateTask(task: task),
//             );} : null,
//       ),
//       onLongPress: () => _onLongPress(context, task),
//     );
