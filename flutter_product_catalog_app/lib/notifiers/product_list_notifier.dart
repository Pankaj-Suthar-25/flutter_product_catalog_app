import 'package:flutter/material.dart';
import 'package:flutter_product_catalog_app/models/product.dart';

class ProductListNotifier extends ChangeNotifier {
  // Dummy products
  final List<Product> _products = [
    const Product(
      id: 'p1',
      name: 'Wireless Headphone',
      description: 'Wireless Headphone',
      price: 99.99,
      imageUrl: '',
    ),
    const Product(
      id: 'p2',
      name: 'Smart Watch',
      description: 'Smart Watch',
      price: 149.99,
      imageUrl: '',
    ),
    const Product(
      id: 'p3',
      name: 'Ear Buds',
      description: 'Ear Buds',
      price: 129.99,
      imageUrl: '',
    ),
    const Product(
      id: 'p4',
      name: 'Smart Phone',
      description: 'Smart Phone',
      price: 399.99,
      imageUrl: '',
    ),
    const Product(
      id: 'p5',
      name: 'Fitness Band',
      description: 'Fitness Band',
      price: 59.99,
      imageUrl: '',
    ),
  ];

  // Getter for new list
  List<Product> get products => [..._products];

  // Toggle method
  void toggleFavorite(String productId) {
    final productIndex =
        _products.indexWhere((product) => product.id == productId);

    if (productIndex >= 0) {
      final oldProduct = _products[productIndex];
      final updateProduct =
          oldProduct.copyWith(isFavorite: !oldProduct.isFavorite);
      _products[productIndex] = updateProduct;
      notifyListeners();
    }
  }

  // Add new Product method
  void addProduct(Product newProduct) {
    _products.add(newProduct);
    notifyListeners();
  }

  // Remove existing Product method
  void removeProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
