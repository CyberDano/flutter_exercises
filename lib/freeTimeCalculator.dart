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
      int time = calculateLeisureHours();
      stimatedTime = "You have ";
      if (time > 0) {
        stimatedTime +=
            "$time hours (${(time / 24).round()} days) left of free time to enjoy :)";
      } else {
        stimatedTime += "all the time you want to enjoy :)";
      }
    });
  }

  int calculateLeisureHours() {
    int totalHoursInDay = 24;

    // Horas de ocio antes de la jubilación
    double yearsUntilRetirement = 65 - _currentAgeValue;
    double workLeisureHours = yearsUntilRetirement *
        365 *
        (totalHoursInDay - (_currentWorkValue + _currentSleepValue));

    // Horas de ocio después de la jubilación
    double retirementLeisureHours = averageAge -
        (_currentSleepValue * (_currentAgeValue / totalHoursInDay));

    return (workLeisureHours + retirementLeisureHours).round();
  }

// ignore: non_constant_identifier_names
  double Calculate() {
    double agetime = (_currentAgeValue * 365) * 24; // age
    double worktime = (24 / _currentWorkValue); // work
    double sleeptime = (24 / _currentSleepValue); // sleep
    double retirement = (65 * 365) * 24; // 65 years in hours
    if ((retirement - agetime) > 0) {
      // working
      if (agetime < retirement) {
        agetime = (retirement - agetime);
        agetime = agetime - (agetime / sleeptime) - (agetime / worktime);
        // retirement
      } else {
        agetime = (averageAge) - agetime;
        agetime = agetime - (agetime / sleeptime);
      }
    }
    return (agetime + (averageAge));
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
