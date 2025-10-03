import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../models/order.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  List<Order> _orders = [];
  bool _isLoading = false;
  OrderStatus? _filterStatus;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);

    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));

    // Demo orders
    _orders = [
      Order(
        id: '1',
        vendorId: 'vendor1',
        customerId: 'customer1',
        customerName: 'John Doe',
        customerEmail: 'john@example.com',
        items: [
          OrderItem(
            productId: '1',
            productName: 'Wellness Tea',
            quantity: 2,
            price: 12.99,
            total: 25.98,
          ),
        ],
        subtotal: 25.98,
        tax: 2.60,
        deliveryFee: 5.00,
        total: 33.58,
        status: OrderStatus.pending,
        deliveryAddress: '123 Main St, City, State 12345',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Order(
        id: '2',
        vendorId: 'vendor1',
        customerId: 'customer2',
        customerName: 'Jane Smith',
        customerEmail: 'jane@example.com',
        items: [
          OrderItem(
            productId: '2',
            productName: 'Vitamin C Supplements',
            quantity: 1,
            price: 24.99,
            total: 24.99,
          ),
        ],
        subtotal: 24.99,
        tax: 2.50,
        deliveryFee: 5.00,
        total: 32.49,
        status: OrderStatus.processing,
        deliveryAddress: '456 Oak Ave, City, State 12345',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Order(
        id: '3',
        vendorId: 'vendor1',
        customerId: 'customer3',
        customerName: 'Bob Johnson',
        customerEmail: 'bob@example.com',
        items: [
          OrderItem(
            productId: '3',
            productName: 'Yoga Mat',
            quantity: 1,
            price: 39.99,
            total: 39.99,
          ),
        ],
        subtotal: 39.99,
        tax: 4.00,
        deliveryFee: 5.00,
        total: 48.99,
        status: OrderStatus.delivered,
        deliveryAddress: '789 Pine Rd, City, State 12345',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];

    setState(() => _isLoading = false);
  }

  List<Order> get filteredOrders {
    if (_filterStatus == null) {
      return _orders;
    }
    return _orders.where((order) => order.status == _filterStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          PopupMenuButton<OrderStatus?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (status) {
              setState(() => _filterStatus = status);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All Orders'),
              ),
              ...OrderStatus.values.map((status) => PopupMenuItem(
                    value: status,
                    child: Text(status.displayName),
                  )),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredOrders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _filterStatus == null
                            ? 'No orders yet'
                            : 'No ${_filterStatus!.displayName.toLowerCase()} orders',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadOrders,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () => context.go('/orders/${order.id}'),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order #${order.id}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    _buildStatusChip(order.status),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  order.customerName,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat('MMM dd, yyyy - hh:mm a')
                                      .format(order.createdAt),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Divider(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${order.items.length} item(s)',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(
                                      '\$${order.total.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color color;
    switch (status) {
      case OrderStatus.pending:
        color = Colors.orange;
        break;
      case OrderStatus.confirmed:
        color = Colors.blue;
        break;
      case OrderStatus.processing:
        color = Colors.purple;
        break;
      case OrderStatus.ready:
        color = Colors.teal;
        break;
      case OrderStatus.shipped:
        color = Colors.indigo;
        break;
      case OrderStatus.delivered:
        color = Colors.green;
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
