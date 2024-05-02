# Perfect TextField

A Flutter package providing a versatile and customizable text field with extended functionalities. `PerfectTextField` builds on `TextFormField` and integrates additional features like auto-complete and a custom text controller for advanced text editing scenarios.

## Features

### PerfectTextField
- **Custom Text Controller**: Integrates `PerfectTextController` for extended control over text editing and state management.
- **Auto-complete**: Supports auto-complete functionality with `PerfectAutoCompleteTextField`.
- **Flexible Text Input**: Allows customization of the text field with numerous parameters such as `cursorColor`, `cursorRadius`, and more for better UI integration.
- **Event Handling**: Custom event handling for taps outside the text field, allowing for more interactive forms.
- **Styling Options**: Extensive styling options with default and customizable text styles and decorations.

### PerfectTextController
- **Custom Text Controller**: Uses `PerfectTextController` to enhance control over text editing, focus management, and state updates with support for reactive programming via `get`.
- **Reactive State Management**: Leverages Rx variables to reactively manage and observe changes to the text field's content and focus state.
- **Advanced Focus Control**: Offers methods like `selectAll`, `unfocus`, and `requestFocus` to programmatically control focus and text selection.
- **Auto-complete**: Supports auto-complete functionality, seamlessly integrated into the `PerfectTextField`.
- **Event Handling**: Enhanced event handling capabilities for changes in text and focus, along with custom actions on external taps.

### PerfectRawAutocomplete
- **Customizable Options**: Fully customizable autocomplete options that can be styled and handled according to your application's needs.
- **Reactive User Input Handling**: Dynamically generates suggestions based on user input.
- **Keyboard Navigation**: Supports keyboard actions for navigating through suggestions.
- **Selection Callbacks**: Provides callbacks for handling the selection of suggestions.
- **Advanced Text Handling**: Integrates with custom `PerfectTextController` for more refined control over text input and focus management.

### DecimalNumberFormatter
- **Value Constraints**: Allows setting minimum and maximum values for the input.
- **Decimal Precision**: Controls the number of digits allowed after the decimal point.
- **Smart Correction**: Optionally replaces the last digit if input exceeds the maximum decimal length, ensuring continuous input flow without the need to delete characters manually.
- **Flexible Input Handling**: Prevents undesired inputs like leading zeros and improperly placed decimal points.


## Getting Started

To use this package, add `perfect_text_field` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  perfect_text_field: 1.0.0
```

## PerfectTextField Usage

Here is a simple example of how to use `PerfectTextField` in your Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:perfect_text_field/perfect_text_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Perfect TextField Example')),
        body: Center(
          child: PerfectTextField(
            controller: PerfectTextController(
              onTextChange: (text) {
                print("Text changed: $text");
              },
              onFocusChange: (hasFocus) {
                print("Field has focus: $hasFocus");
              },
            ),
            inputFormatters: [
              DecimalNumberFormatter(
                min: 1.0,
                max: 100.0,
                decimalLength: 2,
              )
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ),
    );
  }
}
```

## PerfectRawAutocomplete Usage

```dart
import 'package:flutter/material.dart';
import 'package:perfect_raw_autocomplete/perfect_raw_autocomplete.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Perfect Raw Autocomplete Example')),
        body: PerfectRawAutocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            // Assume your logic to suggest autocomplete options
            return ['Apple', 'Banana', 'Cherry'].where((String option) {
              return option.contains(textEditingValue.text.toLowerCase());
            });
          },
          fieldViewBuilder: (BuildContext context, PerfectTextController textController, VoidCallback onFieldSubmitted) {
            return TextFormField(
              controller: textController.textController,
              onFieldSubmitted: (String value) => onFieldSubmitted(),
            );
          },
          optionsViewBuilder: (BuildContext context, PerfectAutocompleteOnSelected<String> onSelected, Iterable<String> options, void Function(Size?) onSizeChange) {
            return Material(
              elevation: 4.0,
              child: ListView(
                children: options.map((String option) {
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option),
                    ),
                  );
                }).toList(),
              ),
            );
          },
          onSelected: (String selection) {
            print('You just selected $selection');
          },
        ),
      ),
    );
  }
}
```

## Parameters

### PerfectTextField
`PerfectTextField` supports all the parameters of `TextFormField` plus additional ones specific to its functionality:

- `onTapOutside`: Callback fired when a tap is detected outside the text field.
- `prefixText`: Optional text to display as a prefix within the text field.
- `hintText`: Text that suggests what sort of input the field accepts.
- Additional customization parameters such as `cursorColor`, `cursorRadius`, etc.


### PerfectTextController
- `optionsBuilder`: Define how suggestions are generated based on user input.
- `fieldViewBuilder`: Build the text field widget for input.
- `optionsViewBuilder`: Build the widget that displays the suggestions.
- `onSelected`: A callback that fires when an option is selected, allowing for custom action.

### PerfectRawAutocomplete
`PerfectRawAutocomplete` is a robust Flutter package designed for implementing customized autocomplete functionality within your Flutter applications. It leverages the fundamental architecture of Flutter's `RawAutocomplete` to allow for greater flexibility and customization.

### DecimalNumberFormatter
`DecimalNumberFormatter` provides a `TextInputFormatter` for handling decimal inputs within text fields. This formatter not only enforces numeric constraints but also manages decimal precision, making it ideal for financial and other precision-required inputs.

min: The minimum value allowed.
max: The maximum value allowed.
decimalLength: Maximum number of decimal digits.
replaceLastIfExceeds: Whether to replace the last digit when exceeding the decimal length (default is true).


## Contributions

Contributions are welcome! If you have suggestions or issues, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```