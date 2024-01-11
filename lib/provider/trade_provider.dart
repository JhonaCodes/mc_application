import 'package:deepstatemanagment/model/trade.dart';
import 'package:deepstatemanagment/viewmodel/trade_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_provider.dart';

/// The other side of provider.
///
/// In this case we use 1 provider for [TradeVM], but possibly if we need to add additional -
/// logic that depends on other providers or data, we will have to add logic inside our widget.
final tradeProvider = StateNotifierProvider<TradeVM, List<Trade>>((ref) {
  final apiP = ref.watch(apiProvider);
  return TradeVM(apiP);
});