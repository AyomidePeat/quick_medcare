import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/call_feature/video_call.dart';
import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';
import 'package:quick_medcare/models/call_model.dart';
import 'package:quick_medcare/models/patient_model.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/dentists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/dermatologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/general_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/gynaecologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/neurologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/ophthalmologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/radiologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/profile_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/department_container.dart';
import 'package:quick_medcare/widgets/illness_container.dart';
import '../../utils/health_tips.dart';
import 'department/cardiologists_screen.dart';
import 'other_details.dart';

final patientDetailsProvider =
    FutureProvider<PatientDetailsModel?>((ref) async {
  final cloudStoreRef = ref.read(cloudStoreProvider);
  return cloudStoreRef.getUser();
});
final patientDpProvider = StreamProvider<String?>((ref) async* {
  final cloudStoreRef = ref.read(cloudStoreProvider);
  yield* cloudStoreRef.getDp();
});
final userImageStreamProvider = StreamProvider<String?>((ref) {
  final cloudStoreRef = ref.watch(cloudStoreProvider);
  return cloudStoreRef.getDp();
});

class HomeScreen extends ConsumerStatefulWidget {
  final String? uid;
  final ReceivedAction? receivedAction;
  const HomeScreen({super.key, this.uid, this.receivedAction});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  handleNotification() {
    if (widget.receivedAction != null) {
      Map userMap = widget.receivedAction!.payload!;
      PatientDetailsModel patient = PatientDetailsModel(
          firstName: userMap['firstName'],
          lastName: userMap['lastName'],
          gender: userMap['gender'],
          email: userMap['email'],
          uid: userMap['uid'],
          role: userMap['role']);
      Call call = Call(
          id: userMap['id'],
          caller: userMap['caller'],
          called: userMap['called'],
          rejected: jsonDecode(userMap['rejected']),
          connected: true,
          accepted: true,
          channel: userMap['channel'],
          active: jsonDecode(userMap['active']));
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return VideoCallScreen(patient: patient, call: call);
      // }));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000)).then(
      (value) => (value) {
        handleNotification();
      },
    );
    startTimer();
  }

