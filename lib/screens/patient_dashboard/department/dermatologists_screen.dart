import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:quick_medcare/screens/patient_dashboard/doctor_details.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

import 'package:quick_medcare/widgets/doctor_container.dart';

import '../../../widgets/main_button.dart';

class DermatologistsScreen extends StatefulWidget {
  final String patientAge;
  final String patientEmail;
  final String patientName;
  final String patientUid;
  final String patientImage;
  final String gender;
  const DermatologistsScreen(
      {super.key,
      required this.patientAge,
      required this.patientEmail,
      required this.patientName,
      required this.patientUid,
      required this.patientImage, required this.gender});

  @override
  State<DermatologistsScreen> createState() => _DermatologistsScreenState();
}

class _DermatologistsScreenState extends State<DermatologistsScreen> {
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:  Icon(
                Icons.arrow_back_ios,color: white,
              )),
          title:  Text("Meet our Dermatologists",style: headLine2(white),),
        ),
        body: buildUserList());
  }

  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore.collection('Dermatology').snapshots(),
        builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final doctors = snapshot.data!.docs;
            if (doctors.isNotEmpty) {
              return ListView(
                children: doctors
                    .map<Widget>((doc) => buildUserListItem(doc))
                    .toList(),
              );
            }
          }
          return Center(
            child: Text('Coming Soon...', style: headLine2(blue))
                .animate()
                .scaleXY(duration: 1000.ms),
          );
        });
  }

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    final name = '${data['firstName']} ${data['lastName']}';
    final role = data['department'];
    final image = data['image'];
    final specialization = data['specialization'];
    final info = data['info'];
    final numberOfPatients = data['numberOfPatients'];
    final experience = data['experience'];
    final email = data['email'];
    final uid = data['uid'];

    if (auth.currentUser!.email != data['email']) {
      return ListTile(
        title:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DoctorContainer(image: image, name: name, role: role),
            MainButton(
                onpressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DoctorDetailsScreen( senderUid: widget.patientUid,
                              senderName: widget.patientName,
                              receiverEmail: widget.patientEmail,
                              senderImage: widget.patientImage,
                              receiverName: name,
                              gender: widget.gender,
                              image: image,
                              department: 'Dermatology',
                              specialization: specialization,
                              info: info,
                              experience: experience,
                              senderEmail: email,
                              uid: uid,
                              numberOfPatients: numberOfPatients))));
                },
                height: 40,
                width: 150,
                child:  Text('View Profile',style: bodyText3(white),))
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
