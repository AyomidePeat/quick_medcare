import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
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

        UserDetailsModel user = UserDetailsModel(
            firstName: firstName, lastName: lastName, gender: gender);
        await Firestore.uploadUserDetailsToDatabase(user: user);

        output = "Success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
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
