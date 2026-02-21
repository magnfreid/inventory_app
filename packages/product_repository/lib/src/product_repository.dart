import 'package:product_repository/product_repository.dart';
import 'package:product_repository/src/models/product_create_model.dart';

abstract interface class ProductRepository {
  Stream<List<Product>> watchProducts();
  Future<Product> addProduct(ProductCreateModel product);
}
