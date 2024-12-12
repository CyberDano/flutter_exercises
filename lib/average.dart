import 'package:flutter/material.dart';
import 'package:flutter_exercises/main.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 71, 183)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter exercises index'),
    );
  }
}

/* Class */
class Average extends StatefulWidget {
  const Average({super.key, required this.title});
  final String title;

  @override
  State<Average> createState() => _AverageScreenState();
}

/* Screen build */
class _AverageScreenState extends State<Average> {
  /// Average of numbers (user input)
  void GoBack() {
    runApp(const Index());
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
          Text('Testing'),
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
