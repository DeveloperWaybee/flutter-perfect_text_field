// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../text_controller/text_controller.dart';

// Examples can assume:
// late BuildContext context;

/// The type of the [PerfectRawAutocomplete] callback which computes the list of
/// optional completions for the widget's field, based on the text the user has
/// entered so far.
///
/// See also:
///
///   * [PerfectRawAutocomplete.optionsBuilder], which is of this type.
typedef PerfectAutocompleteOptionsBuilder<T extends Object>
    = FutureOr<Iterable<T>> Function(TextEditingValue textEditingValue);

/// The type of the callback used by the [PerfectRawAutocomplete] widget to indicate
/// that the user has selected an option.
///
/// See also:
///
///   * [PerfectRawAutocomplete.onSelected], which is of this type.
typedef PerfectAutocompleteOnSelected<T extends Object> = String Function(
    T option);

/// The type of the [PerfectRawAutocomplete] callback which returns a [Widget] that
/// displays the specified [options] and calls [onSelected] if the user
/// selects an option.
///
/// The returned widget from this callback will be wrapped in an
/// [PerfectAutocompleteHighlightedOption] inherited widget. This will allow
/// this callback to determine which option is currently highlighted for
/// keyboard navigation.
///
/// See also:
///
///   * [PerfectRawAutocomplete.optionsViewBuilder], which is of this type.
typedef PerfectAutocompleteOptionsViewBuilder<T extends Object> = Widget
    Function(
  BuildContext context,
  PerfectAutocompleteOnSelected<T> onSelected,
  Iterable<T> options,
  void Function(Size?) onSizeChange,
);

/// The type of the Autocomplete callback which returns the widget that
/// contains the input [TextField] or [TextFormField].
///
/// See also:
///
///   * [PerfectRawAutocomplete.fieldViewBuilder], which is of this type.
typedef PerfectAutocompleteFieldViewBuilder = Widget Function(
  BuildContext context,
  PerfectTextController textController,
  VoidCallback onFieldSubmitted,
);

/// The type of the [PerfectRawAutocomplete] callback that converts an option value to
/// a string which can be displayed in the widget's options menu.
///
/// See also:
///
///   * [PerfectRawAutocomplete.displayStringForOption], which is of this type.
typedef PerfectAutocompleteOptionToString<T extends Object> = String Function(
    T option);

/// The user's text input is received in a field built with the
/// [fieldViewBuilder] parameter. The options to be displayed are determined
/// using [optionsBuilder] and rendered with [optionsViewBuilder].
/// {@endtemplate}
///
/// This is a core framework widget with very basic UI.
///
/// {@tool dartpad}
/// This example shows how to create a very basic autocomplete widget using the
/// [fieldViewBuilder] and [optionsViewBuilder] parameters.
///
/// ** See code in examples/api/lib/widgets/autocomplete/raw_autocomplete.0.dart **
/// {@end-tool}
///
/// The type parameter T represents the type of the options. Most commonly this
/// is a String, as in the example above. However, it's also possible to use
/// another type with a `toString` method, or a custom [displayStringForOption].
/// Options will be compared using `==`, so it may be beneficial to override
/// [Object.==] and [Object.hashCode] for custom types.
///
/// {@tool dartpad}
/// This example is similar to the previous example, but it uses a custom T data
/// type instead of directly using String.
///
/// ** See code in examples/api/lib/widgets/autocomplete/raw_autocomplete.1.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows the use of RawAutocomplete in a form.
///
/// ** See code in examples/api/lib/widgets/autocomplete/raw_autocomplete.2.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Autocomplete], which is a Material-styled implementation that is based
/// on RawAutocomplete.
@protected
class PerfectRawAutocomplete<T extends Object> extends StatefulWidget {
  /// Create an instance of RawAutocomplete.
  ///
  /// [displayStringForOption], [optionsBuilder] and [optionsViewBuilder] must
  /// not be null.
  const PerfectRawAutocomplete({
    super.key,
    required this.showOnTop,
    required this.optionsViewBuilder,
    required this.optionsBuilder,
    this.displayStringForOption = defaultStringForOption,
    this.fieldViewBuilder,
    this.onSelected,
    this.textController,
  }) : assert(
          fieldViewBuilder != null || (key != null && textController != null),
          'Pass in a fieldViewBuilder, or otherwise create a separate field and pass in the TextEditingController, and a key. Use the key with RawAutocomplete.onFieldSubmitted.',
        );

