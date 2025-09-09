## 2.3.2+3
fix: update rxText value after frame callback to ensure UI consistency

## 2.3.2+2
fix: update onTextChange callback in PerfectTextController for better text change handling

## 2.3.2+1
fix: update iOS deployment target to 13.0 and improve text change notification in PerfectTextController

## 2.3.2
Added focusNode in PerfectTextController

## 2.3.1
dlibphonenumber: ^1.1.40 package update

## 2.3.0+2
Fix onTextChange callback to provide updated text in PerfectTextController

## 2.3.0+1
Remove redundant final keyword from onTextChange and onFocusChange in PerfectTextController

## 2.3.0
Simplify DecorationStyle by removing decoration property and updating text rendering

## 2.2.0+1
Handle empty decorations in buildTextSpan method

## 2.2.0
Refactor decoration handling to use a list instead of a map for DecorationStyle

## 2.1.0
Remove GetX, Changed Rx to ValueNotifier

## 2.0.0
feat: Update Runner scheme and AppDelegate for new Xcode version

- Updated LastUpgradeVersion in Runner.xcscheme to 1510.
- Changed @UIApplicationMain to @main in AppDelegate.swift.

feat: Enhance Runner workspace with Pods reference

- Added Pods.xcodeproj reference to Runner.xcworkspace.

feat: Refactor main.dart to support new text controllers

- Introduced decimalFormatterTextController and chipTextController.
- Updated UI to include new PerfectTextField instances for decimal formatting and chip text field.

chore: Update pubspec.lock with new dependencies

- Added dlibphonenumber and fixnum packages.
- Updated version of existing packages.

fix: Refactor PerfectRawAutocomplete to use new PerfectTextController

- Updated references from TextEditingController to PerfectTextController.
- Adjusted listener management for text changes and focus.

feat: Revamp PerfectTextField implementation

- Converted PerfectTextField from a subclass of TextFormField to a StatefulWidget.
- Enhanced constructor to accept various parameters for customization.
- Updated build method to utilize the new PerfectTextController.

feat: Introduce decoration features in PerfectTextController

- Added support for hashtags, mentions, emails, and phone numbers with custom styling.
- Implemented methods for matching and displaying decorated text.

chore: Bump version to 2.0.0 in pubspec.yaml

- Updated version number to reflect major changes and enhancements.

## 1.1.0+3
Add dismissKeyboardOnTapOutside parameter to PerfectTextField

## 1.1.0+2
Change PerfectTextController.selectAllOnFocus = false

## 1.1.0
Package Updates

## 1.0.0
PerfectTextField,
PerfectTextController,
PerfectAutocomplete,
PerfectRawAutocomplete,
DecimalNumberFormatter