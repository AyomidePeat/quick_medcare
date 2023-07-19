import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_medcare/models/patient_model.dart';

import 'cloud_firestore.dart';

class AuthenticationMethod {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreClass firestoreClass = FirestoreClass();

  Future<String> signUp(
      {required String email,
      required String password,
      required String lastName,
      required String gender,
      required String firstName}) async {
    String message = 'Something went wrong';
    email.trim();
    password.trim();
    if (firstName != "" && email != "" && password != "") {
      try {
        final userCredential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        PatientDetailsModel user = PatientDetailsModel(
            firstName: firstName,
            gender: gender,
            lastName: lastName,
            email: email,
            uid: userCredential.user!.uid,
            role: 'patient');
        await firestoreClass.addUser(user: user);
        message = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = "Password is too weak";
        } else if (e.code == 'email-already-in-use') {
          message = 'Email already registered';
        } else if (e.code == 'user not found') {
          message = 'Email or Password is incorrect';
        }
        return message;
      } catch (e) {
        return e.toString();
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    String message = '';
    if (email != "" && password != "") {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        message = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          message = 'No account was found for this email';
        } else if (e.code == 'wrong-password') {
          message = 'Username or password is incorrect';
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }
}
