import 'package:flutter/material.dart';

import '../services/fake_api.dart';
import 'cart_model.dart';

class OrderModel extends ChangeNotifier {
  OrderModel(this.api);

  final FakeApi api;

  bool isLoading = false;
  String? errorMessage;

  Future<void> checkout(CartModel cart) async {
    if (isLoading) return;

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await api.sendOrder();

      cart.clear();
    } catch (e) {
      errorMessage = 'Не вдалося оформити замовлення';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}