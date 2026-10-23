import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    if (cart.itemCount == 0) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Кошик'),
        ),
        body: const Center(
          child: Text(
            'Кошик порожній',
          ),
        ),
      );
    }

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

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ціна: ${product.price} ₴',
                        ),
                        Text(
                          'Кількість: $quantity',
                        ),
                      ],
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

                        Text('$quantity'),

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
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Загальна сума: ${cart.totalPrice.toStringAsFixed(2)} ₴',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Замовлення оформлено',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Оформити замовлення',
                    ),
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