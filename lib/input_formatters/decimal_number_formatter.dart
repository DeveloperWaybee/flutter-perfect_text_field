import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecimalNumberFormatter extends TextInputFormatter {
  final double? min;
  final double? max;
  final int decimalLength;
  final bool replaceLastIfExceeds;

  const DecimalNumberFormatter({
    this.min,
    this.max,
    this.decimalLength = 2,
    this.replaceLastIfExceeds = true,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (oldValue.text.isNotEmpty &&
        newValue.text.startsWith('0') &&
        !newValue.text.contains('.')) {
      return newValue.replaced(const TextRange(start: 0, end: 1), '');
    }

    if (!newValue.text.startsWith('.') &&
        newValue.text.contains('.') &&
        !oldValue.text.contains('.')) {
      return newValue;
    } else if (newValue.text.isEmpty) {
      return newValue;
    }

    final q = double.tryParse(newValue.text);
    if (q != null) {
      if (min != null && max != null) {
        if (!(q >= min! && q <= max!)) return oldValue;
      } else if (min != null) {
        if (!(q >= min!)) return oldValue;
      } else if (max != null) {
        if (!(q <= max!)) return oldValue;
      }

      final decimalDigital = newValue.text.split('.').last;
      if (newValue.text.contains('.') &&
          decimalDigital.length > decimalLength) {
        if (replaceLastIfExceeds) {
          final text = oldValue.text.replaceRange(oldValue.text.length - 1,
              oldValue.text.length, decimalDigital.characters.last);
          return oldValue.copyWith(text: text);
        } else {
          return oldValue;
        }
      } else {
        return newValue;
      }
    } else {
      return oldValue;
    }
  }
}
