import 'package:firebase_auth/firebase_auth.dart';

import '../models/patient_model.dart';
import 'firestore_repo.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Firestore fireStore = Firestore();
  Future<String> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String gender,
      required String password}) async {
    firstName.trim();
    lastName.trim();
    gender;
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (lastName != "" && email != "" && password != "" && firstName != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        PatientDetailsModel patient = PatientDetailsModel(
            firstName: firstName, lastName: lastName, gender: gender);
        await fireStore.uploadPatientDetailsToDatabase(patient: patient);

        output = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          output = "Password is too weak";
        } else if (e.code == 'email-already-in-use') {
          output = 'Email already registered';
        }
        return output;
      } catch (e) {
        print(e);
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "Success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }

  Future<String> signOut() async {
    String output = 'Something went wrong';
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      output = e.message.toString();
    }
    return output;
  }
}
