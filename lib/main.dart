import 'package:flutter/material.dart';
import 'read.dart';
import 'guestbook.dart';
import 'list.dart';
import 'writeForm.dart';
import 'updateForm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/update',
      routes: {
        '/read' : (context) => ReadPage(),
        '/guest' : (context) => Guestbook(),
        '/list' : (context) => ListPage(),
        '/write' : (context) => WriteForm(),
        '/update' : (context) => UpdateForm(),
      },
    );
  }
}
