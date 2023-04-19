import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordsapp/home_page.dart';

// ignore: must_be_immutable
class DeleteElevateButton extends StatelessWidget {
  String id;
  String name;
  DeleteElevateButton({required this.id,required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          var deleteBox = Hive.box('worddoc5');
          deleteBox.delete(id);
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: Text(name));
  }
}
