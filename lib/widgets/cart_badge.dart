import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_model.dart';
import '../screens/cart_screen.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CartModel, int>(
      selector: (_, cart) => cart.itemCount,
      builder: (context, count, child) {
        return IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CartScreen(),
              ),
            );
          },
          icon: Badge(
            label: Text('$count'),
            child: const Icon(Icons.shopping_cart),
          ),
        );
      },
    );
  }
}