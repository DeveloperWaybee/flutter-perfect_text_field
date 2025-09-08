import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;
export 'package:flutter/services.dart' show SmartDashesType, SmartQuotesType;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_controller/text_controller.dart';

export './text_controller/text_controller.dart';
export 'auto_complete/perfect_auto_complete_text_field.dart';

class PerfectTextField extends StatefulWidget {
  /// The [PerfectTextController] to be used with this widget.
  /// If not provided, a new [PerfectTextController] will be created.
  /// This is useful for managing the state of the text field.
  final PerfectTextController? controller;
  final FocusNode? focusNode;
  final bool autocorrect;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final bool autofocus;
  final InputCounterWidgetBuilder? buildCounter;
  final bool canRequestFocus;
  final Clip clipBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final Color? cursorColor;
  final double? cursorHeight;
  final bool? cursorOpacityAnimates;
  final Radius? cursorRadius;
  final double cursorWidth;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final InputDecoration? decoration;
  final String? hintText;
  final DragStartBehavior dragStartBehavior;
  final bool enableIMEPersonalizedLearning;
  final bool? enableInteractiveSelection;
  final bool enableSuggestions;
  final bool? enabled;
  final bool expands;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Brightness? keyboardAppearance;
  final TextInputType? keyboardType;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final MouseCursor? mouseCursor;
  final bool obscureText;
  final String obscuringCharacter;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final bool dismissKeyboardOnTapOutside;
  final bool readOnly;
  final String? restorationId;
  final bool scribbleEnabled;
  final ScrollController? scrollController;
  final EdgeInsets scrollPadding;
  final ScrollPhysics? scrollPhysics;
  final TextSelectionControls? selectionControls;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final bool? showCursor;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final StrutStyle? strutStyle;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextCapitalization textCapitalization;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final UndoHistoryController? undoController;
  final String? Function(String?)? validator;

  const PerfectTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.autocorrect = true,
    this.autofillHints,
    this.autovalidateMode,
    this.autofocus = false,
    this.buildCounter,
    this.canRequestFocus = true,
    this.clipBehavior = Clip.hardEdge,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.cursorColor,
    this.cursorHeight,
    this.cursorOpacityAnimates,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    this.prefixText,
    this.prefixTextStyle,
    this.decoration,
    this.hintText,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.enabled,
    this.expands = false,
    this.initialValue,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType,
    this.magnifierConfiguration,
    this.maxLength,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.mouseCursor,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.onAppPrivateCommand,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.onTapOutside,
    this.dismissKeyboardOnTapOutside = false,
    this.readOnly = false,
    this.restorationId,
    this.scribbleEnabled = true,
    this.scrollController,
    this.scrollPadding = EdgeInsets.zero,
    this.scrollPhysics,
    this.selectionControls,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.spellCheckConfiguration,
    this.strutStyle,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.undoController,
    this.validator,
  });

  @override
  State<PerfectTextField> createState() => _PerfectTextFieldState();
}

class _PerfectTextFieldState extends State<PerfectTextField> {
  /// The [PerfectTextController] to be used with this widget.
  /// If not provided, a new [PerfectTextController] will be created.
  /// This is useful for managing the state of the text field.
  late PerfectTextController controller =
      widget.controller ?? PerfectTextController();

