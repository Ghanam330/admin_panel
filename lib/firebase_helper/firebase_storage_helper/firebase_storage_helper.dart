import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadUserImage(File image) async {
    // String userId = FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot taskSnapshot = await _storage .ref()
        .child('users/${Uri
        .file(image.path)
        .pathSegments
        .last}').putFile(image);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

}