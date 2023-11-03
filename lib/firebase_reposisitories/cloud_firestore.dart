import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_medcare/models/illness_model.dart';
import 'package:quick_medcare/models/patient_model.dart';
import 'package:path/path.dart' as path;
//import 'package:uuid/uuid.dart';

import '../models/doctor_model.dart';
import '../models/patient_file_model.dart';
import 'firebase_storage.dart';

final cloudStoreProvider = Provider<FirestoreClass>((ref) => FirestoreClass());
final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(cloudStoreProvider);
  return authController.getUser();
});

class FirestoreClass {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future addUser({PatientDetailsModel? user}) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user!.toJson());
  }

  Future<DoctorDetailsModel?> getDoctor() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      DoctorDetailsModel user = DoctorDetailsModel.getModelFromJson(
        json: snapshot.data() as dynamic,
      );
      return user;
    } else {
      return null;
    }
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

  Stream<String?> getDp() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        return data['imageURL'] ?? '';
      } else {
        return null;
      }
    });
  }

  Future addPatientDetails(
      {required String fullName,
      required String dob,
      required String gender,
      required String email,
      required String address,
      required String pastConditions,
      required String allergies,
      required String previousSurgeries,
      required String symptoms,
      required String symptomDuration,
      required String symptomSeverity,
      required String testResults,
      required String imageReports,
      required String diagnosis,
      required String prescription,
      required String surgicalProcedure}) async {
    PatientFileModel patientFile = PatientFileModel(
        fullName: fullName,
        dob: dob,
        gender: gender,
        email: email,
        address: address,
        pastConditions: pastConditions,
        allergies: allergies,
        previousSurgeries: previousSurgeries,
        symptoms: symptoms,
        symptomDuration: symptomDuration,
        symptomSeverity: symptomSeverity,
        testResults: testResults,
        imageReports: imageReports,
        diagnosis: diagnosis,
        prescription: prescription,
        surgicalProcedure: surgicalProcedure);
    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection("${auth.currentUser?.uid}patient-details")
          .doc('$fullName$email')
          .set(patientFile.toJson());
      message = 'Saved';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Stream<List<PatientFileModel>> getPatientDetails() {
    return firebaseFirestore
        .collection('${auth.currentUser?.uid}patient-details')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => PatientFileModel.getModelFromJson(doc.data()))
          .toList();
    });
  }

  Future<PatientFileModel?> getPatientFile(
      String fullName, String email) async {
    final snapshot = await firebaseFirestore
        .collection('${auth.currentUser?.uid}patient-details')
        .doc('$fullName$email')
        .get();
    final patientData = snapshot.data.call();
    if (patientData != null) {
      PatientFileModel patientFile =
          PatientFileModel.getModelFromJson(patientData);
      print(patientFile);
      return patientFile;
    } else {
      return null;
    }
  }

  Future addUserDetails({
    required String age,
    required String weight,
    required String height,
    required String cholesterol,
    required String healthAgency,
    required String bloodType,
    required String genotype,
    required String bloodPressure,
  }) async {
    OtherInfoModel otherDetails = OtherInfoModel(
        age: age,
        weight: weight,
        height: height,
        cholesterol: cholesterol,
        healthAgency: healthAgency,
        bloodType: bloodType,
        genotype: genotype,
        bloodPressure: bloodPressure);
    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection("user-details")
          .doc()
          .set(otherDetails.toJson());
      message = 'Uploaded';
    } catch (e) {
      return e.toString();
    }
    return message;
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

  Stream<List<IllnessHistoryModel>> getIllnessHistory() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('illness-history')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => IllnessHistoryModel.getModelFromJson(doc.data()))
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
    } catch (error) {
//    }
    }
  }

  Future<void> uploadDoctorsImageToFirestore(File pickedImage, uid) async {
    try {
      final fileName = path.basename(pickedImage.path);
      final firebaseStorageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      await firebaseStorageRef.putFile(pickedImage);

      final imageUrl = await firebaseStorageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'image': imageUrl});
    } catch (error) {
      // }
    }

    // StreamSubscription<DocumentSnapshot>? profileListener;

    // String? currentImageUrl;

    // Future<String?> getDpWithListener(
    //     Function(String?) onProfilePictureChanged) async {
    //   String? initialImageUrl = await getDp();

    //   currentImageUrl = initialImageUrl;

    //   profileListener?.cancel();

    //   profileListener = firebaseFirestore
    //       .collection('users')
    //       .doc(auth.currentUser!.uid)
    //       .snapshots()
    //       .listen((DocumentSnapshot snapshot) {
    //     if (snapshot.exists) {
    //       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    //       String? newImageUrl = data['imageURL'] as String?;

    //       if (newImageUrl != currentImageUrl) {
    //         currentImageUrl = newImageUrl;

    //         onProfilePictureChanged(newImageUrl);
    //       }
    //     }
    //   });

    //   return initialImageUrl;
    // }

    //  void sendFileMessage({
    //   required BuildContext context,
    //   required File file,
    //   required String recieverUserId,
    //   required ChatModel senderUserData,
    //   required ProviderRef ref,
    //   required MessageEnum messageEnum,
    //   required MessageReply? messageReply,
    //   required bool isGroupChat,
    // }) async {
    //   try {
    //     var timeSent = DateTime.now();
    //     var messageId = const Uuid().v1();

    //     String imageUrl = await ref
    //         .read(firebaseStorageRepositoryProvider)
    //         .storeFileToFirebase(
    //           'chat/${messageEnum.type}/${senderUserData.uid}/$recieverUserId/$messageId',
    //           file,
    //         );

    //     ChatModel? recieverUserData;

    //       var userDataMap =
    //           await firebaseFirestore.collection('users').doc(recieverUserId).get();
    //       recieverUserData = ChatModel.fromJson(userDataMap.data()!);

    //     String contactMsg;

    //     switch (messageEnum) {
    //       case MessageEnum.image:
    //         contactMsg = '📷 Photo';
    //         break;
    //       case MessageEnum.video:
    //         contactMsg = '📸 Video';
    //         break;
    //       case MessageEnum.audio:
    //         contactMsg = '🎵 Audio';
    //         break;
    //       case MessageEnum.gif:
    //         contactMsg = 'GIF';
    //         break;
    //       default:
    //         contactMsg = 'GIF';
    //     }

    //   } catch (e) {
    //     showSnackBar(context: context, content: e.toString());
    //   }
    // }

    void showSnackBar(
        {required BuildContext context, required String content}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(content),
        ),
      );
    }

    Stream<PatientDetailsModel> userData(String userId) {
      return firebaseFirestore.collection('users').doc(userId).snapshots().map(
            (event) => PatientDetailsModel.getModelFromJson(),
          );
    }
  }

  Future addDoctor({
    required String uid,
    required String firstName,
    required String lastName,
    required String email,
    required String department,
    required String image,
    required String info,
    required String numberOfPatients,
    required String experience,
    required String role,
    required String specialization,
  }) async {
    DoctorDetailsModel doctor = DoctorDetailsModel(
        specialization: specialization,
        firstName: firstName,
        lastName: lastName,
        department: department,
        email: email,
        uid: uid,
        image: image,
        info: info,
        numberOfPatients: numberOfPatients,
        experience: experience,
        role: role);
    String message = 'Something went wrong';
    try {
      await firebaseFirestore.collection('users').doc(uid).set(doctor.toJson());
      await firebaseFirestore
          .collection(department)
          .doc(uid)
          .set(doctor.toJson());

      message = 'Uploaded';
    } catch (e) {
      return e.toString();
    }
    return message;
  }
}
