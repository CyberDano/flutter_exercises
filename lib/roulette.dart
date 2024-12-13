import 'package:flutter/material.dart';
import 'package:flutter_exercises/main.dart';

/* Class */
class Roulette extends StatefulWidget {
  const Roulette({super.key, required this.title});
  final String title;

  @override
  State<Roulette> createState() => _RouletteScreenState();
}

/* Screen build */
class _RouletteScreenState extends State<Roulette> {
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
      body: const Column(
        children: <Widget>[
          Text('Рулетка'),
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
