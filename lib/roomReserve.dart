import 'package:flutter/material.dart';
import 'package:flutter_exercises/roomManager.dart';

/* Class */
class RoomReserveScreen extends StatefulWidget {
  const RoomReserveScreen({super.key, required this.title, required this.room});
  final String title;
  final Room room;

  @override
  State<RoomReserveScreen> createState() => RoomReserveScreenState();
}

/* Screen build */
class RoomReserveScreenState extends State<RoomReserveScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime selectDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != selectDate) {
      setState(() {
        selectDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Reserving room "${widget.room.name}"'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Date ${selectDate.day}/${selectDate.month}/${selectDate.year}',
              ),
              OutlinedButton(
                  onPressed: _selectDate, child: const Text('Select Date')),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Navigator.pop(
                context,
                Room.withDate(widget.room.name, widget.room.number,
                    widget.room.people, true, selectDate));
          }
        },
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
    );
  }
}
