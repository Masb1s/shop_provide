import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Text(
              product.description,
            ),

            const SizedBox(
              height: 16,
            ),

            Text(
              'Ціна: ${product.price} ₴',
            ),

            const SizedBox(
              height: 24,
            ),

            ElevatedButton(
              onPressed: () {
                context
                    .read<CartModel>()
                    .add(product);
              },
              child: const Text(
                'До кошика',
              ),
            ),
          ],
        ),
      ),
    );
  }
}