import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exercises/main.dart';

/* Class */
class RomainTranslate extends StatefulWidget {
  const RomainTranslate({super.key, required this.title});
  final String title;

  @override
  State<RomainTranslate> createState() => _RomainTranslateScreenState();
}

/* Screen build */
class _RomainTranslateScreenState extends State<RomainTranslate> {
  // ignore: prefer_final_fields
  late TextEditingController _romanTranslator = TextEditingController();
  final Map<String, int> romanNumerals = {
    "I": 1,
    "V": 5,
    "X": 10,
    "L": 50,
    "C": 100,
    "D": 500,
    "M": 1000
  };
  String result = "";

  /// Calculate number
  int romanToDecimal(String roman) {
    int decimal = 0;
    int prevValue = 0;

    for (int i = roman.length - 1; i >= 0; i--) {
      String char = roman[i];
      if (romanNumerals.containsKey(char)) {
        int value = romanNumerals[char]!;
        if (value < prevValue) {
          decimal -= value;
        } else {
          decimal += value;
        }
        prevValue = value;
      } else {
        return -1; // Non valid letter
      }
    }
    return decimal;
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
          const Text('Roman translate'),
          SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _romanTranslator,
                decoration: const InputDecoration(
                  labelText: "Enter roman number... [ I, V, X, L, C, D, M ]",
                  border: OutlineInputBorder(),
                ), // Only letters allowed
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                int decimalValue =
                    romanToDecimal(_romanTranslator.text.toUpperCase());
                if (_romanTranslator.text.isNotEmpty) {
                  if (decimalValue == -1) {
                    result = 'Invalid key';
                  } else {
                    result =
                        "${_romanTranslator.text.toUpperCase()}:$decimalValue";
                  }
                }
              });
            },
            child: const Text('Translate'),
          ),
          Text(result),
        ],
      ),
      floatingActionButton: Method.goToHome(context),
    );
  }
}
