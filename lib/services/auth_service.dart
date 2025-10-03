import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/vendor.dart';

class AuthService extends ChangeNotifier {
  Vendor? _currentVendor;
  bool _isAuthenticated = false;

  Vendor? get currentVendor => _currentVendor;
  bool get isAuthenticated => _isAuthenticated;

  AuthService() {
    _loadVendorFromStorage();
  }

  Future<void> _loadVendorFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final vendorId = prefs.getString('vendor_id');
      final vendorName = prefs.getString('vendor_name');
      final vendorEmail = prefs.getString('vendor_email');

      if (token != null && vendorId != null) {
        _currentVendor = Vendor(
          id: vendorId,
          name: vendorName ?? '',
          email: vendorEmail ?? '',
          token: token,
        );
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading vendor from storage: $e');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      // TODO: Replace with actual API call to mygetwell.app
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // For demo purposes, accept any email/password
      final vendor = Vendor(
        id: 'vendor_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Demo Vendor',
        email: email,
        token: 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
        phone: '+1234567890',
        storeName: 'My GetWell Store',
      );

      await _saveVendorToStorage(vendor);
      _currentVendor = vendor;
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  Future<bool> register(String name, String email, String password, String storeName) async {
    try {
      // TODO: Replace with actual API call to mygetwell.app
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      final vendor = Vendor(
        id: 'vendor_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        token: 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
        storeName: storeName,
      );

      await _saveVendorToStorage(vendor);
      _currentVendor = vendor;
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Register error: $e');
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      // TODO: Replace with actual API call to mygetwell.app
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      return true;
    } catch (e) {
      debugPrint('Forgot password error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _currentVendor = null;
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  Future<void> _saveVendorToStorage(Vendor vendor) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', vendor.token);
      await prefs.setString('vendor_id', vendor.id);
      await prefs.setString('vendor_name', vendor.name);
      await prefs.setString('vendor_email', vendor.email);
    } catch (e) {
      debugPrint('Error saving vendor to storage: $e');
    }
  }
}
