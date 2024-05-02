import 'package:flutter/material.dart';
import 'package:get/get.dart';

@protected
class PerfectTextController {
  static final _focused = Rxn<PerfectTextController>();
  static PerfectTextController? get focused => _focused.value;
  static set focused(PerfectTextController? v) => _focused.value = v;

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

  void unfocus() {
    focusNode.unfocus();
  }

  void requestFocus([FocusNode? node]) {
    focusNode.requestFocus(node);
  }

  void requestFocusWithSelectAll([FocusNode? node]) {
    selectAll();
    focusNode.requestFocus(node);
  }

  bool get hasFocus => focusNode.hasPrimaryFocus;

  final rxText = RxString('');
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
    textController.addListener(() {
      if (rxText.value != textController.text) {
        rxText.value = textController.text;
      }
      if (onTextChange != null) {
        onTextChange?.call(text);
      }
    });

    this.focusNode.addListener(() {
      PerfectTextController.focused =
          this.focusNode.hasPrimaryFocus ? this : null;

      if (selectAllOnFocus) {
        onFocusChange?.call(this.focusNode.hasPrimaryFocus);
        if (this.focusNode.hasPrimaryFocus) {
          selectAll();
        }
      }
    });
  }

  void dispose() {
    textController.dispose();
    focusNode.dispose();
  }
}
