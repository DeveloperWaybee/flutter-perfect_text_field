import 'package:flutter/material.dart';

import 'text_controller/text_controller.dart';

export './text_controller/text_controller.dart';
export 'auto_complete/perfect_auto_complete_text_field.dart';

class PerfectTextField extends TextFormField {
  PerfectTextField({
    super.key,
    required PerfectTextController controller,
    super.autocorrect,
    super.autofillHints,
    super.autovalidateMode,
    super.autofocus,
    super.buildCounter,
    super.canRequestFocus,
    super.clipBehavior,
    super.contentInsertionConfiguration,
    super.contextMenuBuilder,
    super.cursorColor,
    super.cursorHeight,
    super.cursorOpacityAnimates,
    super.cursorRadius,
    super.cursorWidth,
    String? prefixText,
    TextStyle? prefixTextStyle,
    InputDecoration? decoration,
    String? hintText,
    super.dragStartBehavior,
    super.enableIMEPersonalizedLearning,
    super.enableInteractiveSelection,
    super.enableSuggestions,
    super.enabled,
    super.expands,
    super.initialValue,
    super.inputFormatters,
    super.keyboardAppearance,
    super.keyboardType,
    super.magnifierConfiguration,
    super.maxLength,
    super.maxLengthEnforcement,
    super.maxLines,
    super.minLines,
    super.mouseCursor,
    super.obscureText,
    super.obscuringCharacter,
    super.onAppPrivateCommand,
    super.onChanged,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    super.onTap,
    void Function(PointerDownEvent)? onTapOutside,
    bool dismissKeyboardOnTapOutside = false,
    super.readOnly,
    super.restorationId,
    super.scribbleEnabled,
    super.scrollController,
    super.scrollPadding = EdgeInsets.zero,
    super.scrollPhysics,
    super.selectionControls,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.showCursor,
    super.smartDashesType,
    super.smartQuotesType,
    super.spellCheckConfiguration,
    super.strutStyle,
    TextStyle? style,
    super.textAlign,
    super.textAlignVertical,
    super.textCapitalization,
    super.textDirection,
    super.textInputAction,
    super.toolbarOptions,
    super.undoController,
    super.validator,
  }) : super(
            controller: controller.textController,
            focusNode: controller.focusNode,
            style: style ??
                const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
            decoration: decoration?.copyWith(
                  prefixIcon: prefixText != null
                      ? IntrinsicWidth(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                prefixText,
                                style: prefixTextStyle,
                              ),
                            ),
                          ),
                        )
                      : null,
                  hintText: hintText,
                ) ??
                InputDecoration(
                  prefixIcon: prefixText != null
                      ? IntrinsicWidth(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                prefixText,
                                style: prefixTextStyle,
                              ),
                            ),
                          ),
                        )
                      : null,
                  hintText: hintText,
                ),
            onTapOutside: (v) {
              if (dismissKeyboardOnTapOutside) {
                controller.unfocus();
              }
              onTapOutside?.call(v);
            });
}
