import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';
import 'package:todo_app/view/bottom_nav.dart';
import 'package:todo_app/view/pages/event_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
   providers: [ChangeNotifierProvider<Controller>(create: (_)=>Controller())],
      child: MaterialApp(
        title: 'todo_list',
        theme: ThemeData(
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomNav()
      ),
    );
  }
}
