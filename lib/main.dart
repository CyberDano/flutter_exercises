import 'package:flutter/material.dart';
import 'package:flutter_exercises/average.dart';
import 'package:flutter_exercises/roulette.dart';

void main() {
  runApp(const Index());
}

class Index extends StatelessWidget {
  const Index({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter exercises',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 71, 183)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter exercises index'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Average of numbers (user input)
  void GoToAverage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Average(title: "Average exercise")));
  }

  /// Russian roulette user vs CPU
  void GoToRoulette() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const Roulette(title: "Russian roulette exercise")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select which exercise do you want to see:',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: GoToAverage,
                  child: const Text("Average"),
                ),
                TextButton(
                  onPressed: GoToRoulette,
                  child: const Text("Russian roulette"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