  final bool showOnTop;

  /// {@template flutter.widgets.RawAutocomplete.fieldViewBuilder}
  /// Builds the field whose input is used to get the options.
  ///
  /// Pass the provided [TextEditingController] to the field built here so that
  /// RawAutocomplete can listen for changes.
  /// {@endtemplate}
  final PerfectAutocompleteFieldViewBuilder? fieldViewBuilder;

  /// {@template flutter.widgets.RawAutocomplete.optionsViewBuilder}
  /// Builds the selectable options widgets from a list of options objects.
  ///
  /// The options are displayed floating below the field using a
  /// [CompositedTransformFollower] inside of an [Overlay], not at the same
  /// place in the widget tree as [PerfectRawAutocomplete].
  ///
  /// In order to track which item is highlighted by keyboard navigation, the
  /// resulting options will be wrapped in an inherited
  /// [PerfectAutocompleteHighlightedOption] widget.
  /// Inside this callback, the index of the highlighted option can be obtained
  /// from [PerfectAutocompleteHighlightedOption.of] to display the highlighted option
  /// with a visual highlight to indicate it will be the option selected from
  /// the keyboard.
  ///
  /// {@endtemplate}
  final PerfectAutocompleteOptionsViewBuilder<T> optionsViewBuilder;

  /// {@template flutter.widgets.RawAutocomplete.displayStringForOption}
  /// Returns the string to display in the field when the option is selected.
  ///
  /// This is useful when using a custom T type and the string to display is
  /// different than the string to search by.
  ///
  /// If not provided, will use `option.toString()`.
  /// {@endtemplate}
  final PerfectAutocompleteOptionToString<T> displayStringForOption;

  /// {@template flutter.widgets.RawAutocomplete.onSelected}
  /// Called when an option is selected by the user.
  ///
  /// Any [TextEditingController] listeners will not be called when the user
  /// selects an option, even though the field will update with the selected
  /// value, so use this to be informed of selection.
  /// {@endtemplate}
  final PerfectAutocompleteOnSelected<T>? onSelected;

  /// {@template flutter.widgets.RawAutocomplete.optionsBuilder}
  /// A function that returns the current selectable options objects given the
  /// current TextEditingValue.
  /// {@endtemplate}
  final PerfectAutocompleteOptionsBuilder<T> optionsBuilder;

  /// The [PerfectTextController] that is used for the text field.
  ///
  /// {@macro flutter.widgets.RawAutocomplete.split}
  ///
  final PerfectTextController? textController;

  /// Calls [PerfectAutocompleteFieldViewBuilder]'s onFieldSubmitted callback for the
  /// RawAutocomplete widget indicated by the given [GlobalKey].
  ///
  /// This is not typically used unless a custom field is implemented instead of
  /// using [fieldViewBuilder]. In the typical case, the onFieldSubmitted
  /// callback is passed via the [PerfectAutocompleteFieldViewBuilder] signature. When
  /// not using fieldViewBuilder, the same callback can be called by using this
  /// static method.
  ///
  /// See also:
  ///
  ///  * [focusNode] and [textController], which contain a code example
  ///    showing how to create a separate field outside of fieldViewBuilder.
  static void onFieldSubmitted<T extends Object>(GlobalKey key) {
    final _PerfectRawAutocompleteState<T> rawAutocomplete =
        key.currentState! as _PerfectRawAutocompleteState<T>;
    rawAutocomplete._onFieldSubmitted();
  }

  /// The default way to convert an option to a string in
  /// [displayStringForOption].
  ///
  /// Uses the `toString` method of the given `option`.
  static String defaultStringForOption(Object? option) {
    return option.toString();
  }

  @override
  State<PerfectRawAutocomplete<T>> createState() =>
      _PerfectRawAutocompleteState<T>();
}

