import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/fake_api.dart';

class CatalogModel extends ChangeNotifier {
  CatalogModel(this.api);

  final FakeApi api;

  bool isLoading = false;
  String? errorMessage;

  List<Product> _products = [];

  String selectedCategory = 'Усі';

  List<Product> get products {
    if (selectedCategory == 'Усі') {
      return _products;
    }

    return _products
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  Future<void> loadProducts() async {
    try {
      isLoading = true;
      errorMessage = null;

      notifyListeners();

      _products = await api.fetchProducts();
    } catch (e) {
      errorMessage = 'Не вдалося завантажити каталог';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<String> get categories {
    final result = <String>{'Усі'};

    for (final product in _products) {
      result.add(product.category);
    }

    return result.toList();
  }
}