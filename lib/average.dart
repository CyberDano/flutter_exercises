import 'package:flutter/material.dart';
import 'package:flutter_exercises/main.dart';

/* Class */
class Average extends StatefulWidget {
  const Average({super.key, required this.title});
  final String title;

  @override
  State<Average> createState() => _AverageScreenState();
}

/* Screen build */
class _AverageScreenState extends State<Average> {
  late TextEditingController _averageController = TextEditingController();
  var numbers = <String>[];
  String answer = "";

  @override
  void initState() {
    super.initState();
    _averageController = TextEditingController();
  }

  @override
  void dispose() {
    _averageController.dispose();
    super.dispose();
  }

  /// Average of numbers (user input)
  void GoBack() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Index()),
    );
  }

  void AddNumber() {
    if (_averageController.text.isNotEmpty) {
      numbers.add(_averageController.text);
      _averageController.text = "";
      setState(() {}); // Refrescar Interfaz
    }
    Calculate();
  }

  void Calculate() {
    if (numbers.length < 5) {
      answer = "You need five numbers.";
    } else {
      double num = 0;
      for (int n = 0; n < numbers.length; n++) {
        num = num + int.parse(numbers[n]);
        print(num);
      }
      num = num / 5;
      answer = "The average is $num";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          const Text(
              "Let's make the average of the five numbers you write down there."),
          SizedBox(
              width: 300.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextField(
                  controller: _averageController,
                  decoration: const InputDecoration(
                      labelText: "Your number...",
                      border: OutlineInputBorder()),
                ),
              )),
          if (numbers.length <= 4)
            TextButton(onPressed: AddNumber, child: const Text("Add")),
          ListView.builder(
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(numbers[index]));
            },
            shrinkWrap: true,
          ),
          Text(answer)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: GoBack,
        tooltip: 'Back to Index',
        child: const Text("Go back"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
