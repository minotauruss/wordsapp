import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordsapp/hiveword.dart';

class WordPage extends StatefulWidget {
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  
 List<hiveword> TumModel_listem = [];

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHandle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: TumModel_listem.length,
        itemBuilder: (context,index){
          var data = TumModel_listem[index];
        return Card(
          child: ListTile(
            title: Text(data.word,style: const TextStyle(fontSize: 24),),
            subtitle: Text(data.turkish),
          ),
        );
      })
    );
  }
    Future<void> getHandle() async {
    var wordDoc = Hive.box("worddoc5");
    var listbox = await wordDoc.values.toList();

    for (var a in listbox) {
      setState(() {
        TumModel_listem.add(a);
        
      });
     
    }

   

   
  }
}