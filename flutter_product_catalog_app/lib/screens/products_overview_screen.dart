import 'package:flutter/material.dart';
import 'package:flutter_product_catalog_app/models/product.dart';
import 'package:flutter_product_catalog_app/notifiers/product_list_notifier.dart';
import 'package:flutter_product_catalog_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              final productListNotifier =
                  Provider.of<ProductListNotifier>(context, listen: false);

              productListNotifier.addProduct(
                Product(
                  id: 'p${DateTime.now().microsecondsSinceEpoch}',
                  name: 'New Gadget',
                  description: 'New Gadget',
                  price: 19.99,
                  imageUrl: '',
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<ProductListNotifier>(
        builder: (context, productListNotifier, child) {
          final products = productListNotifier.products;

          if (products.isEmpty) {
            return const Center(
              child: Text('No Products available. Add some!'),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return ProductItem(
                key: ValueKey(product.id),
                product: product,
                onToggleFavorite: () {
                  productListNotifier.toggleFavorite(product.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onToggleFavorite;

  const ProductItem(
      {super.key, required this.product, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Dismissible(
        key: ValueKey(product.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 36),
        ),
        onDismissed: (direction) {
          final productListNotifier =
              Provider.of<ProductListNotifier>(context, listen: false);

          productListNotifier.removeProduct(product.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${product.name} removed!')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.imageUrl),
                    radius: 15.0,
                  ),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite ? Colors.red : Colors.grey),
                    onPressed: onToggleFavorite,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product)));
                    print('Tapped on ${product.name}');
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
