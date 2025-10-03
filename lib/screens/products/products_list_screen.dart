import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/product.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  List<Product> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Demo products
    _products = [
      Product(
        id: '1',
        vendorId: 'vendor1',
        name: 'Wellness Tea',
        description: 'Organic herbal tea blend for wellness',
        price: 12.99,
        stock: 50,
        category: 'Beverages',
        images: [],
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Product(
        id: '2',
        vendorId: 'vendor1',
        name: 'Vitamin C Supplements',
        description: 'High-quality vitamin C for immunity',
        price: 24.99,
        stock: 100,
        category: 'Supplements',
        images: [],
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Product(
        id: '3',
        vendorId: 'vendor1',
        name: 'Yoga Mat',
        description: 'Eco-friendly yoga mat',
        price: 39.99,
        stock: 25,
        category: 'Fitness',
        images: [],
        isActive: false,
        createdAt: DateTime.now(),
      ),
    ];
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/products/add'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No products yet',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add your first product to get started',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => context.go('/products/add'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Product'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadProducts,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.shopping_bag,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          title: Text(
                            product.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text('\$${product.price.toStringAsFixed(2)}'),
                              const SizedBox(height: 2),
                              Text(
                                'Stock: ${product.stock}',
                                style: TextStyle(
                                  color: product.stock < 10
                                      ? Colors.red
                                      : Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: product.isActive
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  product.isActive ? 'Active' : 'Inactive',
                                  style: TextStyle(
                                    color: product.isActive
                                        ? Colors.green
                                        : Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                          onTap: () => context.go('/products/edit/${product.id}'),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/products/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
