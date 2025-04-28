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

### **New** Advanced Token Decoration (PerfectTextController)
- **Hashtags, Mentions, Emails, Phone Numbers**: Automatically detects and highlights tokens in the text.
- **Delimiter Matching**: Ensures tokens are only matched when followed by whitespace or punctuation (` `, `,`, `.`, `!`, `?`), avoiding partial-word matches.
- **dlibphonenumber Integration**: Leverages the `dlibphonenumber` package to accurately detect phone numbers in various formats based on the provided `phoneRegion`.
- **Custom `DecorationStyle`**: Configure styling and behavior for each `DecorationType` (hashtag, mention, email, phone) including:
  - `decoration` (BoxDecoration)
  - `padding` & `margin` (EdgeInsets)
  - `textStyle` (TextStyle)
  - `onTap` callback
  - `deleteOnTap` flag to remove tokens on tap
- **Multiple Occurrences**: Highlights every occurrence of a token, even if it appears multiple times.

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

## Usage Examples

### PerfectTextField Example

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
                print("Text changed: \$text");
              },
              onFocusChange: (hasFocus) {
                print("Field has focus: \$hasFocus");
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

### Advanced Token Decoration Example

```dart
final controller = PerfectTextController(
  text: 'Hello @alice, email me at alice@example.com. Call +1 800-123-4567? #flutter',
  decorations: {
    DecorationType.hashtag: DecorationStyle(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: TextStyle(color: Colors.blue),
      onTap: (tag) => print('Hashtag tapped: \$tag'),
      deleteOnTap: false,
    ),
    DecorationType.mention: DecorationStyle(
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: TextStyle(color: Colors.green),
      onTap: (mention) => print('Mention tapped: \$mention'),
    ),
    DecorationType.email: DecorationStyle(
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: TextStyle(color: Colors.orange),
      onTap: (email) => print('Email tapped: \$email'),
    ),
    DecorationType.phone: DecorationStyle(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: TextStyle(color: Colors.red),
      onTap: (phone) => print('Phone tapped: \$phone'),
      deleteOnTap: true,
    ),
  },
  phoneRegion: 'US',
);

TextField(
  controller: controller,
  maxLines: null,
  decoration: InputDecoration(hintText: 'Type #tags, @mentions, emails, phones…'),
),
```

## Contributions

Contributions are welcome! If you have suggestions or issues, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

