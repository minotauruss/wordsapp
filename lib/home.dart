import 'package:flutter/material.dart';
import 'package:wordsapp/home_page.dart';
import 'package:wordsapp/word_page.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex=0;
  final screen=[
    HomePage(),
    WordPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_currentIndex],
      
     bottomNavigationBar:  BottomNavigationBar(
        currentIndex: _currentIndex,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (value) => setState(() =>_currentIndex=value ),
        items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.work_rounded), label: 'Word')
      
      ]),
    );
  }
}