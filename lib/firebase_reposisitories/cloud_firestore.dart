import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_medcare/models/patient_model.dart';
import 'package:path/path.dart' as path;

final cloudStoreProvider = Provider<FirestoreClass>((ref) => FirestoreClass());

class FirestoreClass {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future addUser({PatientDetailsModel? user}) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user!.toJson());
  }

  Future<PatientDetailsModel?> getUser() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      PatientDetailsModel user = PatientDetailsModel.getModelFromJson(
        json: snapshot.data() as dynamic,
      );
      return user;
    } else {
      return null;
    }
  }

  Future addUserDetails({required OtherInfoModel otherDetails}) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection("user-details")
        .doc()
        .set(otherDetails.toJson());
  }

  Stream<List<OtherInfoModel>> getUserDetails() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('user-details')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => OtherInfoModel.getModelFromJson(doc.data()))
          .toList();
    });
  }

  String listenToChanges() {
    String result = '';
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      result = snapshot.data().toString();

      print(snapshot.data());
    });
    return result;
  }

  Future<void> uploadImageToFirestore(File pickedImage) async {
    try {
      final fileName = path.basename(pickedImage.path);
      final firebaseStorageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      await firebaseStorageRef.putFile(pickedImage);

      final imageUrl = await firebaseStorageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'imageURL': imageUrl});
      print('Successsssssssssssssssss');
    } catch (error) {
      print('Image upload failed: $error');
    }
  }

 Future<String?> getDp() async {
  String? image;

  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .get();
  if (snapshot.exists) {
    var data = snapshot.data() as Map<String, dynamic>; 
    image = data['imageURL'] ?? '';
    return image;
  } else {
    return null;
  }
}
 StreamSubscription<DocumentSnapshot>? profileListener;
 
String? currentImageUrl;

  Future<String?> getDpWithListener(Function(String?) onProfilePictureChanged) async {
    String? initialImageUrl = await getDp();

    currentImageUrl = initialImageUrl;

    profileListener?.cancel();

    profileListener = firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        String? newImageUrl = data['imageURL'] as String?;

        if (newImageUrl != currentImageUrl) {
          currentImageUrl = newImageUrl;

          onProfilePictureChanged(newImageUrl);
        }
      }
    });

   
    return initialImageUrl;
  }

  }


