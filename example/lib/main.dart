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
  final decimalFormatterTextController = PerfectTextController();
  final chipTextController = PerfectTextController(
    decorations: {
      DecorationType.hashtag: DecorationStyle(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: TextStyle(color: Colors.blue),
        onTap: (t) => print('Hashtag tapped: $t'),
      ),
      DecorationType.mention: DecorationStyle(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: TextStyle(color: Colors.green),
        onTap: (t) => print('Mention tapped: $t'),
      ),
      DecorationType.email: DecorationStyle(
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: TextStyle(color: Colors.orange),
        onTap: (t) => print('Email tapped: $t'),
      ),
      DecorationType.phone: DecorationStyle(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: TextStyle(color: Colors.red),
        onTap: (t) => print('Phone tapped: $t'),
      ),
    },
  );

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
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              title: const Text('Decimal Number Formatter'),
              subtitle: PerfectTextField(
                controller: decimalFormatterTextController,
                dismissKeyboardOnTapOutside: true,
                inputFormatters: const [
                  DecimalNumberFormatter(
                    min: 0,
                    max: 100.0,
                    decimalLength: 2,
                  )
                ],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            ListTile(
              title: const Text('Chip Text Field'),
              subtitle: PerfectTextField(
                controller: chipTextController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
