import 'package:flutter/material.dart';
import 'package:notes_app/notes_todo_screen.dart';
import 'package:notes_app/sqlhelper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SqlHelper().getDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: NotesTodoScreen(),
    );
  }
}
