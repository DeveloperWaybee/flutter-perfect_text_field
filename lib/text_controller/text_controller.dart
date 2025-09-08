import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@protected
enum DecorationType { hashtag, mention, email, phone, custom }

@protected
class DecorationStyle {
  final DecorationType type;
  final List<DecorationMatch> Function(String text)? getMatches;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final ValueChanged<String>? onTap;
  final bool deleteOnTap;

  const DecorationStyle({
    required this.type,
    this.getMatches,
    this.backgroundColor = Colors.transparent,
    this.textStyle,
    this.onTap,
    this.deleteOnTap = true,
  });
}

/// Internal match model to keep track of token ranges.
class DecorationMatch {
  final int start, end;
  DecorationMatch(this.start, this.end);
}

@protected
class PerfectTextController extends TextEditingController {
  static PerfectTextController? focused;

  final FocusNode focusNode;
  void Function(String value)? onTextChange;
  void Function(bool value)? onFocusChange;

  // Separate regex for each decoration type except phone.
  static final RegExp _hashtagRegex = RegExp(r'\#[\w]+');
  static final RegExp _mentionRegex = RegExp(r'\@[\w]+');
  static final RegExp _emailRegex =
      RegExp(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}');

  final List<DecorationStyle> decorations;

  void selectAll() {
    if (text.isNotEmpty) {
      selection = TextSelection(
        baseOffset: 0,
        extentOffset: text.length,
      );
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

  final rxText = ValueNotifier<String>('');

  PerfectTextController({
    FocusNode? focusNode,
    bool selectAllOnFocus = false,
    bool readyOnly = false,
    this.onTextChange,
    this.onFocusChange,
    this.decorations = const [],
  }) : focusNode = focusNode ??
            (readyOnly
                ? FocusNode(
                    skipTraversal: true,
                    canRequestFocus: false,
                    descendantsAreFocusable: false,
                    descendantsAreTraversable: false,
                  )
                : FocusNode()) {
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

  PerfectTextController copyWith({
    FocusNode? focusNode,
    bool selectAllOnFocus = false,
    bool readyOnly = false,
    void Function(String value)? onTextChange,
    void Function(bool value)? onFocusChange,
  }) {
    return PerfectTextController(
      focusNode: focusNode ?? this.focusNode,
      selectAllOnFocus: selectAllOnFocus,
      readyOnly: readyOnly,
      onTextChange: onTextChange ?? this.onTextChange,
      onFocusChange: onFocusChange ?? this.onFocusChange,
    );
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    if (decorations.isEmpty) {
      return super.buildTextSpan(
        context: context,
        style: style,
        withComposing: withComposing,
      );
    }

    final defaultStyle = style ?? DefaultTextStyle.of(context).style;
    final textValue = text;

    if (rxText.value != textValue) {
      rxText.value = textValue;
      if (onTextChange != null) {
        onTextChange?.call(textValue);
      }
    }

    final spans = _buildSpans(textValue, defaultStyle);
    return TextSpan(style: defaultStyle, children: spans);
  }

  /// Matches a regex and filters by delimiter.
  List<DecorationMatch> _matchRegex(
    RegExp regex,
    String textValue,
    DecorationType type,
  ) {
    final result = <DecorationMatch>[];
    for (final m in regex.allMatches(textValue)) {
      if (_hasDelimiter(textValue, m.end)) {
        result.add(DecorationMatch(m.start, m.end));
      }
    }
    return result;
  }

  /// Uses dlibphonenumber to find phone numbers and filter by delimiter.
  List<DecorationMatch> _matchPhoneMatches(String textValue) {
    final result = <DecorationMatch>[];
    final phoneUtil = PhoneNumberUtil.instance;
    final phoneMatches = phoneUtil.findNumbers(textValue, '');
    for (final pm in phoneMatches) {
      final raw = pm.rawString;
      final escaped = RegExp.escape(raw);
      for (final m in RegExp(escaped).allMatches(textValue)) {
        if (_hasDelimiter(textValue, m.end)) {
          result.add(DecorationMatch(m.start, m.end));
        }
      }
    }
    return result;
  }

  /// Checks if the character immediately after the token is a non-word character (punctuation, space, etc.) or end of text.
  bool _hasDelimiter(String textValue, int end) {
    if (end >= textValue.length) return true;
    // \W matches any non-word character (anything other than letters, digits, or underscore)
    return RegExp(r'\W').hasMatch(textValue[end]);
  }

  /// Builds InlineSpans from matches and plain text.
  List<InlineSpan> _buildSpans(
    String textValue,
    TextStyle defaultStyle,
  ) {
    final spans = <InlineSpan>[];
    int last = 0;
    List<(DecorationStyle, DecorationMatch)> matches = [];

    for (var decoration in decorations) {
      final tempMatches = () {
        if (decoration.getMatches != null) {
          final temp = decoration.getMatches!(textValue);
          temp.sort((a, b) => a.start.compareTo(b.start));
          return temp;
        } else {
          switch (decoration.type) {
            case DecorationType.hashtag:
              return _matchRegex(_hashtagRegex, textValue, decoration.type);
            case DecorationType.mention:
              return _matchRegex(_mentionRegex, textValue, decoration.type);
            case DecorationType.email:
              return _matchRegex(_emailRegex, textValue, decoration.type);
            case DecorationType.phone:
              return _matchPhoneMatches(textValue);
            case DecorationType.custom:
              return <DecorationMatch>[];
          }
        }
      }();

      matches.addAll(List.generate(
        tempMatches.length,
        (index) => (decoration, tempMatches[index]),
      ));
    }

    // 👉 FIX: Sort all matches globally by start
    matches.sort((a, b) => a.$2.start.compareTo(b.$2.start));

    for (final dm in matches) {
      if (dm.$2.start < last) continue;
      if (dm.$2.start > last) {
        spans.add(TextSpan(
          text: textValue.substring(last, dm.$2.start),
          style: defaultStyle,
        ));
        // continue;
      }
      spans.add(_buildDecorationSpan(
        dm.$1,
        dm.$2,
        textValue,
        defaultStyle,
      ));
      last = dm.$2.end;
    }
    if (last < textValue.length) {
      spans.add(TextSpan(
        text: textValue.substring(last),
        style: defaultStyle,
      ));
    }
    return spans;
  }

  /// Builds a WidgetSpan for a matched token.
  InlineSpan _buildDecorationSpan(
    DecorationStyle ds,
    DecorationMatch dm,
    String textValue,
    TextStyle defaultStyle,
  ) {
    final token = textValue.substring(dm.start, dm.end);
    final cfg = ds;
    return TextSpan(
      text: token,
      style: (cfg.textStyle ?? defaultStyle).copyWith(
        background: Paint()
          ..color = cfg.backgroundColor
          ..style = PaintingStyle.fill,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          if (cfg.deleteOnTap) {
            final newText = textValue.replaceRange(dm.start, dm.end, '');
            text = newText;
            selection = TextSelection.collapsed(offset: dm.start);
          }
          cfg.onTap?.call(token);
        },
    );
  }

  @override
  set text(String value) {
    if (value != text) {
      super.text = value;
      rxText.value = value;
      if (onTextChange != null) {
        onTextChange?.call(value);
      }
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
