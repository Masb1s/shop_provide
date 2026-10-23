import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_model.dart';
import '../screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'ProductCard ${product.name} build',
    );

    final quantity =
        context.select<CartModel, int>(
      (cart) =>
          cart.quantities[product.id] ?? 0,
    );

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(product.name),

        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(product.category),
            Text(
              '${product.price} ₴',
            ),

            if (quantity > 0)
              Text(
                'У кошику: $quantity',
              ),
          ],
        ),

        trailing: ElevatedButton(
          onPressed: () {
            context
                .read<CartModel>()
                .add(product);
          },
          child: const Text(
            'До кошика',
          ),
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ProductScreen(
                product: product,
              ),
            ),
          );
        },
      ),
    );
  }
}