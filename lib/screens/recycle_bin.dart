import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';

import '../widgets/tasks_list.dart';
import 'task_drawer.dart';

class RecycleBin extends StatelessWidget {
  static const routeName = '/recycle-bin';
  const RecycleBin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
      
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Recycle Bin'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: const TaskDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Deleted Tasks: ${state.removedTasks.length}',
                  ),
                ),
              ),
              TasksList(taskList: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
