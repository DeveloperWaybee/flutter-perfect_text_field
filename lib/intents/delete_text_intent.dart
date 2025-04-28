import 'package:flutter/material.dart';

import '../perfect_text_field.dart';

class DeletePreviousCharIntent extends VoidCallbackIntent {
  DeletePreviousCharIntent(PerfectTextController textController)
      : super(() {
          final sfc = textController;
          final value = sfc.value;
          if (value.text.isEmpty) return;
          final range = TextRange(
            start: value.text.length - 1,
            end: value.text.length,
          );
          textController.value = value.replaced(range, '');
        });
}
