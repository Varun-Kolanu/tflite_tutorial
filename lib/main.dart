import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tflite tutorial',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double result = 0.0;

  runModel(double no) async {
    final interpreter =
        await tfl.Interpreter.fromAsset('assets/number_predictor.tflite');
    final input = [
      [no]
    ];
    var output = List.filled(1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    result = output[0][0];
    print(output);
    setState(() {
      result = output[0][0];
    });
    // return  as double;
  }

  TextEditingController noController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tflite sample",
        ),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: noController,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: MaterialButton(
              child: const Text(
                "Run",
              ),
              onPressed: () {
                runModel(double.parse(noController.text));
              },
            ),
          ),
          Text(
            result.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
