import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Кошик'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.products.values.map((product) {
                final quantity =
                    cart.quantities[product.id]!;

                return ListTile(
                  title: Text(product.name),

                  subtitle: Text(
                    'Кількість: $quantity',
                  ),

                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          cart.decrease(
                            product.id,
                          );
                        },
                        icon: const Icon(
                          Icons.remove,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          cart.increase(
                            product.id,
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          cart.remove(
                            product.id,
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Сума: ${cart.totalPrice} ₴',
                ),

                const SizedBox(
                  height: 16,
                ),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Оформити замовлення',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}