class _PerfectRawAutocompleteState<T extends Object>
    extends State<PerfectRawAutocomplete<T>> {
  final GlobalKey _fieldKey = GlobalKey();
  final LayerLink _optionsLayerLink = LayerLink();
  late PerfectTextController _controller;
  late final Map<Type, Action<Intent>> _actionMap;
  late final _AutocompleteCallbackAction<
      PerfectAutocompletePreviousOptionIntent> _previousOptionAction;
  late final _AutocompleteCallbackAction<PerfectAutocompleteNextOptionIntent>
      _nextOptionAction;
  late final _AutocompleteCallbackAction<DismissIntent> _hideOptionsAction;
  Iterable<T> _options = Iterable<T>.empty();
  T? _selection;
  bool _userHidOptions = false;
  String _lastFieldText = '';
  final ValueNotifier<int> _highlightedOptionIndex = ValueNotifier<int>(0);

  static const Map<ShortcutActivator, Intent> _shortcuts =
      <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp):
        PerfectAutocompletePreviousOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown):
        PerfectAutocompleteNextOptionIntent(),
  };

  // The OverlayEntry containing the options.
  OverlayEntry? _floatingOptions;

  // True iff the state indicates that the options should be visible.
  bool get _shouldShowOptions {
    return !_userHidOptions &&
        _controller.focusNode.hasFocus &&
        _selection == null &&
        _options.isNotEmpty;
  }

  // Called when _textEditingController changes.
  Future<void> _onChangedField() async {
    final TextEditingValue value = _controller.textController.value;
    final Iterable<T> options = await widget.optionsBuilder(
      value,
    );
    _options = options;
    _updateHighlight(_highlightedOptionIndex.value);
    if (_selection != null &&
        value.text != widget.displayStringForOption(_selection!)) {
      _selection = null;
    }

    // Make sure the options are no longer hidden if the content of the field
    // changes (ignore selection changes).
    if (value.text != _lastFieldText) {
      _userHidOptions = false;
      _lastFieldText = value.text;
    }
    _updateActions();
    _updateOverlay();
  }

  // Called when the field's FocusNode changes.
  void _onChangedFocus() {
    // Options should no longer be hidden when the field is re-focused.
    _userHidOptions = !_controller.focusNode.hasFocus;
    _updateActions();
    _updateOverlay();
  }

  // Called from fieldViewBuilder when the user submits the field.
  void _onFieldSubmitted() {
    if (_options.isEmpty || _userHidOptions) {
      return;
    }
    _select(_options.elementAt(_highlightedOptionIndex.value));
  }

  // Select the given option and update the widget.
  String _select(T nextSelection) {
    _selection = nextSelection;
    final selectionString = widget.displayStringForOption(nextSelection);

    final updatedText = widget.onSelected?.call(_selection!) ?? selectionString;
    _controller.textController.value = TextEditingValue(
      selection: TextSelection.collapsed(offset: updatedText.length),
      text: updatedText,
    );
    _updateActions();
    _updateOverlay();

    if (_controller.hasFocus) {
      _controller.focusNode.unfocus();
    }

    return updatedText;
  }

  void _updateHighlight(int newIndex) {
    _highlightedOptionIndex.value =
        _options.isEmpty ? 0 : newIndex % _options.length;
  }

  void _highlightPreviousOption(
      PerfectAutocompletePreviousOptionIntent intent) {
    if (_userHidOptions) {
      _userHidOptions = false;
      _updateActions();
      _updateOverlay();
      return;
    }
    _updateHighlight(_highlightedOptionIndex.value - 1);
  }

  void _highlightNextOption(PerfectAutocompleteNextOptionIntent intent) {
    if (_userHidOptions) {
      _userHidOptions = false;
      _updateActions();
      _updateOverlay();
      return;
    }
    _updateHighlight(_highlightedOptionIndex.value + 1);
  }

  Object? _hideOptions(DismissIntent intent) {
    if (!_userHidOptions) {
      _userHidOptions = true;
      _updateActions();
      _updateOverlay();
      return null;
    }
    return Actions.invoke(context, intent);
  }

  void _setActionsEnabled(bool enabled) {
    // The enabled state determines whether the action will consume the
    // key shortcut or let it continue on to the underlying text field.
    // They should only be enabled when the options are showing so shortcuts
    // can be used to navigate them.
    _previousOptionAction.enabled = enabled;
    _nextOptionAction.enabled = enabled;
    _hideOptionsAction.enabled = enabled;
  }

  void _updateActions() {
    _setActionsEnabled(_controller.focusNode.hasFocus &&
        _selection == null &&
        _options.isNotEmpty);
  }

  bool _floatingOptionsUpdateScheduled = false;
  // Hide or show the options overlay, if needed.
  void _updateOverlay() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      if (!_floatingOptionsUpdateScheduled) {
        _floatingOptionsUpdateScheduled = true;
        SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
          _floatingOptionsUpdateScheduled = false;
          _updateOverlay();
        });
      }
      return;
    }

    _floatingOptions?.remove();
    if (_shouldShowOptions) {
      final OverlayEntry newFloatingOptions = OverlayEntry(
        builder: (BuildContext context) {
          final sizeNotifier = ValueNotifier<Size?>(null);
          return CompositedTransformFollower(
            link: _optionsLayerLink,
            showWhenUnlinked: false,
            targetAnchor:
                widget.showOnTop ? Alignment.topLeft : Alignment.bottomLeft,
            child: ValueListenableBuilder<Size?>(
              valueListenable: sizeNotifier,
              builder: (context, size, child) {
                if (widget.showOnTop && size == null) {
                  return Opacity(
                    opacity: 0,
                    child: child,
                  );
                }
                return Transform.translate(
                  offset: widget.showOnTop
                      ? Offset(0, (size != null) ? -size.height : 0)
                      : Offset.zero,
                  child: child,
                );
              },
              child: TextFieldTapRegion(
                child: PerfectAutocompleteHighlightedOption(
                    highlightIndexNotifier: _highlightedOptionIndex,
                    child: Builder(builder: (BuildContext context) {
                      return widget.optionsViewBuilder(
                        context,
                        _select,
                        _options,
                        (p0) {
                          sizeNotifier.value = p0;
                        },
                      );
                    })),
              ),
            ),
          );
        },
      );
      Overlay.of(context, rootOverlay: true, debugRequiredFor: widget)
          .insert(newFloatingOptions);
      _floatingOptions = newFloatingOptions;
    } else {
      _floatingOptions = null;
    }
  }

  // Handle a potential change in textEditingController by properly disposing of
  // the old one and setting up the new one, if needed.
  void _updateTextEditingController(
      TextEditingController? old, TextEditingController? current) {
    if ((old == null && current == null) || old == current) {
      return;
    }
    if (old == null) {
      _controller.textController.removeListener(_onChangedField);
      _controller.textController.dispose();
      final newController = PerfectTextController(
        textEditingController: current!,
        focusNode: _controller.focusNode,
      );
      _controller = newController;
    } else if (current == null) {
      _controller.textController.removeListener(_onChangedField);
      final newController = PerfectTextController(
        textEditingController: TextEditingController(),
        focusNode: _controller.focusNode,
      );
      _controller = newController;
    } else {
      _controller.textController.removeListener(_onChangedField);
      final newController = PerfectTextController(
        textEditingController: current,
        focusNode: _controller.focusNode,
      );
      _controller = newController;
    }
    _controller.textController.addListener(_onChangedField);
  }

  // Handle a potential change in focusNode by properly disposing of the old one
  // and setting up the new one, if needed.
  void _updateFocusNode(FocusNode? old, FocusNode? current) {
    if ((old == null && current == null) || old == current) {
      return;
    }
    if (old == null) {
      _controller.focusNode.removeListener(_onChangedFocus);
      _controller.focusNode.dispose();
      final newController = PerfectTextController(
        textEditingController: _controller.textController,
        focusNode: current!,
      );
      _controller = newController;
    } else if (current == null) {
      _controller.focusNode.removeListener(_onChangedFocus);
      final newController = PerfectTextController(
        textEditingController: _controller.textController,
        focusNode: FocusNode(),
      );
      _controller = newController;
    } else {
      _controller.focusNode.removeListener(_onChangedFocus);
      final newController = PerfectTextController(
        textEditingController: _controller.textController,
        focusNode: current,
      );
      _controller = newController;
    }
    _controller.focusNode.addListener(_onChangedFocus);
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.textController ?? PerfectTextController();
    _controller.textController.addListener(_onChangedField);
    _controller.focusNode.addListener(_onChangedFocus);
    _previousOptionAction =
        _AutocompleteCallbackAction<PerfectAutocompletePreviousOptionIntent>(
            onInvoke: _highlightPreviousOption);
    _nextOptionAction =
        _AutocompleteCallbackAction<PerfectAutocompleteNextOptionIntent>(
            onInvoke: _highlightNextOption);
    _hideOptionsAction =
        _AutocompleteCallbackAction<DismissIntent>(onInvoke: _hideOptions);
    _actionMap = <Type, Action<Intent>>{
      PerfectAutocompletePreviousOptionIntent: _previousOptionAction,
      PerfectAutocompleteNextOptionIntent: _nextOptionAction,
      DismissIntent: _hideOptionsAction,
    };
    _updateActions();
    _updateOverlay();
  }

  @override
  void didUpdateWidget(PerfectRawAutocomplete<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateTextEditingController(
      oldWidget.textController?.textController,
      widget.textController?.textController,
    );
    _updateFocusNode(
      oldWidget.textController?.focusNode,
      widget.textController?.focusNode,
    );
    _updateActions();
    _updateOverlay();
  }

  @override
  void dispose() {
    _controller.textController.removeListener(_onChangedField);
    _controller.focusNode.removeListener(_onChangedFocus);
    if (widget.textController == null) {
      _controller.textController.dispose();
      _controller.focusNode.dispose();
    }
    _floatingOptions?.remove();
    _floatingOptions = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldTapRegion(
      child: Container(
        key: _fieldKey,
        child: Shortcuts(
          shortcuts: _shortcuts,
          child: Actions(
            actions: _actionMap,
            child: CompositedTransformTarget(
              link: _optionsLayerLink,
              child: widget.fieldViewBuilder == null
                  ? const SizedBox.shrink()
                  : widget.fieldViewBuilder!(
                      context,
                      _controller,
                      _onFieldSubmitted,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AutocompleteCallbackAction<T extends Intent> extends CallbackAction<T> {
  _AutocompleteCallbackAction({
    required super.onInvoke,
    this.enabled = true,
  });

  bool enabled;

  @override
  bool isEnabled(covariant T intent) => enabled;

  @override
  bool consumesKey(covariant T intent) => enabled;
}

/// An [Intent] to highlight the previous option in the autocomplete list.
@protected
class PerfectAutocompletePreviousOptionIntent extends Intent {
  /// Creates an instance of AutocompletePreviousOptionIntent.
  const PerfectAutocompletePreviousOptionIntent();
}

/// An [Intent] to highlight the next option in the autocomplete list.
@protected
class PerfectAutocompleteNextOptionIntent extends Intent {
  /// Creates an instance of AutocompleteNextOptionIntent.
  const PerfectAutocompleteNextOptionIntent();
}

/// An inherited widget used to indicate which autocomplete option should be
/// highlighted for keyboard navigation.
///
/// The `RawAutoComplete` widget will wrap the options view generated by the
/// `optionsViewBuilder` with this widget to provide the highlighted option's
/// index to the builder.
///
/// In the builder callback the index of the highlighted option can be obtained
/// by using the static [of] method:
///
/// ```dart
/// int highlightedIndex = AutocompleteHighlightedOption.of(context);
/// ```
///
/// which can then be used to tell which option should be given a visual
/// indication that will be the option selected with the keyboard.
@protected
class PerfectAutocompleteHighlightedOption
    extends InheritedNotifier<ValueNotifier<int>> {
  /// Create an instance of AutocompleteHighlightedOption inherited widget.
  const PerfectAutocompleteHighlightedOption({
    super.key,
    required ValueNotifier<int> highlightIndexNotifier,
    required super.child,
  }) : super(notifier: highlightIndexNotifier);

  /// Returns the index of the highlighted option from the closest
  /// [PerfectAutocompleteHighlightedOption] ancestor.
  ///
  /// If there is no ancestor, it returns 0.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// int highlightedIndex = AutocompleteHighlightedOption.of(context);
  /// ```
  static int of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<
                PerfectAutocompleteHighlightedOption>()
            ?.notifier
            ?.value ??
        0;
  }
}
