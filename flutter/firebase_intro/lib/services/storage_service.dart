// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // resmi frebase storage'e ekleme
  // Future<String> upluadImageToStorage(
  //   String childName,
  //   Uint8List file,
  // ) async {
  //   Reference ref =
  //       _storage.ref().child(childName).child(_auth.currentUser!.uid);

  //   ref = ref.child('test');

  //   UploadTask uploadTask = ref.putData(file);

  //   TaskSnapshot snap = await uploadTask;

  //   String downloadUrl = await snap.ref.getDownloadURL();

  //   return downloadUrl;
  // }
}
