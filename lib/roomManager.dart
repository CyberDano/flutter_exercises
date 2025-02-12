import 'package:flutter/material.dart';
import 'package:flutter_exercises/main.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10), child: Text('')),
        ],
      ),
      floatingActionButton: Method.goToHome(context),
    );
  }
}
