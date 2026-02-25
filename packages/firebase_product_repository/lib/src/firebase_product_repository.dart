import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:part_repository/part_repository.dart';

class FirebaseProductRepository implements PartRepository {
  FirebaseProductRepository({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('parts')
        .withConverter<Part>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            return Part.fromJson({
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
  late final CollectionReference<Part> _collection;

  @override
  Stream<List<Part>> watchProducts() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<Part> addPart(PartCreateModel productCreateModel) async {
    final docRef = _collection.doc();
    final part = Part.fromCreateModel(docRef.id, productCreateModel);
    await docRef.set(part);
    return part;
  }
}
