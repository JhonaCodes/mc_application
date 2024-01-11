import 'package:deepstatemanagment/model/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'base_card.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return BaseCard(
      title: product.name,
      subTitle: Text(product.attribute ?? "N/A", style: const TextStyle(fontSize: 10, color: Colors.grey),),
      leading: product.currency,
      priceInfo: product.unit,
      sheetView: () => context.push('/product/${product.id}'),

    );
  }
}