  FocusNode? get focusNode => widget.focusNode;
  bool get autocorrect => widget.autocorrect;
  Iterable<String>? get autofillHints => widget.autofillHints;
  AutovalidateMode? get autovalidateMode => widget.autovalidateMode;
  bool get autofocus => widget.autofocus;
  InputCounterWidgetBuilder? get buildCounter => widget.buildCounter;
  bool get canRequestFocus => widget.canRequestFocus;
  Clip get clipBehavior => widget.clipBehavior;
  ContentInsertionConfiguration? get contentInsertionConfiguration =>
      widget.contentInsertionConfiguration;
  EditableTextContextMenuBuilder? get contextMenuBuilder =>
      widget.contextMenuBuilder;
  Color? get cursorColor => widget.cursorColor;
  double? get cursorHeight => widget.cursorHeight;
  bool? get cursorOpacityAnimates => widget.cursorOpacityAnimates;
  Radius? get cursorRadius => widget.cursorRadius;
  double get cursorWidth => widget.cursorWidth;
  String? get prefixText => widget.prefixText;
  TextStyle? get prefixTextStyle => widget.prefixTextStyle;
  InputDecoration? get decoration => widget.decoration;
  String? get hintText => widget.hintText;
  DragStartBehavior get dragStartBehavior => widget.dragStartBehavior;
  bool get enableIMEPersonalizedLearning =>
      widget.enableIMEPersonalizedLearning;
  bool? get enableInteractiveSelection => widget.enableInteractiveSelection;
  bool get enableSuggestions => widget.enableSuggestions;
  bool? get enabled => widget.enabled;
  bool get expands => widget.expands;
  String? get initialValue => widget.initialValue;
  List<TextInputFormatter>? get inputFormatters => widget.inputFormatters;
  Brightness? get keyboardAppearance => widget.keyboardAppearance;
  TextInputType? get keyboardType => widget.keyboardType;
  TextMagnifierConfiguration? get magnifierConfiguration =>
      widget.magnifierConfiguration;
  int? get maxLength => widget.maxLength;
  MaxLengthEnforcement? get maxLengthEnforcement => widget.maxLengthEnforcement;
  int? get maxLines => widget.maxLines;
  int? get minLines => widget.minLines;
  MouseCursor? get mouseCursor => widget.mouseCursor;
  bool get obscureText => widget.obscureText;
  String get obscuringCharacter => widget.obscuringCharacter;
  AppPrivateCommandCallback? get onAppPrivateCommand =>
      widget.onAppPrivateCommand;
  ValueChanged<String>? get onChanged => widget.onChanged;
  VoidCallback? get onEditingComplete => widget.onEditingComplete;
  ValueChanged<String>? get onFieldSubmitted => widget.onFieldSubmitted;
  void Function(String?)? get onSaved => widget.onSaved;
  GestureTapCallback? get onTap => widget.onTap;
  TapRegionCallback? get onTapOutside => widget.onTapOutside;
  bool get dismissKeyboardOnTapOutside => widget.dismissKeyboardOnTapOutside;
  bool get readOnly => widget.readOnly;
  String? get restorationId => widget.restorationId;
  bool get scribbleEnabled => widget.scribbleEnabled;
  ScrollController? get scrollController => widget.scrollController;
  EdgeInsets get scrollPadding => widget.scrollPadding;
  ScrollPhysics? get scrollPhysics => widget.scrollPhysics;
  TextSelectionControls? get selectionControls => widget.selectionControls;
  ui.BoxHeightStyle get selectionHeightStyle => widget.selectionHeightStyle;
  ui.BoxWidthStyle get selectionWidthStyle => widget.selectionWidthStyle;
  bool? get showCursor => widget.showCursor;
  SmartDashesType? get smartDashesType => widget.smartDashesType;
  SmartQuotesType? get smartQuotesType => widget.smartQuotesType;
  SpellCheckConfiguration? get spellCheckConfiguration =>
      widget.spellCheckConfiguration;
  StrutStyle? get strutStyle => widget.strutStyle;
  TextStyle? get style => widget.style;
  TextAlign get textAlign => widget.textAlign;
  TextAlignVertical? get textAlignVertical => widget.textAlignVertical;
  TextCapitalization get textCapitalization => widget.textCapitalization;
  TextDirection? get textDirection => widget.textDirection;
  TextInputAction? get textInputAction => widget.textInputAction;
  UndoHistoryController? get undoController => widget.undoController;
  String? Function(String?)? get validator => widget.validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode ?? controller.focusNode,
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      autofocus: autofocus,
      buildCounter: buildCounter,
      canRequestFocus: canRequestFocus,
      clipBehavior: clipBehavior,
      contentInsertionConfiguration: contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      cursorOpacityAnimates: cursorOpacityAnimates,
      cursorRadius: cursorRadius,
      cursorWidth: cursorWidth,
      decoration: decoration?.copyWith(
            prefixIcon: prefixText != null
                ? IntrinsicWidth(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          prefixText ?? '',
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          prefixText ?? '',
                          style: prefixTextStyle,
                        ),
                      ),
                    ),
                  )
                : null,
            hintText: hintText,
          ),
      dragStartBehavior: dragStartBehavior,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      enableInteractiveSelection: enableInteractiveSelection,
      enableSuggestions: enableSuggestions,
      enabled: enabled,
      expands: expands,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardAppearance: keyboardAppearance,
      keyboardType: keyboardType,
      magnifierConfiguration: magnifierConfiguration,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      mouseCursor: mouseCursor,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      onAppPrivateCommand: onAppPrivateCommand,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      onTapOutside: (v) {
        if (dismissKeyboardOnTapOutside) {
          controller.unfocus();
        }
        onTapOutside?.call(v);
      },
      readOnly: readOnly,
      restorationId: restorationId,
      scrollController: scrollController,
      scrollPadding: scrollPadding,
      scrollPhysics: scrollPhysics,
      selectionControls: selectionControls,
      selectionHeightStyle: selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle,
      showCursor: showCursor,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      spellCheckConfiguration: spellCheckConfiguration,
      strutStyle: strutStyle,
      style: widget.style ??
          const TextStyle(
            fontWeight: FontWeight.w500,
          ),
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textCapitalization: textCapitalization,
      textDirection: textDirection,
      textInputAction: textInputAction,
      undoController: undoController,
      validator: validator,
    );
  }
}
