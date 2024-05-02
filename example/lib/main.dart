import 'package:flutter/material.dart';
import 'package:perfect_text_field/input_formatters/decimal_number_formatter.dart';
import 'package:perfect_text_field/perfect_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textController = PerfectTextController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perfect Text Field'),
        ),
        body: Center(
          child: SizedBox(
            width: 250,
            child: PerfectTextField(
              controller: textController,
              inputFormatters: const [
                DecimalNumberFormatter(
                  min: 1.0,
                  max: 100.0,
                  decimalLength: 2,
                )
              ],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
