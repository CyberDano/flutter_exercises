import 'package:flutter/material.dart';
import 'package:flutter_exercises/roomManager.dart';
import 'package:provider/provider.dart';

/* Class */
class NewRoomScreen extends StatefulWidget {
  const NewRoomScreen({super.key, required this.title, required this.rooms});
  final String title;
  final List<Room> rooms;

  @override
  State<NewRoomScreen> createState() => _NewRoomScreenState();
}

/* Screen build */
class _NewRoomScreenState extends State<NewRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _number = 0;
  // ignore: prefer_final_fields
  List<String> _people = [];
  bool reserved = false;

  /// Busca la sala especificada por numero o nombre
  /// Devuelve su posicion
// ignore: non_constant_identifier_names
  bool Exists(int input, List<Room> list) {
    for (Room room in list) {
      if (input == room.number) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add New Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("* Compulsory value."),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Room Name*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Room Number*'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  if (Exists(int.parse(value), widget.rooms)) {
                    return 'This number already exists';
                  }
                  return null;
                },
                onSaved: (value) {
                  _number = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Add people (separate with ,)'),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _people.clear();
                      _people.addAll(value.split(","));
                    });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Is reserved?", style: TextStyle(fontSize: 18)),
                  Switch(
                    // This bool value toggles the switch.
                    value: reserved,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        reserved = value;
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _people.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_people[index]),
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final rooms =
                        Provider.of<RoomListClass>(context, listen: false);
                    rooms.addRoom(Room.withDate(
                        _name, _number, _people, reserved, DateTime.now()));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Room',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
