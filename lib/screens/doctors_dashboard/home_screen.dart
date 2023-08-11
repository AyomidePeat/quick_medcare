import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_medcare/screens/doctors_dashboard/patient_file.dart';
import 'package:quick_medcare/widgets/custom_container.dart';
import 'package:quick_medcare/widgets/patient_container.dart';

import '../../chatting/chat_screen.dart';
import '../../utils/colors.dart';
import '../../utils/textstyle.dart';
import '../../widgets/main_button.dart';

class DoctorHomeScreen extends StatefulWidget {
  final String uid;
  const DoctorHomeScreen({super.key, required this.uid});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int regNo = 09457;
  String doctorImage = '';
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  String category = 'Online';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/heritage.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                        Text('Dr. Heritage Odewole', style: headLine3(black)),
                  ),
                ],
              ),
              const Row(
                children: [
                  Icon(Icons.notifications_none_sharp),
                ],
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [buildPatientList()],
        ),
      ),
    );
  }

  Widget buildPatientList() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          firebaseFirestore.collection('${widget.uid}patientList').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error.toString()}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return Column(
            children: [
              Image.asset('icons/record.png'),
              const SizedBox(height: 25),
              const Text('You have no patient yet'),
            ],
          );
        }
        return Flexible(
          child: ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => buildPatientListItem(doc))
                .toList(),
          ),
        );
      },
    );
  }

  // Widget getDoctorDetails(DocumentSnapshot document) {
  //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //   doctorImage = data['image'];
  //   return const SizedBox();
  // }

  // Widget getDoctorDp() {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: firebaseFirestore.collection('Opthalmology').snapshots(),
  //       builder: (context, snapshot) {
  //         return ListView(
  //           children: snapshot.data!.docs
  //               .map<Widget>((doc) => getDoctorDetails(doc))
  //               .toList(),
  //         );
  //       });
  // }

  Widget buildPatientListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    final patientEmail = data['patientEmail'];
    final patientName = data['patientName'];
    final gender = data['gender'];
    final image = data['patientDp'];
    final patientUid = data['uid'];

    if (auth.currentUser!.email != data['email']) {
      return ListTile(
          title: PatientContainer(
              name: patientName,
              email: patientEmail,
              gender: gender,
              image: image),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => ChatScreen(senderUid: patientUid,
                        receiverName: patientName,
                        senderEmail: patientEmail,
                        gender: gender,
                        senderName: patientName,
                        userType: 'doctor',
                        senderImage: image,
                        receiverUserEmail: patientEmail,
                        receiverImage: image,
                        receiverUserId: data['uid']))));
          });
    } else {
      return Container();
    }
  }
}
