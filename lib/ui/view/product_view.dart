import 'dart:developer';
import 'dart:math' hide log;

import 'package:deepstatemanagment/model/trade.dart';
import 'package:deepstatemanagment/provider/products_provider.dart';
import 'package:deepstatemanagment/provider/trade_provider.dart';
import 'package:deepstatemanagment/ui/widget/text_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ProductView extends ConsumerWidget {
  final String productId;
  const ProductView({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: ClipRRect(
        borderRadius: const BorderRadius.all( Radius.circular(20)),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),

                /// Take a product from provider by id.
                ///
                /// The interesting thing is here i can get product from real time database and show it in the screen.
                /// Then I will not have to do a periodic update so that the information is updated,
                /// but rather it will be updated even in the form, thus avoiding the need for a timer or -
                /// update during navigation.
              child:  ref.watch(productById(productId)).when(data: (product){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextBody(
                      text: product.name,
                    ),
                    TextBody(text: product.unit),
                    TextBody(text: product.id),
                  ],
                );
              },
                  error: (error,stackTrade) => Text("Error: $error"),
                  loading: () => const Center(child: CircularProgressIndicator(color: Colors.white,),)
              )
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text( 'Cancel'),

                ),

                ElevatedButton(
                  onPressed: () async{

                    try{

                      await ref.watch(tradeProvider.notifier).addTrade(
                          Trade(
                              id: _generateUniqueNumber() ~/ 8400,
                              productId: productId,
                              price: DateTime.now().minute.toDouble(),
                              etd: DateTime.now().millisecondsSinceEpoch % 2 == 0 ? "etd": "etd2",
                              destination: "",
                            created: DateTime.now(),
                            incoterm: DateTime.now().millisecondsSinceEpoch % 3 == 0 ? "FOB": "CIF",
                          ),
                      ).then((value) {
                        if(context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Trade added', style: TextStyle(color: Colors.white),),
                            ),
                          );
                          Navigator.maybePop(context);
                        }
                      });

                    }catch(e){
                      log(e.toString());
                      if(context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Trade error', style: TextStyle(color: Colors.white),),
                          ),
                        );
                      }
                    }

                  },
                  child: const Text( 'Create Trade'),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


int _generateUniqueNumber() {
  final Set<int> generatedNumbers = <int>{};
  final Random random = Random();

  while (true) {

    int baseNumber = DateTime.now().millisecondsSinceEpoch;

    int randomNumber = baseNumber + random.nextInt(10000);
    if (!generatedNumbers.contains(randomNumber)) {
      generatedNumbers.add(randomNumber);
      return randomNumber;
    }
  }
}