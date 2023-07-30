import 'package:flutter/material.dart';
import 'package:task_app/screens/recycle_bin.dart';
import 'package:task_app/screens/tabs_screen.dart';

import '../screens/pending_tasks.dart';


  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RecycleBin(),
        );
      case TasksScreen.routeName:
        return MaterialPageRoute(
             settings: routeSettings,
          builder: (_) => const TasksScreen(),
        );
         case TabsScreen.routeName:
        return MaterialPageRoute(
             settings: routeSettings,
          builder: (_) => const TabsScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
            body: Text("The screen doesn't exists"),
          ),
        );
    }
  }

