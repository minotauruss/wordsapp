import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordsapp/hiveword.dart';
import 'package:wordsapp/home.dart';
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
          child: Icon(Icons.add)),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
        ),
        child: AspectRatio(
          aspectRatio: MediaQuery.of(context).size.width * 0.00143,
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
                    return Center(
                      child: Container(
                        child: Row(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 18,
                              child: Column(
                                children: [
                                  loading == false
                                      ? CircularProgressIndicator()
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 36),
                                          decoration: BoxDecoration(
                                              color: Colors.amber),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 36),
                                                child: Text(
                                                  data.toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 42.0,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                            margin: belirtec ==
                                                                    false
                                                                ? const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        24,
                                                                    horizontal:
                                                                        32)
                                                                : const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        32),
                                                            child: Text(
                                                              defi,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            )),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        24,
                                                                    horizontal:
                                                                        32),
                                                            child: Text(
                                                              fonetic,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            )),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        24,
                                                                    horizontal:
                                                                        32),
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
                                                                      fontSize:
                                                                          16.0,
                                                                    ),
                                                                  )
                                                                : Text('')),
                                                      ],
                                                    ),
                                              Container(
                                                  child: Text(
                                                '${TumModel_listem.length} / ${index + 1}',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 24),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            getDataService(
                                                                data);
                                                            belirtec =
                                                                !belirtec;
                                                            '''getSetHiveWord(i.word,[_model[0].meanings![0].definitions![0].definition!],_model[0].phonetics![0].text!)''';
                                                            setState(() {});
                                                          });
                                                        },
                                                        child: Text(
                                                            'Get Meaning')),
                                                  ),
                                                  Container(
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          var deleteBox =
                                                              Hive.box(
                                                                  'worddoc5');
                                                          deleteBox.delete(
                                                              TumModel_listem[
                                                                      index]
                                                                  .word);
                                                        },
                                                        child: Text(
                                                            'Delete item')),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))),
                                ],
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                    );
                  })),
        ),
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
                      child: const Text(
                          'Girmek istediginiz kelime ve anlamını belirtiniz'),
                    ),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          label: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: const Text("kelime giriniz")),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()),
                          hintText: 'kelime giriniz',
                          hintStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    const SizedBox(
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
                          hintStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getSetHiveWord(
                              _controller.text, _controller2.text, false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                        child: const Text('kaydet'))
                  ],
                ),
              ),
            ));
  }
}
