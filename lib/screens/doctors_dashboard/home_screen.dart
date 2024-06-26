import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quick_medcare/models/doctor_model.dart';
import 'package:quick_medcare/screens/chat_list_screen.dart';
import 'package:quick_medcare/screens/doctors_dashboard/add_patient_details.dart';
import 'package:quick_medcare/screens/doctors_dashboard/appointments_screen.dart';
import 'package:quick_medcare/screens/doctors_dashboard/patient_file.dart';
import 'package:quick_medcare/widgets/patient_container.dart';
import '../../firebase_reposisitories/cloud_firestore.dart';
import '../../utils/colors.dart';
import '../../utils/textstyle.dart';

final doctorDetailsProvider = FutureProvider<DoctorDetailsModel?>((ref) async {
  final cloudStoreRef = ref.read(cloudStoreProvider);
  return cloudStoreRef.getDoctor();
});

class DoctorHomeScreen extends ConsumerStatefulWidget {
  final String uid;
  const DoctorHomeScreen({super.key, required this.uid});

  @override
  ConsumerState<DoctorHomeScreen> createState() =>
      _DoctorHomeScreenConsumerState();
}

class _DoctorHomeScreenConsumerState extends ConsumerState<DoctorHomeScreen> {
  int regNo = 09457;

  String doctorImage = '';
  String firstName = '';
  String lastName = '';
  String doctorEmail = '';
  String gender = '';
  late String doctorName = '$firstName $lastName';
  String patientName = '';
  String patientEmail = '';
  String patientId = '';
  String patientImage = '';
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  String category = 'Online';

  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);

    //final patientDetails = ref.watch(patientDetailsProvider);
    final doctorDetails = ref.watch(doctorDetailsProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[100],
        centerTitle: false,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePicture(cloudStoreRef: cloudStoreRef),
            doctorDetails.when(
                data: (doctorsDetails) {
                  if (doctorsDetails != null) {
                    firstName = doctorsDetails.firstName;
                    lastName = doctorsDetails.lastName;
                    doctorEmail = doctorsDetails.email;
                    // doctorImage = doctorsDetails.image;

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Dr. $doctorName', style: headLine3(black)),
                    );
                  } else {
                    return const Text('');
                  }
                },
                error: (error, stackTrace) => Text('Error: $error'),
                loading: () => const SizedBox()),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_sharp),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppointmentsScreen()));
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatListScreen(
                            doctorId: widget.uid,
                            senderEmail: doctorEmail,
                            userType: 'doctor',
                            senderImage: doctorImage,
                            senderName: doctorName)));
              },
              icon: Icon(Icons.message, color: blue))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          buildPatientList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: blue,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const AddPatientDetails())));
          },
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
          )),
    );
  }

  Widget buildPatientList() {
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseFirestore
          .collection('${widget.uid}patient-details')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error.toString()}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
                LoadingAnimationWidget.staggeredDotsWave(color: blue, size: 20),
          );
        }
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return Flexible(
            child: ListView(
              children: snapshot.data!.docs
                  .map<Widget>((doc) => buildPatientListItem(doc))
                  .toList(),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Image.asset('icons/record.png', height: 200, width: 200),
                const SizedBox(height: 25),
                const Text('You have no patients yet'),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildPatientListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    final patientEmail = data['email'];
    final patientName = data['fullName'];

    gender = data['gender'];

    if (auth.currentUser!.email != data['email']) {
      return ListTile(
          title: PatientContainer(
            name: patientName,
            email: patientEmail,
            // gender: gender,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => PatientFile(
                        email: patientEmail,
                        fullName: patientName,
                        uid: widget.uid))));
          });
    } else {
      return Container();
    }
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.cloudStoreRef,
  });
  final FirestoreClass cloudStoreRef;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: cloudStoreRef.getDoctorDp(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final imageUrl = snapshot.data;

          return GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl!),
              ));
        } else {
          return CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50,
            backgroundImage: Image.asset('images/userIcon.png').image,
          );
        }
      }),
    );
  }
}
