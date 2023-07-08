import 'package:firebase_auth/firebase_auth.dart';
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
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        PatientDetailsModel user = PatientDetailsModel(
          firstName: firstName,
          gender: gender,
          lastName: lastName
        );
        await firestoreClass.addUser(user: user);
        message = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = "Password is too weak";
        } else if (e.code == 'email-already-in-use') {
          message = 'Email already registered';
        }
        return message;
      } catch (e) {
        print(e);
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
          message = 'User not found';
        } else if (e.code == 'wrong-password') {
          message = 'Username or password is incorrect';
        }
      } catch (e) {
        print(e);
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }
}
