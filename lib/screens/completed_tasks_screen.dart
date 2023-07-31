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
        List<Task> taskList = state.completedTasks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  'Completed Tasks: ${taskList.length} | Pending Tasks: ${state.pendingTasks.length}',

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
