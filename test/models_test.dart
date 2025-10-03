import 'package:flutter_test/flutter_test.dart';
import 'package:vendor_mobile_app/models/vendor.dart';
import 'package:vendor_mobile_app/models/product.dart';
import 'package:vendor_mobile_app/models/order.dart';

void main() {
  group('Vendor Model Tests', () {
    test('Vendor model serialization', () {
      final vendor = Vendor(
        id: '1',
        name: 'Test Vendor',
        email: 'test@example.com',
        token: 'test_token',
        storeName: 'Test Store',
      );

      final json = vendor.toJson();
      final vendorFromJson = Vendor.fromJson(json);

      expect(vendorFromJson.id, vendor.id);
      expect(vendorFromJson.name, vendor.name);
      expect(vendorFromJson.email, vendor.email);
      expect(vendorFromJson.storeName, vendor.storeName);
    });
  });

  group('Product Model Tests', () {
    test('Product model serialization', () {
      final product = Product(
        id: '1',
        vendorId: 'vendor1',
        name: 'Test Product',
        description: 'Test Description',
        price: 19.99,
        stock: 10,
        category: 'Test Category',
      );

      final json = product.toJson();
      final productFromJson = Product.fromJson(json);

      expect(productFromJson.id, product.id);
      expect(productFromJson.name, product.name);
      expect(productFromJson.price, product.price);
      expect(productFromJson.stock, product.stock);
    });

    test('Product copyWith method', () {
      final product = Product(
        id: '1',
        vendorId: 'vendor1',
        name: 'Test Product',
        description: 'Test Description',
        price: 19.99,
        stock: 10,
      );

      final updated = product.copyWith(
        name: 'Updated Product',
        price: 29.99,
      );

      expect(updated.name, 'Updated Product');
      expect(updated.price, 29.99);
      expect(updated.id, product.id);
      expect(updated.stock, product.stock);
    });
  });

  group('Order Model Tests', () {
    test('Order model serialization', () {
      final order = Order(
        id: '1',
        vendorId: 'vendor1',
        customerId: 'customer1',
        customerName: 'John Doe',
        customerEmail: 'john@example.com',
        items: [
          OrderItem(
            productId: '1',
            productName: 'Test Product',
            quantity: 2,
            price: 10.00,
            total: 20.00,
          ),
        ],
        subtotal: 20.00,
        tax: 2.00,
        deliveryFee: 5.00,
        total: 27.00,
        status: OrderStatus.pending,
        createdAt: DateTime.now(),
      );

      final json = order.toJson();
      final orderFromJson = Order.fromJson(json);

      expect(orderFromJson.id, order.id);
      expect(orderFromJson.customerName, order.customerName);
      expect(orderFromJson.total, order.total);
      expect(orderFromJson.items.length, order.items.length);
    });

    test('OrderStatus from string', () {
      expect(OrderStatus.fromString('pending'), OrderStatus.pending);
      expect(OrderStatus.fromString('confirmed'), OrderStatus.confirmed);
      expect(OrderStatus.fromString('delivered'), OrderStatus.delivered);
      expect(OrderStatus.fromString('invalid'), OrderStatus.pending);
    });

    test('OrderStatus display name', () {
      expect(OrderStatus.pending.displayName, 'Pending');
      expect(OrderStatus.confirmed.displayName, 'Confirmed');
      expect(OrderStatus.delivered.displayName, 'Delivered');
    });
  });
}
