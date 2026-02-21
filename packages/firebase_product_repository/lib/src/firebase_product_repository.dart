import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:product_repository/product_repository.dart';
import 'package:product_repository/src/models/product_create_model.dart';

class FirebaseProductRepository implements ProductRepository {
  FirebaseProductRepository({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('products')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            return Product.fromJson({
              ...data,
              'id': snapshot.id,
            });
          },
          toFirestore: (item, _) {
            final json = item.toJson()..remove('id');
            return json;
          },
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<Product> _collection;

  @override
  Stream<List<Product>> watchProducts() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<Product> addProduct(ProductCreateModel productCreateModel) async {
    final docRef = _collection.doc();
    final product = Product.fromCreateModel(docRef.id, productCreateModel);
    await docRef.set(product);
    return product;
  }
}
