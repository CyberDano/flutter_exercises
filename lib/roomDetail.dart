import 'package:flutter/material.dart';
import 'package:flutter_exercises/roomManager.dart';

/* Class */
class RoomDetailScreen extends StatefulWidget {
  const RoomDetailScreen({super.key, required this.title, required this.room});
  final String title;
  final Room room;

  @override
  State<RoomDetailScreen> createState() => RoomDetailScreenState();
}

/* Screen build */
class RoomDetailScreenState extends State<RoomDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Room Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.room.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Number: ${widget.room.number}',
                style: const TextStyle(fontSize: 18)),
            Text('State: ${widget.room.ShowState(widget.room)}',
                style: const TextStyle(fontSize: 18)),
            Text('Date: ${widget.room.RoomDateFormat(widget.room)}',
                style: const TextStyle(fontSize: 18)),
            Text(widget.room.DictPeople(widget.room),
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
