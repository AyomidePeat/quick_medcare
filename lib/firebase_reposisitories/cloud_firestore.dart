import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_medcare/models/patient_model.dart';

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
}
