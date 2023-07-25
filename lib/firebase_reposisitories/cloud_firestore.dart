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
Future addPatientDetails({required PatientFileModel patientDetails, patientId}) async{
  String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('users')
          .doc(patientId)
          .collection("patient-details")
          .doc()
          .set(patientDetails.toJson());
      message = 'Saved';
    } catch (e) {
      return e.toString();
    }
    return message;
  }
Stream<List<PatientFileModel>> getPatientDetails() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('patient-details')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => PatientFileModel.getModelFromJson(doc.data()))
          .toList();
    });
  }

  Future addUserDetails({required OtherInfoModel otherDetails}) async {
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
}
