import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user.dart';
import 'base_database_repository.dart';
import 'storage_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Stream<User> getUser() {
    return _firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.email)
        .snapshots()
        .map((snapshot) => User.fromSnapshot(snapshot));
  }

  @override
  Future<void> updateUserPictures(String imageName) async {
    String getdownloadUrl = await StorageRepository().getImageUrl(imageName);
    return _firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.email)
        .update({
      'imageUrl': FieldValue.arrayUnion([getdownloadUrl])
    });
  }
}
