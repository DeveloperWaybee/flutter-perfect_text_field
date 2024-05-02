// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../auto_complete/perfect_raw_auto_complete.dart';
import '../perfect_text_field.dart';

/// The type of the [PerfectAutocomplete] callback which returns a [Widget] that
/// displays on the specific [option] at [index].
///
/// The returned widget from this callback will be wrapped in an
/// [PerfectAutocompleteHighlightedOption] inherited widget. This will allow
/// this callback to determine which option is currently highlighted for
/// keyboard navigation.
///
typedef PerfectAutocompleteOptionBuilder<T extends Object> = Widget Function(
  BuildContext context,
  int index,
  T option,
  bool highlight,
);

/// {@macro flutter.widgets.RawAutocomplete.RawAutocomplete}
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=-Nny8kzW380}
///
/// {@tool dartpad}
/// This example shows how to create a very basic Autocomplete widget using the
/// default UI.
///
/// ** See code in examples/api/lib/material/autocomplete/autocomplete.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to create an Autocomplete widget with a custom type.
/// Try searching with text from the name or email field.
///
/// ** See code in examples/api/lib/material/autocomplete/autocomplete.1.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to create an Autocomplete widget whose options are
/// fetched over the network.
///
/// ** See code in examples/api/lib/material/autocomplete/autocomplete.2.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to create an Autocomplete widget whose options are
/// fetched over the network. It uses debouncing to wait to perform the network
/// request until after the user finishes typing.
///
/// ** See code in examples/api/lib/material/autocomplete/autocomplete.3.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to create an Autocomplete widget whose options are
/// fetched over the network. It includes both debouncing and error handling, so
/// that failed network requests show an error to the user and can be recovered
/// from. Try toggling the network Switch widget to simulate going offline.
///
/// ** See code in examples/api/lib/material/autocomplete/autocomplete.4.dart **
/// {@end-tool}
///
/// See also:
///
///  * [RawAutocomplete], which is what Autocomplete is built upon, and which
///    contains more detailed examples.
@protected
class PerfectAutocomplete<T extends Object> extends StatelessWidget {
  /// Creates an instance of [PerfectAutocomplete].
  PerfectAutocomplete({
    super.key,
    PerfectTextController? textController,
    required this.optionsBuilder,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.fieldViewBuilder = _defaultFieldViewBuilder,
    this.onSelected,
    this.optionsWidth = 200.0,
    this.optionsMaxHeight = 200.0,
    this.optionBuilder,
    this.showOnTop = false,
  }) : _textController = textController ?? PerfectTextController();

  final PerfectTextController _textController;

  /// {@macro flutter.widgets.RawAutocomplete.displayStringForOption}
  final AutocompleteOptionToString<T> displayStringForOption;

  /// {@macro flutter.widgets.RawAutocomplete.fieldViewBuilder}
  ///
  /// If not provided, will build a standard Material-style text field by
  /// default.
  final Widget Function(
    BuildContext context,
    PerfectTextController textController,
    VoidCallback onFieldSubmitted,
  ) fieldViewBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.onSelected}
  final PerfectAutocompleteOnSelected<T>? onSelected;

  /// {@macro flutter.widgets.RawAutocomplete.optionsBuilder}
  final PerfectAutocompleteOptionsBuilder<T> optionsBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.optionsViewBuilder}
  ///
  /// If not provided, will build a standard Material-style list of results by
  /// default.
  final PerfectAutocompleteOptionBuilder<T>? optionBuilder;

  /// The maximum height used for the default Material options list widget.
  ///
  /// When [optionBuilder] is `null`, this property sets the maximum height
  /// that the options widget can occupy.
  ///
  /// The default value is set to 200.
  final double optionsWidth;

  /// The maximum height used for the default Material options list widget.
  ///
  /// When [optionBuilder] is `null`, this property sets the maximum height
  /// that the options widget can occupy.
  ///
  /// The default value is set to 200.
  final double optionsMaxHeight;

  final bool showOnTop;

  static Widget _defaultFieldViewBuilder(BuildContext context,
      PerfectTextController textController, VoidCallback onFieldSubmitted) {
    return _AutocompleteField(
      textController: textController,
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PerfectRawAutocomplete<T>(
      showOnTop: showOnTop,
      displayStringForOption: displayStringForOption,
      fieldViewBuilder: (context, controller, onFieldSubmitted) =>
          fieldViewBuilder(context, controller, onFieldSubmitted),
      textController: _textController,
      optionsBuilder: optionsBuilder,
      optionsViewBuilder: (
        BuildContext context,
        PerfectAutocompleteOnSelected<T> onSelected,
        Iterable<T> options,
        void Function(Size?) onSizeChange,
      ) {
        return _AutocompleteOptions<T>(
          displayStringForOption: displayStringForOption,
          onSelected: onSelected,
          options: options,
          optionBuilder: optionBuilder,
          optionsWidth: optionsWidth,
          maxOptionsHeight: optionsMaxHeight,
          showOnTop: showOnTop,
          onSizeChange: onSizeChange,
        );
      },
      onSelected: onSelected,
    );
  }
}

