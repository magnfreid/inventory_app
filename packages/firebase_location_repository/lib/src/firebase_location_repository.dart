import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_repository/location_repository.dart';
import 'package:location_repository/src/models/location_create_model.dart';

class FirebaseLocationRepository implements LocationRepository {
  FirebaseLocationRepository({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('locations')
        .withConverter<Location>(
          fromFirestore: (snapshot, _) =>
              Location.fromJson(snapshot.data()!..['id'] = snapshot.id),
          toFirestore: (item, _) {
            final json = item.toJson()..remove('id');
            return json;
          },
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<Location> _collection;

  @override
  Stream<List<Location>> watchLocations() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<Location> add({
    required LocationCreateModel locationCreateModel,
  }) async {
    final docRef = _collection.doc();
    final location = Location.fromCreateModel(
      id: docRef.id,
      createModel: locationCreateModel,
    );
    await docRef.set(location);
    return location;
  }
}
