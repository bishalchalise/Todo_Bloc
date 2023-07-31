import 'package:flutter/material.dart';
import '../bloc/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatelessWidget {
  static const routeName = '/pending-tasks-screen';
  const PendingTasksScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTasks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  'Pending Tasks: ${taskList.length} | Completed Tasks: ${state.completedTasks.length}',
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
