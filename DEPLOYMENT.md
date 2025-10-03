# Deployment Guide

This guide covers deploying the MyGetWell Vendor Mobile App to Google Play Store and Apple App Store.

## Prerequisites

### For Android (Google Play Store)
- Google Play Console account ($25 one-time fee)
- Android Studio installed
- Java Development Kit (JDK) 8 or higher
- Keystore for app signing

### For iOS (Apple App Store)
- Apple Developer account ($99/year)
- macOS with Xcode installed
- Valid iOS distribution certificate
- Valid provisioning profile

## Android Deployment

### 1. Create a Keystore

```bash
keytool -genkey -v -keystore ~/mygetwell-vendor.jks -keyalg RSA -keysize 2048 -validity 10000 -alias mygetwell-vendor
```

**Important:** Keep the keystore file and passwords secure!

### 2. Configure Signing

Create `android/key.properties`:
```properties
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=mygetwell-vendor
storeFile=<location-of-the-key-store-file>
```

Update `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### 3. Update App Information

**android/app/src/main/AndroidManifest.xml:**
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="MyGetWell Vendor"
        android:icon="@mipmap/ic_launcher">
        <!-- ... -->
    </application>
</manifest>
```

**android/app/build.gradle:**
```gradle
android {
    defaultConfig {
        applicationId "com.mygetwell.vendor"
        versionCode 1
        versionName "1.0.0"
    }
}
```

### 4. Build Release APK/Bundle

```bash
# For APK
flutter build apk --release

# For App Bundle (recommended)
flutter build appbundle --release
```

Output locations:
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- Bundle: `build/app/outputs/bundle/release/app-release.aab`

### 5. Upload to Google Play Console

