import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quidditch_app/models/models.dart';
import 'package:path/path.dart' as path;

class FirebaseProvider {
  FirebaseStorage get storage => FirebaseStorage.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Not authenticated exception");
    return user;
  }

  Future<UserLoc?> getUserLoc() async {
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    if (snapshot.exists) return UserLoc.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  Future<void> saveUserLoc(UserLoc user, File? image) async {
    final ref = firestore.doc("users/${currentUser.uid}");
    if (image == null) {
      await ref.set(user.toFirebaseMap(), SetOptions(merge: true));
    } else {
      final imagePath =
          "${currentUser.uid}/profile/${path.basename(image.path)}";
      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      await ref.set(user.toFirebaseMap(newImage: url), SetOptions(merge: true));
    }
  }
}
