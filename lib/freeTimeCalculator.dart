import 'package:flutter/material.dart';
import 'package:flutter_exercises/main.dart';

/* Class */
class FreeTimeCalc extends StatefulWidget {
  const FreeTimeCalc({super.key, required this.title});
  final String title;

  @override
  State<FreeTimeCalc> createState() => _FreeTimeCalcScreenState();
}

/* Screen build */
class _FreeTimeCalcScreenState extends State<FreeTimeCalc> {
  double _currentAgeValue = 20;
  double _currentSleepValue = 8;
  double _currentWorkValue = 8;
  int averageAge = 150672; // average livespan after 65 years old
  String stimatedTime = "";

  // ignore: non_constant_identifier_names
  void StimatedHours() {
    setState(() {
      stimatedTime = "";
      int time = Calculate();
      stimatedTime = "You have ";
      if (time > 0) {
        stimatedTime +=
            "$time hours (${(time / 24).round()} days) left of free time to enjoy :)";
      } else {
        stimatedTime += "all the time you want to enjoy :)";
      }
    });
  }

  // ignore: non_constant_identifier_names
  int Calculate() {
    if (_currentWorkValue + _currentSleepValue > 24) return -1;

    // Horas de ocio antes de la jubilación
    double yearsUntilRetirement = 65 - _currentAgeValue;
    double workLeisureHours = (yearsUntilRetirement > 0)
        ? yearsUntilRetirement *
            365 *
            (24 - (_currentWorkValue + _currentSleepValue))
        : 0;

    // Horas de ocio después de la jubilación
    double retirementLeisureHours = (yearsUntilRetirement > 0)
        ? averageAge - (_currentSleepValue * (averageAge / 24))
        : 0;

    return (workLeisureHours + retirementLeisureHours).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.all(10), child: Text('Your age (range)')),
              Slider(
                value: _currentAgeValue,
                max: 100,
                divisions: 10,
                label: _currentAgeValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentAgeValue = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Work hours per day')),
              Slider(
                value: _currentWorkValue,
                max: 24,
                divisions: 24,
                label: _currentWorkValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentWorkValue = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Sleep hours per day')),
              Slider(
                value: _currentSleepValue,
                max: 24,
                divisions: 24,
                label: _currentSleepValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSleepValue = value;
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                if ((_currentWorkValue + _currentSleepValue) > 24) {
                  setState(() {
                    stimatedTime =
                        "Wrong data. Sleep + work can't be higher than 24 hours.";
                  });
                } else if ((_currentWorkValue + _currentSleepValue) != 0) {
                  StimatedHours();
                }
              },
              child: const Text("Calculate")),
          Text(stimatedTime),
        ],
      ),
      floatingActionButton: Method.goToHome(context),
    );
  }
}
