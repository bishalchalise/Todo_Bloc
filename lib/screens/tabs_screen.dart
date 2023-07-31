import 'package:flutter/material.dart';
import 'package:task_app/screens/completed_tasks_screen.dart';
import 'package:task_app/screens/favourite_tasks_screen.dart';
import 'package:task_app/screens/pending_screen.dart';

import 'package:task_app/screens/task_drawer.dart';

import 'add_task_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {
      'pageName': const PendingTasksScreen(),
      'title': 'Pending Tasks',
    },
    {
      'pageName': const CompletedTasksScreen(),
      'title': 'Completed Tasks',
    },
    {
      'pageName': const FavouriteTasksScreen(),
      'title': 'Favourite Tasks',
    }
  ];

  var _selectedIndex = 0;

  _addTask(BuildContext context) {
    showModalBottomSheet(isScrollControlled: true,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Text(_pageDetails[_selectedIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _pageDetails[_selectedIndex]['pageName'],
      drawer: const TaskDrawer(),
      floatingActionButton: 
      _selectedIndex == 0 ?
      FloatingActionButton(
        onPressed: () => _addTask(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ):  null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle),
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
