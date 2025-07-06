import 'package:flutter/material.dart';
import 'package:flutter_product_catalog_app/notifiers/product_list_notifier.dart';
import 'package:flutter_product_catalog_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductListNotifier(),
      child: MaterialApp(
        title: 'Product Catalog',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverviewScreen(),
      ),
    );
  }
}

