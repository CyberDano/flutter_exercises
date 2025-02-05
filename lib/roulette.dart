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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10), child: Text('Рулетка')),
        ],
      ),
      floatingActionButton: Method.goToHome(context),
    );
  }
}
/*
     print("Vamos a jugar a la ruleta rusa.");
    List<int> colt = [];
    for (int i = 1; i <7; i++){
        colt.add(i);
    }
    while (colt.length >= 1) {
        int playerInt = 0;
        // Turno jugador
        while (playerInt == 0) {
            print("Selecciona una posición del tambor.");
            print("Números disponibles: ${colt.length}");
            int player_number = TextField(
                  keyboardType: TextInputType.number,
                  controller: _averageController,
                  decoration: const InputDecoration(
                      labelText: "Your number...",
                      border: OutlineInputBorder()),
                  // Only numbers allowed
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                );
            if Correct(number: player_number) {
                if Int(player_number)! > colt.count {
                    print("Posición del tambor no disponible.");
                } else {
                    playerInt = Int(player_number)!
                }
            }
        }
        // Turno CPU
        let bullet = Int.random(in: 1...colt.count) // posición de la bala
        let cpu = Int.random(in: 1...colt.count) // Jugador 2
        /* Condicionales jugador */
        print("Has decidido usar el hueco", playerInt);
        if playerInt == bullet {
            print("-Resultado: te has disparado.");
            print("El jugador 2 ha salido vivo.");
            break;
        }
        else {
            print("-Resultado: espacio vacío.")
            colt.remove(at: colt.count-1)
        }
        if colt.count == 1 {
            print("Has salido vivo.")
            break
        }
        /* Condicionales CPU */
        print("El jugador 2 ha usado el hueco", cpu)
        if cpu == bullet {
            print("-Resultado: le han disparado.")
            print("Has salido vivo.")
            break
        }
        else {
            print("-Resultado: espacio vacío.")
            colt.remove(at: colt.count-1)
        }
    }
  }*/