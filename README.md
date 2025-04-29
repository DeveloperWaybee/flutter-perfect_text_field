
# Perfect Text Field

> **An all-in-one Flutter text input toolkit** — editable, decorated, reactive, and smart.  
> Build rich input fields with token highlighting, auto-complete, number formatting, and custom behaviors, all fully editable.

---

## ✨ Features

### 📌 `PerfectTextField`
- A drop-in replacement for `TextField`/`TextFormField`.
- Works with `PerfectTextController` for advanced decorations and focus control.
- Supports token highlights, autocomplete, number input formatting, and more.

### 📋 `PerfectTextController`
- Detects and highlights:
  - **Hashtags** (#example)
  - **Mentions** (@username)
  - **Emails** (user@example.com)
  - **Phone Numbers** (+1 234 567 8900 via dlibphonenumber)
- `DecorationStyle` per token: background color, text style, tap-to-delete option.
- **Reactive**: Get real-time updates via `rxText` notifier.
- Full focus control: `requestFocus()`, `selectAll()`, etc.
- Smart delimiter matching for accurate highlighting.

### 🔍 `PerfectAutocomplete`
- Material Design styled autocomplete widget.
- Async or sync options building.
- Keyboard navigation (up/down arrows).
- Fully customizable field and options list.
- Built on top of `PerfectRawAutocomplete`.

### 🛠 `PerfectRawAutocomplete`
- Raw, flexible, low-level autocomplete engine.
- Overlay-based options with highlighted selection.
- Provides building blocks for custom autocomplete UIs.

### 🔢 `DecimalNumberFormatter`
- Text input formatter to restrict number fields:
  - Minimum and maximum values.
  - Decimal precision (e.g., only 2 digits after `.`).
  - Smart correction: replaces last character if overflow.

### 🗑 `DeletePreviousCharIntent`
- Custom intent to delete the previous character inside a `PerfectTextController`.
- Useful for keyboard shortcut integrations.

---

## 🚀 Getting Started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  perfect_text_field: latest
```

---

## 🧩 Quick Example

```dart
import 'package:flutter/material.dart';
import 'package:perfect_text_field/perfect_text_field.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PerfectTextController(
      text: 'Welcome to #Flutter! Contact @support or email hello@flutter.dev.',
      decorations: [
        DecorationStyle(
          type: DecorationType.hashtag,
          backgroundColor: Colors.blue.withOpacity(0.2),
          textStyle: const TextStyle(color: Colors.blue),
        ),
        DecorationStyle(
          type: DecorationType.mention,
          backgroundColor: Colors.green.withOpacity(0.2),
          textStyle: const TextStyle(color: Colors.green),
        ),
        DecorationStyle(
          type: DecorationType.email,
          backgroundColor: Colors.orange.withOpacity(0.2),
          textStyle: const TextStyle(color: Colors.orange),
        ),
      ],
      phoneRegion: 'US',
    );

    return MaterialApp(
      title: 'Perfect Text Field Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Perfect TextField Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PerfectTextField(
            controller: controller,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Type #tags, @mentions, emails, phones...',
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## 🎨 Autocomplete Example

```dart
PerfectAutocomplete<String>(
  optionsBuilder: (textEditingValue) async {
    if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
    return ['Apple', 'Banana', 'Cherry'].where(
      (option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()),
    );
  },
  onSelected: (option) => print('Selected: $option'),
);
```

---

## 📜 License

MIT License.  
See the [LICENSE](LICENSE) file for full details.

---
