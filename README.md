# MyGetWell Vendor Mobile App

A comprehensive Flutter-based mobile application for vendors on the MyGetWell platform (https://mygetwell.app). This app allows vendors to manage their products, track orders, and handle their online store operations on the go.

## Features

### Authentication & Security
- ✅ Secure login and registration
- ✅ Password reset functionality
- ✅ Session management with local storage
- ✅ Protected routes and authentication guards

### Dashboard
- ✅ Overview of key metrics (orders, revenue, products)
- ✅ Quick action buttons for common tasks
- ✅ Real-time statistics display
- ✅ Intuitive navigation drawer

### Product Management
- ✅ View all products with filtering
- ✅ Add new products with images
- ✅ Edit existing products
- ✅ Manage product inventory (stock tracking)
- ✅ Toggle product active/inactive status
- ✅ Product categorization

### Order Management
- ✅ View all orders with status filtering
- ✅ Order details with customer information
- ✅ Update order status (Pending → Confirmed → Processing → Ready → Shipped → Delivered)
- ✅ Order timeline and history
- ✅ Customer contact information

### Profile & Settings
- ✅ View and edit vendor profile
- ✅ Manage store information
- ✅ Notification preferences
- ✅ App preferences (language, currency)
- ✅ Theme customization
- ✅ Secure logout

## Tech Stack

- **Framework:** Flutter 3.x
- **Language:** Dart
- **State Management:** Provider
- **Navigation:** GoRouter
- **UI/UX:** Material Design 3 with Google Fonts
- **Local Storage:** SharedPreferences
- **HTTP Client:** Dio
- **Image Handling:** Image Picker, Cached Network Image

## Project Structure

```
lib/
├── config/
│   └── theme.dart              # App theme configuration
├── models/
│   ├── vendor.dart             # Vendor data model
│   ├── product.dart            # Product data model
│   └── order.dart              # Order data model
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── forgot_password_screen.dart
│   ├── dashboard/
│   │   └── dashboard_screen.dart
│   ├── products/
│   │   ├── products_list_screen.dart
│   │   └── product_add_edit_screen.dart
│   ├── orders/
│   │   ├── orders_list_screen.dart
│   │   └── order_details_screen.dart
│   └── profile/
│       ├── profile_screen.dart
│       └── settings_screen.dart
├── services/
│   └── auth_service.dart       # Authentication service
├── widgets/
│   └── stat_card.dart          # Reusable stat card widget
└── main.dart                   # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode for mobile development
- VS Code or Android Studio with Flutter plugins

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/sbasharjr/Vendor-Mobile-App.git
   cd Vendor-Mobile-App
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # Run on connected device or emulator
   flutter run
   
   # Run on specific device
   flutter run -d <device-id>
   
   # Run in release mode
   flutter run --release
   ```

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle (recommended for Play Store):**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## Configuration

### API Integration

The app is designed to integrate with the MyGetWell API. To configure:

1. Update the base API URL in the respective service files
2. Configure authentication endpoints
3. Set up proper API keys and tokens

Currently, the app uses mock data for demonstration purposes. Replace the mock implementations in service files with actual API calls:

- `lib/services/auth_service.dart` - Authentication endpoints
- Product management endpoints (to be added)
- Order management endpoints (to be added)

### App Identifiers

- **Android Package Name:** com.mygetwell.vendor
- **iOS Bundle Identifier:** com.mygetwell.vendor
- **App Name:** MyGetWell Vendor

## Features Roadmap

### Upcoming Features
- [ ] Analytics dashboard with charts
- [ ] Real-time notifications
- [ ] Chat support with customers
- [ ] Inventory low-stock alerts
- [ ] Sales reports and exports
- [ ] Multi-language support
- [ ] Dark mode
- [ ] Barcode scanning for products
- [ ] Bulk product upload
- [ ] Payment tracking

## Testing

Run tests with:
```bash
flutter test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is part of the MyGetWell platform.

## Support

For support and queries:
- Website: https://mygetwell.app
- Create an issue in this repository

## Screenshots

*(Screenshots will be added after UI testing)*

---

**Built with ❤️ using Flutter**