import 'dart:math';

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
  final TextEditingController _controller = TextEditingController();
  List<int> chamber = List.generate(6, (index) => index + 1);
  int bulletPosition = Random().nextInt(6) + 1;
  String message = "Choose a valid slot (1-6):";

  void playTurn(int playerChoice) {
    if (!chamber.contains(playerChoice)) {
      setState(() {
        message = "Position not available, choose another.";
      });
      return;
    }

    if (playerChoice == bulletPosition) {
      setState(() {
        message = "You shoot yourself. ¡Waisted!";
      });
      return;
    } else {
      setState(() {
        chamber.remove(playerChoice);
        message = "Ok. CPU is choosing...";
      });
    }

    if (chamber.length == 1) {
      setState(() {
        message = "CPU shoot theirself. ¡You win!";
      });
      return;
    }

    Future.delayed(const Duration(seconds: 2), cpuTurn);
  }

  void cpuTurn() {
    int cpuChoice = chamber[Random().nextInt(chamber.length)];

    if (cpuChoice == bulletPosition) {
      setState(() {
        message = "CPU shoot theirself. ¡You win!";
      });
      return;
    } else {
      setState(() {
        chamber.remove(cpuChoice);
        message = "CPU is safe. Your turn.";
      });
    }

    if (chamber.length == 1) {
      setState(() {
        message = "CPU shoot theirself. ¡You win!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 100),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
                image: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Russia.svg/800px-Flag_of_Russia.svg.png")),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Your election...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int? choice = int.tryParse(_controller.text);
                if (choice != null && choice >= 1 && choice <= 6) {
                  playTurn(choice);
                } else {
                  setState(() {
                    message = "Choose a valid number (1-6).";
                  });
                }
                _controller.clear();
              },
              child: const Text("Pull trigger"),
            ),
          ],
        ),
      ),
      floatingActionButton: Method.goToHome(context),
    );
  }
}
