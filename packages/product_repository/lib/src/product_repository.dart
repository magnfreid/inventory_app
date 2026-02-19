import 'package:product_repository/product_repository.dart';

abstract interface class ProductRepository {
  Stream<List<Product>> watchProducts();
}
