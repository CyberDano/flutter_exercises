import 'package:flutter_exercises/newRoom.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:flutter_exercises/roomDetail.dart';

/* Room class */
class Room {
  String name = "";
  int number = 0;
  List<String> people = [];
  // Date (Autocomplete)
  DateTime date = DateTime.now();
  bool reserved = false;

  /* Builder */
  Room.noDate(this.name, this.number, this.people, this.reserved);
  Room.withDate(this.name, this.number, this.people, this.reserved, this.date);

  /* Own functions */
  /// Shows if the room is reserved or free
  // ignore: non_constant_identifier_names
  String ShowState(Room room) => reserved ? "Reserved." : "Free.";

  /// Formats the date
  // ignore: non_constant_identifier_names
  String RoomDateFormat(Room room) =>
      DateFormat("dd-MM-yyyy HH:mm").format(date);

  /// Shows people in room
  // ignore: non_constant_identifier_names
  String DictPeople(Room room) {
    String text = "\nOccupied by: ";
    if (room.people.isEmpty) {
      text += "[ empty ]";
    } else {
      text += room.people[0];
      for (int i = 1; i < room.people.length; i++) {
        text += ", ${room.people[i]}";
        if (i >= 4 && people.length - 1 > 5) {
          text += "...";
          if ((people.length - 5) != 0) {
            text += "+${people.length - 5}";
          }
          break;
        }
      }
    }
    if (text[text.length - 1] != "]") {
      text += ".";
    }
    return text;
  }
}

/* Class */
class RoomManager extends StatefulWidget {
  const RoomManager({super.key, required this.title});
  final String title;

  @override
  State<RoomManager> createState() => _RoomManagerScreenState();
}

/* Screen build */
class _RoomManagerScreenState extends State<RoomManager> {
  List<Room> roomList = [
    Room.noDate("Apps", 516, [], false),
    Room.noDate("DAM", 408, ["Juan", "Javier"], true),
    Room.noDate("Diseño", 311, ["Jessica"], false),
    Room.noDate("Videojuegos 1", 520, [], true)
  ];

  /// Metodo para reservar una sala
// ignore: non_constant_identifier_names
  RoomSelector(List<Room> list) {
    List<String> freeList = [];
    for (var r in list) {
      if (!r.reserved) {
        freeList.add("${r.number} - ${r.name}");
      }
    }
    print(
        "¿Que sala quieres reservar?\nDisponibles: $freeList"); // Muestra solo las salas libres
    int index = 0; // Input;
    var numindex = Exists("$index", list);
    if (numindex > -1) {
      list[numindex].reserved = true;
      int i = 0;
      List<String> peopleList = [];
      // Si la sala esta vacia
      if (list[numindex].people.isEmpty) {
        print("¿Por quien va a ser reservada?");
        while (true) {
          i += 1;
          print("Dime el nombre $i:\n(Enter para omitir)");
          String member = ""; // Input;
          if (member.isNotEmpty) {
            peopleList.add(member);
            break;
          }
        }
      }
      list[numindex].people = peopleList;
      RoomList(list);
      // Si la sala esta ocupada
    } else {
      print("Has reservado la sala, pero hay alguien en ella.");
      print("¿Quieres evacuar la sala?");
      String answer = ""; // Input;
      // Si se decide evacuar la sala
      if (answer[0].toUpperCase() == "S") {
        print("Evacuando...\n");
        list[numindex].people = []; // vacia la lista de ocupantes
        RoomList(list);
        // Reserva sin vaciar la lista de ocupantes
      } else {
        RoomList(list);
      }
    }
  }

  /// Listado de salas registradas
  // ignore: non_constant_identifier_names
  RoomList(List<Room> list) {
    print("Listado de salas registradas:");
    for (var s in list) {
      String text =
          "- ${s.number} (${s.name})\n\tEstado: ${s.ShowState(s)}${s.DictPeople(s)}";
      if (s.reserved) {
        text += "\n\t${s.RoomDateFormat(s)}";
      }
      print(text);
    }
    print("\n¿Quieres reservar una de las salas?");
    String answer = ""; // Input;
    // Si se decide evacuar la sala
    if (answer[0].toUpperCase() == "S") {
      RoomSelector(list);
    }
    print("\n¿Quieres añadir una nueva sala?");
    answer = ""; // Input;
    // Si se decide evacuar la sala
    if (answer[0].toUpperCase() == "S") {
      NewRoom(list);
    }
  }

  /// Crea una nueva sala
// ignore: non_constant_identifier_names
  NewRoom(List<Room> list) {
    int newNumber = -1;
    String newName = "";
    List<String> peopleList = [];
    // Validar el numero
    while (true) {
      print("¿Cual es el numero de la sala?");
      newNumber = Validate(0); // Input;
      for (int n = 0; n < list.length - 1; n++) {
        if (newNumber == list[n].number) {
          print("Esa sala ya existe.");
          break;
        }
      }
      if (newNumber > 0) {
        break;
      }
    }
    // Validar el nombre
    while (true) {
      print("¿Cual es el nombre de la sala?");
      newName = ""; // Input;
      if (newName.isEmpty) {
        print("Necesita un nombre.");
      } else {
        break;
      }
    }
    // Validar los ocupantes
    print("¿Quien la ocupa?");
    int i = 0;
    while (true) {
      i += 1;
      print("Dime el nombre \(i):\n(Enter para omitir)");
      String member = ""; // Input;
      if (member.isNotEmpty) {
        peopleList.add(member);
        break;
      }
    }
    Room newRoom = Room.noDate(newName, newNumber, peopleList, false);
    List<Room> newList = list;
    newList.add(newRoom);
    RoomList(newList);
  }

  /// Valida que el dato introducido por el usuario sea valido
  /// Devuelve el valor numerico
// ignore: non_constant_identifier_names
  int Validate(var input) {
    if (input.isEmpty) {
      print("Valor no introducido.");
    } else {
      if (input.contains(",") || input.contains(".")) {
        print("Solo enteros. Prueba otra vez.");
      } else {
        for (var n in input) {
          if (n.isLetter || n.isSymbol) {
            print("No acepto ni letras ni símbolos. Prueba otra vez.");
          } else {
            int num = input;
            return num;
          }
        }
      }
    }
    return -1;
  }

  /// Busca la sala especificada por numero o nombre
  /// Devuelve su posicion
// ignore: non_constant_identifier_names
  int Exists(String input, List<Room> list) {
    for (int n = 0; n < list.length - 1; n++) {
      if (input.toLowerCase() == list[n].name.toLowerCase()) {
        return n;
      } else if (int.parse(input) == list[n].number) {
        return n;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Room management'),
      ),
      body: ListView.builder(
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          final room = roomList[index];
          return ListTile(
            title: Text('${room.number} - ${room.name}'),
            subtitle: Text('${room.ShowState(room)} ${room.DictPeople(room)}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoomDetailScreen(
                            title: room.name,
                            room: room,
                          )));
            },
            onLongPress: () {
              setState(() {
                roomList.remove(room);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRoom = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewRoomScreen(
                title: 'Adding new room',
                rooms: roomList,
              ),
            ),
          );

          if (newRoom != null) {
            setState(() {
              roomList.add(newRoom);
            });
          }
        },
        tooltip: 'Add New Room',
        child: const Icon(Icons.add),
      ),
    );
  }
}
