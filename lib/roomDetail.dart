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
            if (widget.room.people.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Occupied by:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.room.people.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.room.people[index]),
                    );
                  },
                ),
              ),
            ] else
              const Text('The room is empty.', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
