import 'package:flutter/material.dart';

import 'text_controller/text_controller.dart';

class PerfectTextField extends TextFormField {
  PerfectTextField(PerfectTextController textController,{
    super.key,
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
    /// This will override the prefixIcon attribute in the Input Decoration.
    String? prefixText,
    InputDecoration? decoration,
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
    super.onTapOutside,
    super.readOnly,
    super.restorationId,
    super.scribbleEnabled,
    super.scrollController,
    super.scrollPadding,
    super.scrollPhysics,
    super.selectionControls,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.showCursor,
    super.smartDashesType,
    super.smartQuotesType,
    super.spellCheckConfiguration,
    super.strutStyle,
    super.style,
    super.textAlign,
    super.textAlignVertical,
    super.textCapitalization,
    super.textDirection,
    super.textInputAction,
    super.toolbarOptions,
    super.undoController,
    super.validator,
  }) : super(
          controller: textController.textController,
          focusNode: textController.focusNode,
          decoration: decoration?.copyWith(
                prefixIcon: prefixText != null ? IntrinsicHeight(
                  child: IntrinsicWidth(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(prefixText),
                    ),
                  ),
                ) : null,
              ) ??
              (prefixText != null ? InputDecoration(
                prefixIcon: IntrinsicHeight(
                  child: IntrinsicWidth(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(prefixText),
                    ),
                  ),
                ),
              ) : null),
        );
}
