import 'package:flutter/material.dart';

@protected
class PerfectTextController {
  final TextEditingController textController;
  final FocusNode focusNode;
  final void Function(String value)? onTextChange;
  final void Function(bool value)? onFocusChange;

  void selectAll() {
    if (text.isNotEmpty) {
      textController.selection =
          TextSelection(baseOffset: 0, extentOffset: text.length);
    }
  }

  void requestFocus([FocusNode? node]) {
    focusNode.requestFocus(node);
  }

  void requestFocusWithSelectAll([FocusNode? node]) {
    selectAll();
    focusNode.requestFocus(node);
  }

  bool get hasFocus => focusNode.hasPrimaryFocus;

  String get text => textController.text;
  set text(String value) => textController.text = value;

  PerfectTextController({
    TextEditingController? textEditingController,
    FocusNode? focusNode,
    bool selectAllOnFocus = true,
    bool readyOnly = false,
    this.onTextChange,
    this.onFocusChange,
  })  : textController = textEditingController ?? TextEditingController(),
        focusNode = focusNode ??
            (readyOnly
                ? FocusNode(
                    skipTraversal: true,
                    canRequestFocus: false,
                    descendantsAreFocusable: false,
                    descendantsAreTraversable: false,
                  )
                : FocusNode()) {
    if (onTextChange != null) {
      textController.addListener(() => onTextChange?.call(text));
    }
    if (selectAllOnFocus) {
      this.focusNode.addListener(() {
        onFocusChange?.call(this.focusNode.hasPrimaryFocus);
        if (this.focusNode.hasPrimaryFocus) {
          selectAll();
        }
      });
    }
  }
}
