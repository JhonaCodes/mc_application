import 'dart:developer';

import 'package:deepstatemanagment/provider/products_provider.dart';
import 'package:deepstatemanagment/ui/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ref.watch(productList).when(
        data: (products){
          log("ProductScreen: ${products.length}");
          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index){
                final product = products[index];
                return ProductCard(product: product);
              }
          );
        },
        error: (error, stackTrace) => Text('Error $error'),
        loading: ()=> const Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        )
    );
  }
}
