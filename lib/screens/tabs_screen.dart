import 'package:flutter/material.dart';
import 'package:task_app/screens/pending_tasks.dart';
import 'package:task_app/screens/task_drawer.dart';

import 'add_task_screen.dart';

class TabsScreen extends StatelessWidget {
  static const routeName = '/tabs-screen';
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _addTask(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: const AddTaskScreen(),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Screen'),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: const TasksScreen(),
      drawer: const TaskDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (value) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pending Tasks',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed Tasks',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite Tasks',
          ),
        ],
      ),
    );
  }
}
