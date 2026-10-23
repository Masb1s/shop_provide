import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_model.dart';

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
            Text('${product.price} ₴'),
            Text('У кошику: $quantity'),
          ],
        ),
        trailing: Row(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            IconButton(
              onPressed: quantity == 0
                  ? null
                  : () {
                      context
                          .read<CartModel>()
                          .decrease(
                            product.id,
                          );
                    },
              icon: const Icon(
                Icons.remove,
              ),
            ),
            IconButton(
              onPressed: () {
                context
                    .read<CartModel>()
                    .add(product);
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
            IconButton(
              onPressed: quantity == 0
                  ? null
                  : () {
                      context
                          .read<CartModel>()
                          .remove(
                            product.id,
                          );
                    },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}