1. Go to [Google Play Console](https://play.google.com/console)
2. Create new application
3. Fill in store listing information
4. Upload app bundle (.aab file)
5. Complete content rating questionnaire
6. Set pricing and distribution
7. Submit for review

### Store Listing Information

**App Name:** MyGetWell Vendor

**Short Description:**
Manage your MyGetWell store on the go - products, orders, and more!

**Full Description:**
MyGetWell Vendor is a comprehensive mobile application for vendors on the MyGetWell platform. Easily manage your online store, track orders, update product inventory, and communicate with customers - all from your mobile device.

Key Features:
• Product Management - Add, edit, and manage your product catalog
• Order Tracking - View and update order statuses in real-time
• Dashboard Analytics - Monitor your store's performance
• Inventory Management - Keep track of stock levels
• Customer Communication - Access customer information and orders
• Profile Management - Update your store information and settings

Perfect for health and wellness vendors who want to manage their business efficiently from anywhere.

**Category:** Business

**Screenshots:** (Prepare 8 screenshots showing different features)

**Privacy Policy URL:** https://mygetwell.app/vendor-privacy-policy

## iOS Deployment

### 1. Configure App in Xcode

```bash
open ios/Runner.xcworkspace
```

In Xcode:
1. Select Runner in project navigator
2. Update **Display Name**: MyGetWell Vendor
3. Update **Bundle Identifier**: com.mygetwell.vendor
4. Set **Version**: 1.0.0
5. Set **Build**: 1

### 2. Configure Signing

In Xcode:
1. Select Runner target
2. Go to **Signing & Capabilities**
3. Check **Automatically manage signing**
4. Select your team
5. Ensure provisioning profile is valid

### 3. Update Info.plist

Add required privacy descriptions in `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to upload product images</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to select product images</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access for delivery tracking</string>
```

### 4. Build iOS App

```bash
flutter build ios --release
```

### 5. Archive and Upload

1. Open Xcode workspace
2. Select **Product > Archive**
3. Once archived, click **Distribute App**
4. Select **App Store Connect**
5. Follow the upload wizard
6. Upload to App Store Connect

### 6. App Store Connect Configuration

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Create new app
3. Fill in app information:
   - App Name: MyGetWell Vendor
   - Primary Language: English
   - Bundle ID: com.mygetwell.vendor
   - SKU: mygetwell-vendor-app

4. App Information:
   - Privacy Policy URL
   - Category: Business
   - Content Rights

5. Pricing and Availability:
   - Free
   - Available in all territories

6. Prepare for Submission:
   - Screenshots (required for all device types)
   - App Preview videos (optional)
   - Description
   - Keywords
   - Support URL
   - Marketing URL

7. Submit for Review

### Store Information

**App Name:** MyGetWell Vendor

**Subtitle:** Manage Your Wellness Store

**Description:**
Take control of your MyGetWell store with our powerful vendor mobile app. Built for health and wellness vendors, this app provides all the tools you need to manage your business on the go.

PRODUCT MANAGEMENT
• Add new products with descriptions and images
• Update pricing and inventory in real-time
• Organize products by categories
• Toggle product availability instantly

ORDER MANAGEMENT
• View all incoming orders
• Track order status from pending to delivered
• Update customers on order progress
• Access detailed order information

DASHBOARD ANALYTICS
• Monitor total orders and revenue
• Track pending orders
• View product performance
• Get insights into your business

PROFILE & SETTINGS
• Manage your vendor profile
• Update store information
• Customize notification preferences
• Configure app settings

Whether you're selling supplements, wellness products, healthy foods, or services, MyGetWell Vendor gives you the flexibility to manage your business from anywhere.

**Keywords:** 
vendor, seller, store management, e-commerce, business, orders, products, inventory, wellness, health

**Screenshots:** 
- Login Screen
- Dashboard
- Product List
- Add Product
- Order List
- Order Details
- Profile
- Settings

## Pre-Launch Checklist

### Testing
- [ ] Test on physical Android device
- [ ] Test on physical iOS device
- [ ] Test all major user flows
- [ ] Test with poor network conditions
- [ ] Test with different screen sizes
- [ ] Verify all forms and validation
- [ ] Check error handling
- [ ] Test deep linking
- [ ] Verify push notifications
- [ ] Test app performance

### App Store Requirements
- [ ] Privacy policy page created
- [ ] Terms of service page created
- [ ] Support email/contact set up
- [ ] App icon created (1024x1024 for iOS, multiple sizes for Android)
- [ ] Screenshots prepared (all required sizes)
- [ ] App description proofread
- [ ] Keywords researched and optimized
- [ ] Rating content completed
- [ ] Store listing preview checked

### Technical
- [ ] Remove all debug code
- [ ] Remove all console logs
- [ ] API endpoints configured for production
- [ ] Error tracking configured (e.g., Sentry, Firebase Crashlytics)
- [ ] Analytics configured (e.g., Firebase Analytics)
- [ ] App signing configured
- [ ] Obfuscation enabled
- [ ] Icon and splash screen finalized

### Legal & Compliance
- [ ] Privacy policy compliant with GDPR
- [ ] Privacy policy compliant with CCPA
- [ ] Terms of service reviewed
- [ ] App permissions justified
- [ ] Third-party licenses included
- [ ] Copyright notices added

## Post-Launch

### Monitoring
- Set up crash reporting (Firebase Crashlytics)
- Configure analytics (Firebase Analytics, Mixpanel)
- Monitor app reviews and ratings
- Track download numbers
- Monitor server load and API performance

### Updates
- Plan regular update cycle
- Collect user feedback
- Fix critical bugs immediately
- Add new features based on feedback
- Keep dependencies updated
- Test updates thoroughly before release

### Version Updates

To release an update:

1. Update version in `pubspec.yaml`:
```yaml
version: 1.1.0+2  # version+build number
```

2. Update version in platform files:
   - Android: `android/app/build.gradle`
   - iOS: Xcode project settings

3. Build and test

4. Follow the same upload process

5. Describe what's new in release notes

## App Review Guidelines

### Apple App Store
- Apps must not crash or have bugs
- Must comply with Human Interface Guidelines
- Accurate descriptions and screenshots
- Must not access private data without permission
- Must provide value to users

### Google Play Store
- Apps must be stable and functional
- Must follow Material Design guidelines
- Accurate metadata and descriptions
- Must comply with privacy and security policies
- Must not contain malicious code

## Common Rejection Reasons

1. **Crashes or bugs** - Test thoroughly
2. **Incomplete information** - Fill all required fields
3. **Misleading content** - Accurate descriptions
4. **Privacy issues** - Clear privacy policy
5. **Performance issues** - Optimize app
6. **Design issues** - Follow platform guidelines

## Support & Maintenance

### User Support
- Set up support email: vendor-support@mygetwell.app
- Create FAQ page
- Provide in-app help
- Monitor app reviews
- Respond to user feedback

### Maintenance Schedule
- Weekly: Monitor crashes and errors
- Monthly: Update dependencies
- Quarterly: Performance optimization
- As needed: Bug fixes and security patches

## Helpful Links

### Android
- [Google Play Console](https://play.google.com/console)
- [Android App Bundle Guide](https://developer.android.com/guide/app-bundle)
- [Play Store Guidelines](https://play.google.com/about/developer-content-policy/)

### iOS
- [App Store Connect](https://appstoreconnect.apple.com)
- [iOS App Distribution Guide](https://developer.apple.com/ios/submit/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

### Tools
- [Firebase Console](https://console.firebase.google.com)
- [App Icon Generator](https://appicon.co)
- [Screenshot Generator](https://www.appstorescreenshot.com)

---

Good luck with your app launch! 🚀
