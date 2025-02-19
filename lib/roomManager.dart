import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:flutter_exercises/roomDetail.dart';
import 'package:flutter_exercises/newRoom.dart';

/* Room class */
class Room {
  String name;
  int number;
  List<String> people;
  DateTime date;
  bool reserved;

  /* Builders */
  Room.noDate(this.name, this.number, this.people, this.reserved)
      : date = DateTime.now();
  Room.withDate(this.name, this.number, this.people, this.reserved, this.date);

  /* Own functions */
  /// Maps the data of Room class
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'people': people,
      'date': date.toIso8601String(),
      'reserved': reserved,
    };
  }

  /// Instantiate the json of Room class
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room.withDate(
      json['name'],
      json['number'],
      List<String>.from(json['people']),
      json['reserved'],
      DateTime.parse(json['date']),
    );
  }

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

/* Room list provider */
class RoomListClass with ChangeNotifier {
  List<Room> roomList = [];

  /// Adds character to list
  void addRoom(Room r) {
    roomList.add(r);
    saveList();
  }

  /// Removes character from list
  void removeRoom(Room r) {
    roomList.remove(r);
    saveList();
  }

  /// Saves the list of rooms
  // ignore: unused_element
  void saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        roomList.map((c) => json.encode(c.toJson())).toList();
    prefs.setStringList('Rooms', jsonList);
    notifyListeners();
  }

  /// Loads the saved list of rooms
  // ignore: unused_element
  void loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('Rooms');
    if (jsonList != null) {
      roomList =
          jsonList.map((item) => Room.fromJson(json.decode(item))).toList();
      notifyListeners();
    } else {
      roomList.addAll([
        Room.noDate("Apps", 516, [], false),
        Room.noDate("DAM", 408, ["Juan", "Javier"], true),
        Room.noDate("Diseño", 311, ["Jessica"], false),
        Room.noDate("Videojuegos 1", 520, [], true)
      ]);
      notifyListeners();
    }
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
  @override
  void initState() {
    super.initState();
    // Cargar la lista de habitaciones favoritas
    final rooms = Provider.of<RoomListClass>(context, listen: false);
    rooms.loadList();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = Provider.of<RoomListClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Room management'),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Long press to remove a room"),
              Icon(Icons.delete),
            ],
          ),
          SizedBox(
            height: 500,
            width: 500,
            child: ListOfRooms(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRoom = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewRoomScreen(
                title: 'Adding new room',
                rooms: rooms.roomList,
              ),
            ),
          );

          if (newRoom != null) {
            setState(() {
              rooms.addRoom(newRoom);
            });
          }
        },
        tooltip: 'Add New Room',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// List of rooms in provider
  // ignore: non_constant_identifier_names
  ListView ListOfRooms() {
    final rooms = Provider.of<RoomListClass>(context);
    return ListView.builder(
      itemCount: rooms.roomList.length,
      itemBuilder: (context, index) {
        final room = rooms.roomList[index];
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
                  index: index,
                ),
              ),
            );
          },
          onLongPress: () {
            setState(() {
              rooms.removeRoom(room);
            });
          },
        );
      },
    );
  }
}
