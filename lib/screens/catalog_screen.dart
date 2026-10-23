import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_card.dart';
import '../providers/catalog_model.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() =>
      _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<CatalogModel>()
          .loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('CatalogScreen build');

    final catalog =
        context.watch<CatalogModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Каталог товарів',
        ),
      ),
      body: Builder(
        builder: (_) {
          if (catalog.isLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (catalog.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  Text(
                    catalog.errorMessage!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<
                              CatalogModel>()
                          .loadProducts();
                    },
                    child: const Text(
                      'Повторити',
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount:
                catalog.products.length,
            itemBuilder: (context, index) {
              final product =
                  catalog.products[index];

              return ProductCard(
                product: product,
              );
            },
          );
        },
      ),
    );
  }
}