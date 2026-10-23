import 'dart:math';

import '../models/demo_products.dart';
import '../models/product.dart';

class FakeApi {
  final _random = Random();

  Future<List<Product>> fetchProducts() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (_random.nextInt(5) == 0) {
      throw Exception('Сервер недоступний');
    }

    return demoProducts;
  }

  Future<void> sendOrder() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (_random.nextInt(4) == 0) {
      throw Exception('Помилка оформлення');
    }
  }
}