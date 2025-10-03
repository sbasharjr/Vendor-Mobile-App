# API Configuration Guide

This document outlines the API endpoints that need to be integrated with the MyGetWell backend API.

## Base Configuration

Create a file `lib/config/api_config.dart`:

```dart
class ApiConfig {
  // Replace with actual API base URL
  static const String baseUrl = 'https://api.mygetwell.app';
  
  // API Endpoints
  static const String loginEndpoint = '/api/vendor/login';
  static const String registerEndpoint = '/api/vendor/register';
  static const String forgotPasswordEndpoint = '/api/vendor/forgot-password';
  static const String refreshTokenEndpoint = '/api/vendor/refresh-token';
  
  // Products
  static const String productsEndpoint = '/api/vendor/products';
  static const String productsCreateEndpoint = '/api/vendor/products/create';
  static String productUpdateEndpoint(String id) => '/api/vendor/products/$id';
  static String productDeleteEndpoint(String id) => '/api/vendor/products/$id';
  
  // Orders
  static const String ordersEndpoint = '/api/vendor/orders';
  static String orderDetailsEndpoint(String id) => '/api/vendor/orders/$id';
  static String orderUpdateStatusEndpoint(String id) => '/api/vendor/orders/$id/status';
  
  // Profile
  static const String profileEndpoint = '/api/vendor/profile';
  static const String profileUpdateEndpoint = '/api/vendor/profile/update';
  static const String changePasswordEndpoint = '/api/vendor/change-password';
  
  // Dashboard
  static const String dashboardStatsEndpoint = '/api/vendor/dashboard/stats';
}
```

## API Service Implementation

Create a file `lib/services/api_service.dart`:

```dart
import 'package:dio/dio.dart';
import '../config/api_config.dart';

class ApiService {
  late Dio _dio;
  String? _authToken;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors for request/response logging and error handling
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_authToken != null) {
          options.headers['Authorization'] = 'Bearer $_authToken';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        // Handle errors globally
        return handler.next(error);
      },
    ));
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}
```

## Integration Checklist

### Authentication Service (`lib/services/auth_service.dart`)
- [ ] Replace mock login with actual API call to `POST /api/vendor/login`
- [ ] Replace mock register with actual API call to `POST /api/vendor/register`
- [ ] Replace mock forgot password with actual API call to `POST /api/vendor/forgot-password`
- [ ] Implement token refresh logic
- [ ] Add proper error handling and validation

### Product Service (Create `lib/services/product_service.dart`)
- [ ] Implement `fetchProducts()` - `GET /api/vendor/products`
- [ ] Implement `createProduct(Product product)` - `POST /api/vendor/products/create`
- [ ] Implement `updateProduct(String id, Product product)` - `PUT /api/vendor/products/:id`
- [ ] Implement `deleteProduct(String id)` - `DELETE /api/vendor/products/:id`
- [ ] Implement `uploadProductImage(File image)` - Handle image uploads

### Order Service (Create `lib/services/order_service.dart`)
- [ ] Implement `fetchOrders({OrderStatus? status})` - `GET /api/vendor/orders`
- [ ] Implement `fetchOrderDetails(String id)` - `GET /api/vendor/orders/:id`
- [ ] Implement `updateOrderStatus(String id, OrderStatus status)` - `PUT /api/vendor/orders/:id/status`

### Dashboard Service (Create `lib/services/dashboard_service.dart`)
- [ ] Implement `fetchDashboardStats()` - `GET /api/vendor/dashboard/stats`
- [ ] Implement real-time stats updates

### Profile Service (Create `lib/services/profile_service.dart`)
- [ ] Implement `fetchProfile()` - `GET /api/vendor/profile`
- [ ] Implement `updateProfile(Vendor vendor)` - `PUT /api/vendor/profile/update`
- [ ] Implement `changePassword(String old, String new)` - `POST /api/vendor/change-password`
- [ ] Implement `uploadProfileImage(File image)` - Handle profile image uploads

## Expected API Response Formats

### Login Response
```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "vendor": {
      "id": "vendor_123",
      "name": "John Doe",
      "email": "john@example.com",
      "store_name": "John's Store",
      "phone": "+1234567890",
      "is_verified": true
    }
  }
}
```

### Products List Response
```json
{
  "success": true,
  "data": {
    "products": [
      {
        "id": "prod_1",
        "vendor_id": "vendor_123",
        "name": "Product Name",
        "description": "Product description",
        "price": 19.99,
        "stock": 100,
        "category": "Category Name",
        "images": ["url1", "url2"],
        "is_active": true,
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "per_page": 20,
      "total": 100
    }
  }
}
```

### Orders List Response
```json
{
  "success": true,
  "data": {
    "orders": [
      {
        "id": "order_1",
        "vendor_id": "vendor_123",
        "customer_id": "customer_1",
        "customer_name": "Jane Smith",
        "customer_email": "jane@example.com",
        "items": [
          {
            "product_id": "prod_1",
            "product_name": "Product Name",
            "quantity": 2,
            "price": 19.99,
            "total": 39.98
          }
        ],
        "subtotal": 39.98,
        "tax": 3.99,
        "delivery_fee": 5.00,
        "total": 48.97,
        "status": "pending",
        "delivery_address": "123 Main St, City, State 12345",
        "notes": "Leave at door",
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ]
  }
}
```

### Dashboard Stats Response
```json
{
  "success": true,
  "data": {
    "total_orders": 127,
    "revenue": 2543.50,
    "total_products": 42,
    "pending_orders": 5,
    "recent_orders": [...],
    "low_stock_products": [...]
  }
}
```

## Error Handling

All API responses should follow this error format:

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": {}
  }
}
```

## Security Considerations

1. **Token Storage**: Tokens are currently stored in SharedPreferences. Consider using flutter_secure_storage for production.
2. **Token Refresh**: Implement automatic token refresh before expiration.
3. **SSL Pinning**: Consider implementing SSL pinning for production builds.
4. **Input Validation**: Validate all user inputs before sending to API.
5. **Rate Limiting**: Handle API rate limiting gracefully.

## Testing

1. Test all API endpoints with Postman or similar tools
2. Mock API responses for unit tests
3. Implement integration tests for critical flows
4. Test offline scenarios and error handling

## Environment Configuration

Create different configuration files for different environments:
- Development: `lib/config/env/dev.dart`
- Staging: `lib/config/env/staging.dart`
- Production: `lib/config/env/prod.dart`

Use Flutter build flavors to switch between environments.
