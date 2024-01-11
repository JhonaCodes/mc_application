import 'package:deepstatemanagment/infrastructure/api/base_api_impl.dart';
import 'package:deepstatemanagment/model/product.dart';
import 'package:deepstatemanagment/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [ViewModel]
/// The [ViewModel] is the layer that reads the data from the repository to show it to the Ui through the provider.
/// So this is the intermediary between the UI and the Model in this case [ProductVM].
///
/// [StateNotifier]
///
/// [StateNotifier] is a class that implements [Notifier] and is used to manage mutable state -
/// in a more structured and declarative way.
/// Unlike [ChangeNotifier], a [StateNotifier] has an internal state object and exposes methods to modify that state [state].
/// Changes in state trigger updates to registered listeners.
class ProductVM extends StateNotifier<List<Product>>{


  ProductVM(BaseApiImpl apiImpl):super([]){
    _productRepository = ProductRepository(apiImpl: apiImpl);
  }

  /// [ProductRepository]
  ///
  /// [ProductRepository] is a class that implements [BaseApiImpl] and is used to manage mutable state -
  /// in a more structured and declarative way.
  late ProductRepository _productRepository;


  Future<List<Product>> getProducts() async{
    state = await _productRepository.fetchAllProducts();
    return state;
  }

  Future<List<Product>> getProductById(String id) async{
    List<Product> productById = await _productRepository.fetchProductById(id);
    state = [...productById];
    return await _productRepository.fetchProductById(id);
  }

  Future<void> addProduct(Product product) async{
    await _productRepository.addProduct(product);

    /// [state]
    ///
    /// [state] is the current state of the notifier.
    /// Similar to a StreamController, state adds the new element to its state by notifying all widgets or elements listening to it.
    state = [...state, product];
  }

}