  int currentIndex = 0;

 
 

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 7));
setState(() {
      currentIndex = (currentIndex + 1) % healthTips.length;
 startTimer();
});

  }
  

  @override
  Widget build(BuildContext context) {
    final healthTip = healthTips[currentIndex];
    final patientDetailsAsyncValue = ref.watch(patientDetailsProvider);
    final patientDp = ref.watch(patientDpProvider);
    final size = MediaQuery.of(context).size;
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    String currentDate = DateFormat('EEEE').format(DateTime.now());
    // String imageUrl = '';
    String firstName = '';
    String gender = '';
    String lastName = '';
    String patientEmail = '';
    String patientName = '';
    String patientUid = widget.uid!;
    String patientImage = '';
    String patientAge = '20';

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 245, 247),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 1,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    patientDetailsAsyncValue.when(
                      data: (patientDetails) {
                        if (patientDetails != null) {
                          firstName = patientDetails.firstName;
                          lastName = patientDetails.lastName;
                          patientEmail = patientDetails.email;
                          gender = patientDetails.gender;
                          return Text(
                            'Hello $firstName👋',
                            style: headLine3(black),
                          );
                        } else {
                          return const Text('Hello👋');
                        }
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) => Text('Error: $error'),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'How do you feel this $currentDate?',
                      overflow: TextOverflow.fade,
                      style: bodyText4(black),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                Row(
                  children: [
                    patientDp.when(
                      data: (data) {
                        if (data != null) {
                          patientImage = data;
                        }
                        return const SizedBox();
                      },
                      error: (error, stackTrace) => Text('Error: $error'),
                      loading: () => const CircularProgressIndicator(),
                    ),
                    const SizedBox(width: 5),
                    ProfilePicture(
                        cloudStoreRef: cloudStoreRef,
                        email: patientEmail,
                        firstName: firstName,
                        lastName: lastName,
                        gender: gender),
                  ],
                ),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<List<OtherInfoModel>>(
                    stream: cloudStoreRef.getUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OtherDetailsScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Complete your registration',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13, color: blue)),
                              Icon(Icons.arrow_forward_ios,
                                  color: blue, size: 15)
                            ],
                          )
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .fadeIn(duration: 1000.ms),
                        );
                      } else {
                        return const SizedBox(height: 5);
                      }
                    }),

               
                     HealthTipContainer(size: size, healthTip: healthTip),
                  
                
                const SizedBox(
                  height: 25,
                ),
                Text('Check out our Departments', style: headLine3(black)),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(width: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DepartmentContainer(
                              color: Color.fromARGB(255, 248, 143, 136),
                              screen: DentistsScreen(
                                  gender: gender,
                                  patientAge: patientAge,
                                  patientEmail: patientEmail,
                                  patientName: '$firstName $lastName',
                                  patientUid: patientUid,
                                  patientImage: patientImage),
                              icon: 'icons/tooth.png',
                              text: 'Dentistry'),
                          DepartmentContainer(
                              color: Color.fromARGB(255, 241, 192, 192),
                              screen: CardiologistsScreen(
                                  gender: gender,
                                  patientAge: patientAge,
                                  patientEmail: patientEmail,
                                  patientName: patientName,
                                  patientUid: patientUid,
                                  patientImage: patientImage),
                              icon: 'images/heart.png',
                              text: 'Cardiology'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DepartmentContainer(
                              color: Color.fromARGB(255, 199, 222, 243),
                              screen: DermatologistsScreen(
                                  gender: gender,
                                  patientAge: patientAge,
                                  patientEmail: patientEmail,
                                  patientName: patientName,
                                  patientUid: patientUid,
                                  patientImage: patientImage),
                              icon: 'icons/skin.png',
                              text: 'Dermatology'),
                          DepartmentContainer(
                              color: Color.fromARGB(255, 218, 218, 218),
                              screen: GeneralDoctorsScreen(
                                  gender: gender,
                                  patientAge: patientAge,
                                  patientEmail: patientEmail,
                                  patientName: patientName,
                                  patientUid: patientUid,
                                  patientImage: patientImage),
                              icon: 'images/stethoscope.png',
                              text: 'General Doctors'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DepartmentContainer(
                              color: Color.fromARGB(255, 167, 198, 243),
                              icon: 'icons/maternity.png',
                              screen: GynaecologistsScreen(
                                  gender: gender,
                                  patientAge: patientAge,
                                  patientEmail: patientEmail,
                                  patientName: patientName,
                                  patientUid: patientUid,
                                  patientImage: patientImage),
                              text: 'Gynaecology'),
                          DepartmentContainer(
                              color: Color.fromARGB(255, 194, 241, 192),
                              screen: NeurologistsScreen(
                                  gender: gender,
                                  patientAge: patientAge,
                                  patientEmail: patientEmail,
                                  patientName: '$firstName $lastName',
                                  patientUid: patientUid,
                                  patientImage: patientImage),
                              icon: 'icons/neurologist.png',
                              text: 'Neurology'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DepartmentContainer(
                              color: Color.fromARGB(255, 240, 224, 181),
                              screen: OphthalmologistsScreen(
                                  gender: gender,
                                  patientAge: patientAge,
                                  patientEmail: patientEmail,
                                  patientName: patientName,
                                  patientUid: patientUid,
                                  patientImage: patientImage),
                              icon: 'icons/eyes.png',
                              text: 'Ophthalmology'),
                          DepartmentContainer(
                              color: Color.fromARGB(255, 240, 224, 181),
                              screen: RadiologistsScreen(
                                  gender: gender,
                                  patientAge: patientAge,
                                  patientEmail: patientEmail,
                                  patientName: patientName,
                                  patientUid: patientUid,
                                  patientImage: patientImage),
                              icon: 'icons/xray.png',
                              text: 'Radiology'),
                        ],
                      ),
                    ],
                  ),
                ),
                // Text(
                //   'My illness history',
                //   style: headLine3(black),
                // ),
                // IllnessHistory(cloudStoreRef: cloudStoreRef),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.cloudStoreRef,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
  });

  final FirestoreClass cloudStoreRef;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: cloudStoreRef.getDp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final imageUrl = snapshot.data;

          return GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl!),
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                        email: email,
                        image: imageUrl,
                        name: '$firstName $lastName',
                        gender: gender,
                        id: '001'))),
          );
        } else {
          return CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50,
            backgroundImage: Image.asset('images/userIcon.png').image,
          );
        }
      },
    );
  }
}

class IllnessHistory extends StatelessWidget {
  const IllnessHistory({
    super.key,
    required this.cloudStoreRef,
  });

  final FirestoreClass cloudStoreRef;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: cloudStoreRef.getIllnessHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(color: blue);
          } else {
            final illnessDetails = snapshot.data!;
            if (illnessDetails.isNotEmpty) {
              int index = 0;
              String date = illnessDetails[index].date;
              String treatmentMode = illnessDetails[index].treatmentMode;
              String illness = illnessDetails[index].illness;
              return Flexible(
                  child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return IllnessContainer(
                          icon: 'icons/sick.png',
                          illness: illness[index],
                          treatmentMode: treatmentMode[index],
                          date: date[index])
                      .animate()
                      .slideY(
                          begin: 3,
                          duration: Duration(milliseconds: index * 300));
                },
                itemCount: illnessDetails.length,
              ));
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    Image.asset('icons/record.png'),
                    const Text('You have no sickness history'),
                  ],
                ),
              );
            }
          }
        });
  }
}

class HealthTipContainer extends StatelessWidget {
  const HealthTipContainer({
    super.key,
    required this.healthTip,
    required this.size,
  });

  final Size size;
  final healthTip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      height: size.height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: blue,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              healthTip['title'],
              style: headLine1(white),
            ),
            const SizedBox(height: 5),
            Text(healthTip['content'], style: bodyText4(white)),
          ],
        ),
      ),
    );
  }
}
