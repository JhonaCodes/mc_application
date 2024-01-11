import 'package:deepstatemanagment/infrastructure/api/base_api_impl.dart';

import 'package:deepstatemanagment/infrastructure/db_table.dart';
import 'package:deepstatemanagment/model/product.dart';

/// [ProductRepository]
///
/// This implementation has multiple steps that will help with easy testing -
/// in addition to implementing the use of our API that will transform the data to our specific model -
/// these were used by the [ViewModel]
class ProductRepository {

  /// [BaseApiImpl] is the interface that will be used to implement the API.
  ///
  /// This is a good practice to implement the API, because if we need to change the API, -
  /// we will only have to change the implementation of the API, and not the entire application.
  final BaseApiImpl apiImpl;

  /// [ProductRepository] constructor
  ///
  /// This constructor is used to inject the API implementation.
  ProductRepository({required this.apiImpl});

  Future<List<Product>> fetchAllProducts() async{
    final List<Map<String, dynamic>> productsMap = await apiImpl.get( path: DBTable.products, );
    return productsMap.map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> fetchProductById(String id) {
    return apiImpl.getById(
        path: DBTable.products,
        id: id,
    ).then((value) => value.map(Product.fromJson).toList());
  }

  Future<void> addProduct(Product product) async{
    await apiImpl.post(DBTable.products, product.toJson());
  }


}