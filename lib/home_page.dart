import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordsapp/hiveword.dart';
import 'package:wordsapp/info.dart';
import 'package:wordsapp/services.dart';
import 'package:wordsapp/words_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Services _services = Services();
  List<WordsModel> _model = [];
  List<hiveword> TumModel_listem = [];
  bool belirtec = true;
  bool loading = false;
  String wordNew = 'start';
  String turkish = 'Bilinmiyor';
  String defi = '';
  String fonetic = '';
  bool turk = true;
  bool iconLoadin = false;
  List<String> unifyList = [];
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  getDataService(String word) {
    _services.getData(word).then((value) {
      setState(() {
        defi = value[0].meanings![0].definitions![0].definition!;
        fonetic = value[0].phonetics![0].text!;

        belirtec = true;
        turk = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getHandle();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getEdit();
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 160),
        child: Center(
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    defi = '';
                    fonetic = '';
                    turk = true;
                  });
                },
                itemCount: unifyList.length,
                itemBuilder: (context, index) {
                  var data = unifyList[index];
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          children: [
                            loading == false
                                ? CircularProgressIndicator()
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                    child: Center(
                                        child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 24),
                                          child: Text(
                                            data.toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 42.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        belirtec == false
                                            ? CircularProgressIndicator()
                                            : Column(
                                                children: [
                                                  Container(
                                                      margin: belirtec == false
                                                          ? EdgeInsets
                                                              .symmetric(
                                                                  vertical: 24,
                                                                  horizontal:
                                                                      32)
                                                          : EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      32),
                                                      child: Text(
                                                        defi,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      )),
                                                  Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 24,
                                                          horizontal: 32),
                                                      child: Text(
                                                        fonetic,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      )),
                                                  Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 24,
                                                          horizontal: 32),
                                                      child: turk == false
                                                          ? Text(
                                                              TumModel_listem[
                                                                      index]
                                                                  .turkish,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            )
                                                          : Text('')),
                                                ],
                                              ),
                                        Container(
                                            child: Text(
                                          TumModel_listem.length.toString() +
                                              ' / ' +
                                              (index + 1).toString(),
                                          style: TextStyle(fontSize: 20),
                                        )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 24),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      getDataService(data);
                                                      belirtec = !belirtec;
                                                      '''getSetHiveWord(i.word,[_model[0].meanings![0].definitions![0].definition!],_model[0].phonetics![0].text!)''';
                                                      setState(() {});
                                                    });
                                                  },
                                                  child: Text('Get Meaning')),
                                            ),
                                            Container(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      var deleteBox =
                                                          Hive.box('worddoc5');
                                                      deleteBox.delete(
                                                          TumModel_listem[index]
                                                              .word);
                                                    });
                                                  },
                                                  child: Text('Delete Item')),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  );
                })),
      ),
    );
  }

  void getSetHiveWord(String item, String mean, bool statue) {
    DateTime _time = DateTime.now();

    hiveword _hivemodel = hiveword(
        date: _time.toString(), word: item, learn: statue, turkish: mean);
    var wordDocument = Hive.box('worddoc5');
    wordDocument.put(_hivemodel.word, _hivemodel);
  }

  Future<void> getHandle() async {
    var wordDoc = Hive.box("worddoc5");
    var listbox = await wordDoc.values.toList();

    for (var a in listbox) {
      setState(() {
        TumModel_listem.add(a);
        unifyList.add(a.word.toString());
      });
    }
  

    for (var b in word_list) {
      setState(() {
        unifyList.add(b);
      });
    }

    setState(() {
      loading = true;
    });
  }

  void getEdit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: Text(
                          'Girmek istediginiz kelime ve anlamını belirtiniz'),
                    ),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          label: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Text("kelime giriniz")),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: 'kelime giriniz',
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextField(
                      minLines: 4,
                      maxLines: 5,
                      controller: _controller2,
                      decoration: InputDecoration(
                          label: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Text("Anlam giriniz")),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: 'Anlam giriniz',
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getSetHiveWord(
                              _controller.text, _controller2.text, false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Text('kaydet'))
                  ],
                ),
              ),
            ));
  }
}
