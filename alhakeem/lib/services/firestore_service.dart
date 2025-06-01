import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create document
  Future<DocumentReference> createDocument(
    String collection,
    Map<String, dynamic> data,
  ) async {
    return await _db.collection(collection).add(data);
  }

  // Read document
  Future<DocumentSnapshot> getDocument(String collection, String docId) async {
    return await _db.collection(collection).doc(docId).get();
  }

  // Update document
  Future<void> updateDocument(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    await _db.collection(collection).doc(docId).update(data);
  }

  // Delete document
  Future<void> deleteDocument(String collection, String docId) async {
    await _db.collection(collection).doc(docId).delete();
  }

  // Get collection stream
  Stream<QuerySnapshot> streamCollection(String collection) {
    return _db.collection(collection).snapshots();
  }

  // Get filtered collection stream
  Stream<QuerySnapshot> streamFilteredCollection(
    String collection,
    String field,
    dynamic value,
  ) {
    return _db
        .collection(collection)
        .where(field, isEqualTo: value)
        .snapshots();
  }

  // Get ordered collection stream
  Stream<QuerySnapshot> streamOrderedCollection(
    String collection,
    String orderField, {
    bool descending = false,
  }) {
    return _db
        .collection(collection)
        .orderBy(orderField, descending: descending)
        .snapshots();
  }
} 