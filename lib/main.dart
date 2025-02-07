import 'package:flutter/material.dart';
import 'package:flutter_exercises/average.dart';
import 'package:flutter_exercises/censorer.dart';
import 'package:flutter_exercises/freeTimeCalculator.dart';
import 'package:flutter_exercises/romanTranslate.dart';
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
  // ignore: non_constant_identifier_names
  GoToScreen(int i) {
    if (i == 1) {
      /// Average of numbers (user input)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Average(title: "Average exercise")));
    }
    if (i == 2) {
      /// Russian roulette user vs CPU
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const Roulette(title: "Russian roulette exercise")));
    }
    if (i == 3) {
      /// Hides bad words (user input)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const Censorer(title: "Censorer exercise")));
    }
    if (i == 4) {
      /// Hides bad words (user input)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const RomanTranslate(title: "Roman numbers translator")));
    }
    if (i == 5) {
      /// Hides bad words (user input)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FreeTimeCalc(title: "Free time calculator")));
    }
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
              style: TextStyle(
                  color: Color.fromARGB(255, 17, 0, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => GoToScreen(1),
                  child: const Text("Average"),
                ),
                TextButton(
                  onPressed: () => GoToScreen(2),
                  child: const Text("Russian roulette"),
                ),
                TextButton(
                  onPressed: () => GoToScreen(3),
                  child: const Text("Censorer"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => GoToScreen(4),
                  child: const Text("Roman translator"),
                ),
                TextButton(
                  onPressed: () => GoToScreen(5),
                  child: const Text("Free time calculator"),
                ),
                TextButton(
                  onPressed: () => GoToScreen(4),
                  child: const Text("Room manager"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Method {
  // ignore: non_constant_identifier_names
  static FloatingActionButton goToHome(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      child: const Icon(Icons.home),
    );
  }
}
