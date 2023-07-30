import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/bloc/bloc_exports.dart';
import 'package:task_app/screens/tabs_screen.dart';
import 'package:task_app/services/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: appDocumentDir,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TasksBloc(),
        ),
        BlocProvider(
          create: (context) => SwitchBloc(),
        )
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.switchValue
                ? ThemeData(colorScheme: const ColorScheme.light(primary: Colors.teal))
                : ThemeData(colorScheme: const ColorScheme.dark(primary: Colors.black45)),
            onGenerateRoute: (settings) => onGenerateRoute(settings),
            home: const TabsScreen(),
          );
        },
      ),
    );
  }
}
