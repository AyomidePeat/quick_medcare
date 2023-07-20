import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:quick_medcare/screens/patient_dashboard/doctor_details.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

import 'package:quick_medcare/widgets/doctor_container.dart';

class CardiologistsScreen extends StatefulWidget {
  const CardiologistsScreen({super.key});

  @override
  State<CardiologistsScreen> createState() => _CardiologistsScreenState();
}

class _CardiologistsScreenState extends State<CardiologistsScreen> {
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                
              )),
          title: const Text("Meet our Cardiologists"),
        ),
        body: buildUserList());
  }

  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore
            .collection('cardiologists')
            .snapshots(),
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
            return Center(child:  Text('Coming soon...', style: headLine2(black),));
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => buildUserListItem(doc))
                .toList(),
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
          title: DoctorContainer(image: image, name: name, role: role),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => DoctorDetailsScreen(
                        image: image,
                        name: name,
                        department: 'Cardiology',
                        specialization: specialization,
                        info: info,
                        experience: experience,
                        email: email,
                        uid: uid,
                        numberOfPatients: numberOfPatients))));
          });
    } else {
       return Center(child:  Text('Coming soon...', style: headLine2(black),));
    }
  }
}