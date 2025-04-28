import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';

@protected
enum DecorationType { hashtag, mention, email, phone }

@protected
class DecorationStyle {
  final Decoration? decoration;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle? textStyle;
  final ValueChanged<String>? onTap;
  final bool deleteOnTap;

  const DecorationStyle({
    this.decoration,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    this.margin = const EdgeInsets.symmetric(horizontal: 2),
    this.textStyle,
    this.onTap,
    this.deleteOnTap = true,
  });
}

/// Internal match model to keep track of token ranges.
class _DecorationMatch {
  final int start, end;
  final DecorationType type;
  _DecorationMatch(this.start, this.end, this.type);
}

@protected
class PerfectTextController extends TextEditingController {
  static PerfectTextController? focused;

  final FocusNode focusNode;
  final void Function(String value)? onTextChange;
  final void Function(bool value)? onFocusChange;

  // Separate regex for each decoration type except phone.
  static final RegExp _hashtagRegex = RegExp(r'\#[\w]+');
  static final RegExp _mentionRegex = RegExp(r'\@[\w]+');
  static final RegExp _emailRegex =
      RegExp(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}');

  final Map<DecorationType, DecorationStyle> decorations;

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
    this.decorations = const {},
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
    final defaultStyle = style ?? DefaultTextStyle.of(context).style;
    final textValue = text;

    final matches = _collectMatches(textValue);
    matches.sort((a, b) => a.start.compareTo(b.start));

    final spans = _buildSpans(textValue, defaultStyle, matches);
    return TextSpan(style: defaultStyle, children: spans);
  }

  /// Collects all decoration matches in the text.
  List<_DecorationMatch> _collectMatches(String textValue) {
    final matches = <_DecorationMatch>[];
    if (decorations.containsKey(DecorationType.hashtag)) {
      matches.addAll(
          _matchRegex(_hashtagRegex, textValue, DecorationType.hashtag));
    }
    if (decorations.containsKey(DecorationType.mention)) {
      matches.addAll(
          _matchRegex(_mentionRegex, textValue, DecorationType.mention));
    }
    if (decorations.containsKey(DecorationType.email)) {
      matches.addAll(_matchRegex(_emailRegex, textValue, DecorationType.email));
    }
    if (decorations.containsKey(DecorationType.phone)) {
      matches.addAll(_matchPhoneMatches(textValue));
    }
    return matches;
  }

  /// Matches a regex and filters by delimiter.
  List<_DecorationMatch> _matchRegex(
      RegExp regex, String textValue, DecorationType type) {
    final result = <_DecorationMatch>[];
    for (final m in regex.allMatches(textValue)) {
      if (_hasDelimiter(textValue, m.end)) {
        result.add(_DecorationMatch(m.start, m.end, type));
      }
    }
    return result;
  }

  /// Uses dlibphonenumber to find phone numbers and filter by delimiter.
  List<_DecorationMatch> _matchPhoneMatches(String textValue) {
    final result = <_DecorationMatch>[];
    final phoneUtil = PhoneNumberUtil.instance;
    final phoneMatches = phoneUtil.findNumbers(textValue, '');
    for (final pm in phoneMatches) {
      final raw = pm.rawString;
      final escaped = RegExp.escape(raw);
      for (final m in RegExp(escaped).allMatches(textValue)) {
        if (_hasDelimiter(textValue, m.end)) {
          result.add(_DecorationMatch(m.start, m.end, DecorationType.phone));
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
  List<InlineSpan> _buildSpans(String textValue, TextStyle defaultStyle,
      List<_DecorationMatch> matches) {
    final spans = <InlineSpan>[];
    int last = 0;
    for (final dm in matches) {
      if (dm.start < last) continue;
      if (dm.start > last) {
        spans.add(TextSpan(
          text: textValue.substring(last, dm.start),
          style: defaultStyle,
        ));
      }
      spans.add(_buildTokenSpan(dm, textValue, defaultStyle));
      last = dm.end;
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
  InlineSpan _buildTokenSpan(
      _DecorationMatch dm, String textValue, TextStyle defaultStyle) {
    final token = textValue.substring(dm.start, dm.end);
    final cfg = decorations[dm.type]!;
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: GestureDetector(
        onTap: () {
          if (cfg.deleteOnTap) {
            final newText = textValue.replaceRange(dm.start, dm.end, '');
            text = newText;
            selection = TextSelection.collapsed(offset: dm.start);
          }
          cfg.onTap?.call(token);
        },
        child: Container(
          decoration: cfg.decoration,
          padding: cfg.padding,
          margin: cfg.margin,
          child: Text(token, style: cfg.textStyle ?? defaultStyle),
        ),
      ),
    );
  }

  @override
  set text(String value) {
    if (value != text) {
      rxText.value = value;
      if (onTextChange != null) {
        onTextChange?.call(text);
      }
      super.text = value;
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
