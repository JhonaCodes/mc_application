import 'dart:developer';

import 'package:deepstatemanagment/model/trade.dart';
import 'package:deepstatemanagment/provider/trade_provider.dart';
import 'package:deepstatemanagment/ui/widget/trade_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TradeScreen extends ConsumerWidget {

  const TradeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return StreamBuilder(

        stream: ref.watch(tradeProvider.notifier).getTradesStream(),

        builder: (context, AsyncSnapshot<List<Trade>> snapshot) {

          log("TradeScreen.StreamBuilder.getTradesStream()");

          List<Trade> dataTrades = snapshot.data ?? [];

          if(snapshot.hasError){
            return const Center(child: Text('Error'),);
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }

          return ListView.builder(
              itemCount: dataTrades.length,
              itemBuilder: (context, index){
                final trade = dataTrades[index];
                return TradeCard(trade: trade,);
              }
          );
        }
    );
  }
}