// The default Material-style Autocomplete text field.
class _AutocompleteField extends StatelessWidget {
  const _AutocompleteField({
    required this.textController,
    required this.onFieldSubmitted,
  });

  final VoidCallback onFieldSubmitted;

  final PerfectTextController textController;

  @override
  Widget build(BuildContext context) {
    return PerfectTextField(
      controller: textController,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
}

// The default Material-style Autocomplete options.
class _AutocompleteOptions<T extends Object> extends StatefulWidget {
  const _AutocompleteOptions({
    super.key,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.optionBuilder,
    required this.optionsWidth,
    required this.maxOptionsHeight,
    required this.showOnTop,
    required this.onSizeChange,
  });

  final PerfectAutocompleteOptionToString<T> displayStringForOption;

  final PerfectAutocompleteOnSelected<T> onSelected;

  final Iterable<T> options;
  final double optionsWidth;
  final double maxOptionsHeight;
  final bool showOnTop;
  final void Function(Size? size) onSizeChange;

  /// {@macro flutter.widgets.RawAutocomplete.optionsViewBuilder}
  ///
  /// If not provided, will build a standard Material-style list of results by
  /// default.
  final PerfectAutocompleteOptionBuilder<T>? optionBuilder;

  @override
  State<_AutocompleteOptions<T>> createState() =>
      _AutocompleteOptionsState<T>();
}

class _AutocompleteOptionsState<T extends Object>
    extends State<_AutocompleteOptions<T>> {
  final size = ValueNotifier<Size?>(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Size?>(
      valueListenable: size,
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: widget.optionsWidth,
                maxHeight: widget.maxOptionsHeight,
              ),
              child: _PerfectOptionsListView(
                onSizeChange: widget.onSizeChange,
                widget: widget,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PerfectOptionsListView<T extends Object> extends StatefulWidget {
  const _PerfectOptionsListView({
    required this.onSizeChange,
    required this.widget,
  });

  final void Function(Size? size) onSizeChange;
  final _AutocompleteOptions<T> widget;

  @override
  State<_PerfectOptionsListView<T>> createState() =>
      _PerfectOptionsListViewState<T>();
}

class _PerfectOptionsListViewState<T extends Object>
    extends State<_PerfectOptionsListView<T>> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onSizeChange(context.size);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onSizeChange(context.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: widget.widget.options.length,
      itemBuilder: (BuildContext context, int index) {
        final T option = widget.widget.options.elementAt(index);
        return InkWell(
          onTap: () {
            widget.widget.onSelected(option);
          },
          child: Builder(builder: (BuildContext context) {
            final bool highlight =
                PerfectAutocompleteHighlightedOption.of(context) == index;
            if (highlight) {
              SchedulerBinding.instance
                  .addPostFrameCallback((Duration timeStamp) {
                Scrollable.ensureVisible(context, alignment: 0.5);
              });
            }
            return widget.widget.optionBuilder
                    ?.call(context, index, option, highlight) ??
                Container(
                  color: highlight ? Theme.of(context).focusColor : null,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.widget.displayStringForOption(option)),
                );
          }),
        );
      },
    );
  }
}
