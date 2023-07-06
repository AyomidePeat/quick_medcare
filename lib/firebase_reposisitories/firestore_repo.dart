import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/patient_model.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class Firestore {
   Future uploadPatientDetailsToDatabase(
      {required PatientDetailsModel? patient}) async {
    await firebaseFirestore
        .collection("patients")
        .doc(firebaseAuth.currentUser!.uid)
        .set(patient!.toJson());
  }

  Future<PatientDetailsModel?> getUserDetails() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection('patients')
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    if (snapshot.exists) {
      PatientDetailsModel patient = PatientDetailsModel.getModelFromJson(
        json: snapshot.data() as dynamic,
      );
      return patient;
    } else {
      return null;
    }
  }
}
