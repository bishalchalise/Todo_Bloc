import 'package:flutter/material.dart';
import 'package:task_app/screens/recycle_bin.dart';
import 'package:task_app/screens/tabs_screen.dart';

import '../bloc/bloc_exports.dart';

class TaskDrawer extends StatelessWidget {
  static const routeName = '/task-drawer';
  const TaskDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.folder_special),
                  title: const Text(
                    'My Tasks',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: Text(
                    '${state.pendingTasks.length} | ${state.completedTasks.length}',
                    style: const TextStyle(
                        fontSize: 20, overflow: TextOverflow.ellipsis), maxLines: 2,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      TabsScreen.routeName,
                    );
                  },
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text(
                    'Bin',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: Text(
                    '${state.removedTasks.length}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RecycleBin.routeName,
                    );
                  },
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                    value: state.switchValue,
                    onChanged: (newVal) {
                      newVal
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
