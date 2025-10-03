# Development Guide

This guide will help you get started with developing the MyGetWell Vendor Mobile App.

## Quick Start

### 1. Environment Setup

**Install Flutter:**
```bash
# macOS
brew install flutter

# Or download from https://flutter.dev/docs/get-started/install
```

**Verify installation:**
```bash
flutter doctor
```

Fix any issues reported by `flutter doctor` before proceeding.

### 2. Clone and Setup

```bash
# Clone the repository
git clone https://github.com/sbasharjr/Vendor-Mobile-App.git
cd Vendor-Mobile-App

# Get dependencies
flutter pub get

# Run code generation (if needed)
flutter pub run build_runner build
```

### 3. Running the App

**On connected device:**
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run with hot reload (default)
flutter run

# Run in release mode
flutter run --release
```

**On iOS Simulator:**
```bash
open -a Simulator
flutter run
```

**On Android Emulator:**
```bash
# Start emulator from Android Studio or
emulator -avd <avd-name>
flutter run
```

## Development Workflow

### 1. Code Structure

Follow the existing project structure:
```
lib/
├── config/         # App configuration (theme, API, etc.)
├── models/         # Data models
├── screens/        # UI screens
├── services/       # Business logic and API services
├── widgets/        # Reusable widgets
└── utils/          # Helper functions
```

### 2. Creating New Screens

1. Create screen file in appropriate directory under `lib/screens/`
2. Add route in `lib/main.dart`
3. Follow existing screen patterns for consistency

Example:
```dart
// lib/screens/example/example_screen.dart
import 'package:flutter/material.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: const Center(child: Text('Example Screen')),
    );
  }
}
```

### 3. Creating Models

Models should include:
- Properties with appropriate types
- `fromJson` factory constructor
- `toJson` method
- `copyWith` method (for immutability)

Example:
```dart
class ExampleModel {
  final String id;
  final String name;

  ExampleModel({required this.id, required this.name});

  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  ExampleModel copyWith({String? id, String? name}) {
    return ExampleModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
```

### 4. State Management

The app uses Provider for state management. To create a new service:

```dart
import 'package:flutter/foundation.dart';

class ExampleService extends ChangeNotifier {
  List<Item> _items = [];
  
  List<Item> get items => _items;
  
  Future<void> loadItems() async {
    // Load items
    _items = await fetchItems();
    notifyListeners(); // Notify listeners to rebuild
  }
}
```

Register in `main.dart`:
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthService()),
    ChangeNotifierProvider(create: (_) => ExampleService()), // Add here
  ],
  child: MyApp(),
)
```

### 5. API Integration

See `API_INTEGRATION.md` for detailed instructions.

Basic pattern:
```dart
Future<List<Item>> fetchItems() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/items'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList();
    }
    throw Exception('Failed to load items');
  } catch (e) {
    debugPrint('Error: $e');
    rethrow;
  }
}
```

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models_test.dart

# Run tests with coverage
flutter test --coverage
```

### Writing Tests

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Description', () {
    test('should do something', () {
      // Arrange
      final value = 42;
      
      // Act
      final result = value * 2;
      
      // Assert
      expect(result, 84);
    });
  });
}
```

### Widget Tests

```dart
testWidgets('Widget test example', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  expect(find.text('Login'), findsOneWidget);
  
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();
  
  expect(find.text('Dashboard'), findsOneWidget);
});
```

## Code Quality

### Linting

The project uses `flutter_lints`. Run:
```bash
flutter analyze
```

Fix issues before committing.

### Formatting

```bash
# Format all files
dart format .

# Format specific file
dart format lib/main.dart

# Check formatting without changing files
dart format --set-exit-if-changed .
```

### Pre-commit Checklist

- [ ] Run `flutter analyze` and fix issues
- [ ] Run `dart format .`
- [ ] Run `flutter test` and ensure all tests pass
- [ ] Test on both iOS and Android if possible
- [ ] Update documentation if needed

## Debugging

### Debug Mode

```bash
flutter run --debug
```

### DevTools

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### Logging

Use `debugPrint` instead of `print`:
```dart
debugPrint('Debug message: $value');
```

### Common Issues

**Issue: Hot reload not working**
- Try hot restart: Press `R` in terminal or use IDE button
- If still not working, stop and restart app

**Issue: Dependencies not resolving**
```bash
flutter pub get
flutter clean
flutter pub get
```

**Issue: Build errors after pulling changes**
```bash
flutter clean
flutter pub get
flutter run
```

## Building for Release

### Android APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APKs by ABI (smaller file size)
flutter build apk --split-per-abi
```

Output: `build/app/outputs/flutter-apk/`

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/`

### iOS

```bash
# Make sure you're on a Mac with Xcode installed
flutter build ios --release

# Or open in Xcode
open ios/Runner.xcworkspace
```

## Useful Commands

```bash
# Update dependencies
flutter pub upgrade

# Clean build
flutter clean

# Check for outdated packages
flutter pub outdated

# Generate app icon
flutter pub run flutter_launcher_icons:main

# Generate splash screen
flutter pub run flutter_native_splash:create

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test

# Check dependencies
flutter pub deps
```

## Tips and Best Practices

1. **Use const constructors** whenever possible for better performance
2. **Extract widgets** - Keep widgets small and focused
3. **Handle async properly** - Always check if widget is still mounted
4. **Use meaningful names** - Variables, functions, and classes
5. **Comment complex logic** - Make it easy for others to understand
6. **Test edge cases** - Null values, empty lists, errors, etc.
7. **Handle errors gracefully** - Show user-friendly messages
8. **Keep screens focused** - One screen, one responsibility
9. **Use StatelessWidget** when possible - Better performance
10. **Follow Flutter naming conventions** - See style guide

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design Guidelines](https://material.io/design)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Performance Best Practices](https://flutter.dev/docs/perf/best-practices)

## Getting Help

- Check existing issues in the repository
- Create a new issue with detailed description
- Ask in Flutter Discord/Slack communities
- Stack Overflow with `flutter` tag

## Version Control

### Branching Strategy

- `main` - Production-ready code
- `develop` - Development branch
- `feature/feature-name` - Feature branches
- `bugfix/bug-description` - Bug fix branches
- `hotfix/critical-fix` - Critical production fixes

### Commit Messages

Follow conventional commits:
```
feat: add product search functionality
fix: resolve login authentication issue
docs: update API integration guide
style: format authentication service
refactor: simplify order status logic
test: add tests for product model
```

---

Happy coding! 🚀
