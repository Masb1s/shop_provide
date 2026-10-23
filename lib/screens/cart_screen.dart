import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_model.dart';
import '../providers/order_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final order = context.watch<OrderModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Кошик'),
      ),
      body: cart.itemCount == 0
          ? const Center(
              child: Text(
                'Кошик порожній',
              ),
            )
          : Column(
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
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
                              Text('$quantity'),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<CartModel>()
                                      .increase(
                                        product.id,
                                      );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
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
                          onPressed: cart.itemCount == 0 ||
                                  order.isLoading
                              ? null
                              : () async {
                                  final orderModel =
                                      context.read<OrderModel>();

                                  await orderModel.checkout(cart);

                                  if (!context.mounted) {
                                    return;
                                  }

                                  if (orderModel.errorMessage ==
                                      null) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Замовлення успішно оформлено',
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          orderModel
                                              .errorMessage!,
                                        ),
                                      ),
                                    );
                                  }
                                },
                          child: order.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
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