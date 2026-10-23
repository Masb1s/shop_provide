import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_model.dart';
import 'providers/catalog_model.dart';
import 'providers/order_model.dart';
import 'screens/catalog_screen.dart';
import 'services/fake_api.dart';

void main() {
  final api = FakeApi();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CatalogModel(api),
        ),
        ChangeNotifierProvider(
          create: (_) => CartModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderModel(api),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Інтернет-магазин',
      debugShowCheckedModeBanner: false,
      home: const CatalogScreen(),
    );
  }
}