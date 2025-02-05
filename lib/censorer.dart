import 'package:flutter/material.dart';
import 'package:flutter_exercises/main.dart';

/* Class */
class Censorer extends StatefulWidget {
  const Censorer({super.key, required this.title});
  final String title;

  @override
  State<Censorer> createState() => _CensorerScreenState();
}

/* Screen build */
class _CensorerScreenState extends State<Censorer> {
  // ignore: prefer_final_fields
  late TextEditingController _censorController = TextEditingController();
  bool checked = false;
  String checkedSentence = "";
// ignore: non_constant_identifier_names
  void CheckText(String sentence) {
    checkedSentence = "";
    List<String> words = sentence.split(" ");
    List<String> cherckedWords = [];
    for (int w = 0; w < words.length; w++) {
      if (words[w].startsWith("J") ||
          words[w].startsWith("j") ||
          words[w].startsWith("M") ||
          words[w].startsWith("m") ||
          words[w].startsWith("P") ||
          words[w].startsWith("p")) {
        String tempWord = words[w].replaceRange(1, words[w].length, "*");
        cherckedWords.add(tempWord);
      } else {
        cherckedWords.add(words[w]);
      }
    }
    checked = true;
    for (int i = 0; i < cherckedWords.length; i++) {
      checkedSentence += "${cherckedWords[i]} ";
    }
    checkedSentence = "Checked sentence:\n$checkedSentence";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double widgetWidth =
              screenWidth * 0.7; // 70% del ancho de la pantalla
          return Column(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(10), child: Text('Censorer')),
              SizedBox(
                  width: widgetWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        TextField(
                          controller: _censorController,
                          decoration: const InputDecoration(
                              labelText: "Enter your text...",
                              border: OutlineInputBorder()),
                        ),
                        TextButton(
                            onPressed: () => CheckText(_censorController.text),
                            child: const Text("Check"))
                      ],
                    ),
                  )),
              TextButton(
                  onPressed: () =>
                      _censorController.text = "Jesús esto es una pera madura",
                  child: const Text("Default sentence")),
              if (checked) Text(checkedSentence)
            ],
          );
        },
      ),
      floatingActionButton: Method.goToHome(context),
    );
  }
}
