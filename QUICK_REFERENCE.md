# Quick Reference Guide

Quick commands and tips for working with the MyGetWell Vendor Mobile App.

## Installation & Setup

```bash
# Clone repository
git clone https://github.com/sbasharjr/Vendor-Mobile-App.git
cd Vendor-Mobile-App

# Install dependencies
flutter pub get

# Run app
flutter run
```

## Common Commands

### Running the App
```bash
flutter run                    # Run in debug mode
flutter run --release          # Run in release mode
flutter run -d <device-id>     # Run on specific device
```

### Building
```bash
flutter build apk              # Build Android APK
flutter build appbundle        # Build Android App Bundle
flutter build ios              # Build iOS app
```

### Testing
```bash
flutter test                   # Run all tests
flutter test test/models_test.dart  # Run specific test
flutter test --coverage        # Run with coverage
```

### Code Quality
```bash
flutter analyze                # Analyze code
dart format .                  # Format code
flutter clean                  # Clean build
```

## File Structure Quick Reference

```
lib/
├── config/theme.dart          # Theme configuration
├── main.dart                  # App entry point
├── models/                    # Data models
│   ├── order.dart
│   ├── product.dart
│   └── vendor.dart
├── screens/                   # UI screens
│   ├── auth/                  # Authentication screens
│   ├── dashboard/             # Dashboard screen
│   ├── orders/                # Order screens
│   ├── products/              # Product screens
│   └── profile/               # Profile & settings
├── services/                  # Business logic
│   └── auth_service.dart
└── widgets/                   # Reusable widgets
    └── stat_card.dart
```

## Adding a New Screen

1. Create screen file:
```dart
// lib/screens/example/example_screen.dart
import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: const Center(child: Text('Hello')),
    );
  }
}
```

2. Add route in `lib/main.dart`:
```dart
GoRoute(
  path: '/example',
  builder: (context, state) => const ExampleScreen(),
),
```

3. Navigate to it:
```dart
context.go('/example');
```

## Adding a New Model

```dart
// lib/models/example.dart
class Example {
  final String id;
  final String name;

  Example({required this.id, required this.name});

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
```

## Using Provider

### Create Service
```dart
// lib/services/example_service.dart
import 'package:flutter/foundation.dart';

class ExampleService extends ChangeNotifier {
  List<Item> _items = [];
  
  List<Item> get items => _items;
  
  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }
}
```

### Register Provider
```dart
// In lib/main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ExampleService()),
  ],
  child: MyApp(),
)
```

### Use in Widget
```dart
// Read value
final items = context.watch<ExampleService>().items;

// Call method
context.read<ExampleService>().addItem(newItem);
```

## Common Widgets

### Button
```dart
ElevatedButton(
  onPressed: () {},
  child: const Text('Click Me'),
)
```

### Text Field
```dart
TextFormField(
  decoration: const InputDecoration(
    labelText: 'Email',
    prefixIcon: Icon(Icons.email),
  ),
  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
)
```

### List
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index].name),
    );
  },
)
```

### Card
```dart
Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Text('Content'),
  ),
)
```

## Navigation

```dart
// Push named route
context.go('/products');

// Push with parameters
context.go('/products/edit/${productId}');

// Go back
context.pop();

// Replace current route
context.replace('/dashboard');
```

## API Calls (Template)

```dart
Future<List<Item>> fetchItems() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/items'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['items'] as List)
          .map((json) => Item.fromJson(json))
          .toList();
    }
    throw Exception('Failed to load');
  } catch (e) {
    debugPrint('Error: $e');
    rethrow;
  }
}
```

## Error Handling

```dart
try {
  await someAsyncFunction();
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Success!'),
        backgroundColor: Colors.green,
      ),
    );
  }
} catch (e) {
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
```

## Form Validation

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Required';
          if (!value!.contains('@')) return 'Invalid email';
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Process form
          }
        },
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

## Theme Usage

```dart
// Get theme
final theme = Theme.of(context);

// Use theme colors
color: theme.primaryColor,
color: theme.colorScheme.secondary,

// Use theme text styles
style: theme.textTheme.headlineMedium,
```

## Debugging

```dart
// Print debug messages
debugPrint('Value: $value');

// Assert in debug mode
assert(value != null, 'Value cannot be null');

// Check if widget is mounted
if (mounted) {
  setState(() {});
}
```

## Asset Usage

```yaml
# In pubspec.yaml
flutter:
  assets:
    - assets/images/logo.png
    - assets/icons/
```

```dart
// In code
Image.asset('assets/images/logo.png')
```

## Device Info

```dart
// Get screen size
final size = MediaQuery.of(context).size;
final width = size.width;
final height = size.height;

// Get platform
final isAndroid = Theme.of(context).platform == TargetPlatform.android;
final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
```

## Useful Shortcuts

### VS Code
- `Ctrl + .` - Quick fixes
- `Ctrl + Space` - Auto-complete
- `Shift + Alt + F` - Format document
- `F5` - Start debugging
- `Shift + F5` - Stop debugging

### Android Studio
- `Alt + Enter` - Quick fixes
- `Ctrl + Space` - Auto-complete
- `Ctrl + Alt + L` - Format code
- `Shift + F10` - Run
- `Shift + F9` - Debug

## Troubleshooting

### Issue: Dependencies not resolving
```bash
flutter clean
flutter pub get
```

### Issue: Build errors
```bash
flutter clean
cd android && ./gradlew clean && cd ..
flutter pub get
flutter run
```

### Issue: Hot reload not working
- Press `R` for hot restart
- Or stop and restart app

### Issue: Module not found
```bash
flutter pub get
```

## Performance Tips

1. Use `const` constructors
2. Extract widgets to separate classes
3. Use `ListView.builder` for long lists
4. Cache network images
5. Avoid unnecessary rebuilds
6. Use `setState` only when needed

## Best Practices

1. Always check `mounted` before calling `setState`
2. Dispose controllers in `dispose()`
3. Use meaningful variable names
4. Keep widgets small and focused
5. Handle errors gracefully
6. Add loading indicators
7. Provide user feedback
8. Test on real devices
9. Check for null values
10. Follow Flutter style guide

## Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [pub.dev](https://pub.dev) - Flutter packages
- [Material Icons](https://fonts.google.com/icons)
- [Flutter Gallery](https://gallery.flutter.dev)

---

Keep this guide handy for quick reference while developing!
