import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'config/theme.dart';
import 'services/auth_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/products/products_list_screen.dart';
import 'screens/products/product_add_edit_screen.dart';
import 'screens/orders/orders_list_screen.dart';
import 'screens/orders/order_details_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/settings_screen.dart';

void main() {
  runApp(const VendorApp());
}

class VendorApp extends StatelessWidget {
  const VendorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: Consumer<AuthService>(
        builder: (context, authService, _) {
          final router = GoRouter(
            initialLocation: authService.isAuthenticated ? '/dashboard' : '/login',
            redirect: (context, state) {
              final isAuthenticated = authService.isAuthenticated;
              final isAuthRoute = state.matchedLocation.startsWith('/login') ||
                  state.matchedLocation.startsWith('/register') ||
                  state.matchedLocation.startsWith('/forgot-password');

              if (!isAuthenticated && !isAuthRoute) {
                return '/login';
              }
              if (isAuthenticated && isAuthRoute) {
                return '/dashboard';
              }
              return null;
            },
            routes: [
              GoRoute(
                path: '/login',
                builder: (context, state) => const LoginScreen(),
              ),
              GoRoute(
                path: '/register',
                builder: (context, state) => const RegisterScreen(),
              ),
              GoRoute(
                path: '/forgot-password',
                builder: (context, state) => const ForgotPasswordScreen(),
              ),
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
              GoRoute(
                path: '/products',
                builder: (context, state) => const ProductsListScreen(),
              ),
              GoRoute(
                path: '/products/add',
                builder: (context, state) => const ProductAddEditScreen(),
              ),
              GoRoute(
                path: '/products/edit/:id',
                builder: (context, state) => ProductAddEditScreen(
                  productId: state.pathParameters['id'],
                ),
              ),
              GoRoute(
                path: '/orders',
                builder: (context, state) => const OrdersListScreen(),
              ),
              GoRoute(
                path: '/orders/:id',
                builder: (context, state) => OrderDetailsScreen(
                  orderId: state.pathParameters['id']!,
                ),
              ),
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          );

          return MaterialApp.router(
            title: 'MyGetWell Vendor',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
