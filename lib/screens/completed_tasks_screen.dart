import 'package:flutter/material.dart';
import '../bloc/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  static const routeName = '/completed-tasks-screen';
  const CompletedTasksScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.allTasks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  'Tasks: ${taskList.length}',
                ),
              ),
            ),
            TasksList(
              taskList: taskList,
            ),
          ],
        );
      },
    );
  }
}
