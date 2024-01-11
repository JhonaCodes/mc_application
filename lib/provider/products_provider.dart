import 'package:deepstatemanagment/model/product.dart';

import 'package:deepstatemanagment/provider/api_provider.dart';
import 'package:deepstatemanagment/viewmodel/product_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Why a provider for each use case or function?
///
/// In this case, I just want to exemplify the combination of data between the same providers.
/// The need to apply some logic may arise, and it should be done within this provider call, not from the widget.
/// Implementing logic from a provider is a cleaner practice.

final productProvider = StateProvider<ProductVM>((ref) {
  final apiP = ref.watch(apiProvider);
  return ProductVM(apiP);
});



final productList = FutureProvider.autoDispose<List<Product>>((ref) async{
  /// In this case I could apply any type of logic necessary, considerably reducing the logic within the widgets.
  final vm = ref.watch(productProvider);

  /// Probably apply filters, verifications, etc etc.
  return await vm.getProducts();

});



final productById = FutureProvider.autoDispose.family<Product, String>((ref, id) async{
  final vm = ref.watch(productProvider);
  return await vm.getProductById(id).then((value) => value.first);
});


final addProduct = FutureProvider.autoDispose.family<void, Product>((ref, product) async{
  final vm = ref.watch(productProvider);
  return await vm.addProduct(product).then((value) {

    /// What is [refresh]?
    ///
    /// Calling [refresh] on this provider doesn't destroy its state either, but it triggers an immediate attempt to reload its data.
    /// This involves invoking itself and attempting to obtain fresh data from the server asynchronously.
    /// If successful, the provider updates its internal state, ensuring the UI reflects the most recent information.
    ///
    /// Calling [invalidate] on this provider doesn't destroy its state, but it forces it to rebuild itself.
    /// This involves calling itself and obtaining new data from the server, ultimately updating the UI.
    ///
    /// I will use [refresh] because is a async function [FutureProvider].
    /// Example: [ref.refresh(productList)] or [ref.invalidate(productList)].
    return ref.refresh(productList);

  });
});