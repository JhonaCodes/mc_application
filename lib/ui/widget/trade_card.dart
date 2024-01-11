import 'package:deepstatemanagment/model/trade.dart';
import 'package:flutter/material.dart';

import 'base_card.dart';

class TradeCard extends StatelessWidget {
  final Trade trade;
  const TradeCard({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {

    return ExpansionTile(
      title: BaseCard(
        title: trade.etd,
        subTitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(trade.destination, style: const TextStyle(fontSize: 10, color: Colors.grey),),
            Text(trade.productId, style: const TextStyle(fontSize: 10, color: Colors.grey),),
          ],
        ),
        sheetView: null,
        priceInfo: "\$${trade.price}",
        leading: trade.incoterm,
        iconPriceInfo: Icon(Icons.currency_exchange),
      ),
      children: [
        ListTile(
          title: Text(trade.etd),
          subtitle: Text(trade.destination),
          onTap: (){
          },
        )
      ],
    );
  }
}
