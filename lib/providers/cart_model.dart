import 'package:flutter/material.dart';

import '../models/product.dart';

class CartModel extends ChangeNotifier {
  final Map<String, Product> _products = {};
  final Map<String, int> _quantities = {};

  Map<String, Product> get products => _products;

  Map<String, int> get quantities => _quantities;

  int get itemCount {
    return _quantities.values.fold(
      0,
      (sum, value) => sum + value,
    );
  }

  double get totalPrice {
    double total = 0;

    _quantities.forEach((id, quantity) {
      total += _products[id]!.price * quantity;
    });

    return total;
  }

  void add(Product product) {
    _products[product.id] = product;

    _quantities.update(
      product.id,
      (value) => value + 1,
      ifAbsent: () => 1,
    );

    notifyListeners();
  }

  void increase(String id) {
    _quantities[id] = _quantities[id]! + 1;
    notifyListeners();
  }

  void decrease(String id) {
    if (_quantities[id] == 1) {
      remove(id);
      return;
    }

    _quantities[id] = _quantities[id]! - 1;
    notifyListeners();
  }

  void remove(String id) {
    _products.remove(id);
    _quantities.remove(id);

    notifyListeners();
  }

  void clear() {
    _products.clear();
    _quantities.clear();

    notifyListeners();
  }
}