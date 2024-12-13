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
              "Let's make the average ot the five numbers you write down there."),
          TextField(
            controller: _averageController,
            decoration: const InputDecoration(
                labelText: "First number", border: OutlineInputBorder()),
          ),
          TextField(
            controller: _averageController,
            decoration: const InputDecoration(
                labelText: "Second number", border: OutlineInputBorder()),
          ),
          TextField(
            controller: _averageController,
            decoration: const InputDecoration(
                labelText: "Third number", border: OutlineInputBorder()),
          ),
          TextField(
            controller: _averageController,
            decoration: const InputDecoration(
                labelText: "Fourth number", border: OutlineInputBorder()),
          ),
          TextField(
            controller: _averageController,
            decoration: const InputDecoration(
                labelText: "Fifth number", border: OutlineInputBorder()),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: GoBack,
        tooltip: 'Back to Index',
        child: const Text("Go back"),
      ),
    );
  }
}
