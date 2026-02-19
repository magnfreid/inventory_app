import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:product_repository/product_repository.dart';

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
          fromFirestore: (snapshot, _) =>
              Product.fromJson(snapshot.data()!..['id'] = snapshot.id),
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
}
