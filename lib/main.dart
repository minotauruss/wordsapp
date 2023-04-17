import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordsapp/hiveword.dart';
import 'package:wordsapp/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(hivewordAdapter());
  await Hive.openBox("worddoc5");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English Words App',
      theme: ThemeData(
  
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
