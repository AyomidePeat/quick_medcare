import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';
import 'package:quick_medcare/models/patient_model.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/dentists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/dermatologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/general_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/gynaecologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/neurologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/ophthalmologists_screen.dart';
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
  final String uid;
  const HomeScreen({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    ;
  }

  final currentIndexNotifier = ValueNotifier<int>(0);

//   void startTimer() async {
//     await Future.delayed(const Duration(seconds: 2));
// setState(() {
//       currentIndex = (currentIndex + 1) % healthTips.length;

// });

//   }
  void startTimer() async {
    await Future.delayed(const Duration(seconds: 2));

    currentIndex = (currentIndex + 1) % healthTips.length;
    currentIndexNotifier.value = currentIndex;
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
    String patientUid = widget.uid;
    String patientImage = '';
    String patientAge = '20';

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0,
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
                        error:  (error, stackTrace) => Text('Error: $error'),
                        loading: ()=>const CircularProgressIndicator(),),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    DepartmentContainer(
                        screen: DentistsScreen(
                            
                            gender: gender,
                            patientAge: patientAge,
                            patientEmail: patientEmail,
                            patientName: '$firstName $lastName',
                            patientUid: patientUid,
                            patientImage: patientImage),
                        icon: 'icons/tooth.png',
                        text: 'Dentistry'),
                    const SizedBox(width: 20),
                    DepartmentContainer(
                        screen: CardiologistsScreen(
                            gender: gender,
                            patientAge: patientAge,
                            patientEmail: patientEmail,
                            patientName: patientName,
                            patientUid: patientUid,
                            patientImage: patientImage),
                        icon: 'images/heart.png',
                        text: 'Cardiology'),
                    const SizedBox(width: 20),
                    DepartmentContainer(
                        screen: DermatologistsScreen(
                            gender: gender,
                            patientAge: patientAge,
                            patientEmail: patientEmail,
                            patientName: patientName,
                            patientUid: patientUid,
                            patientImage: patientImage),
                        icon: 'icons/skin.png',
                        text: 'Dermatology'),
                    const SizedBox(width: 20),
                    DepartmentContainer(
                        screen: GeneralDoctorsScreen(
                            gender: gender,
                            patientAge: patientAge,
                            patientEmail: patientEmail,
                            patientName: patientName,
                            patientUid: patientUid,
                            patientImage: patientImage),
                        icon: 'images/stethoscope.png',
                        text: 'General Doctors'),
                    DepartmentContainer(
                        icon: 'images/maternity.png',
                        screen: GynaecologistsScreen(
                            gender: gender,
                            patientAge: patientAge,
                            patientEmail: patientEmail,
                            patientName: patientName,
                            patientUid: patientUid,
                            patientImage: patientImage),
                        text: 'Gynaecology'),
                    const SizedBox(width: 20),
                    DepartmentContainer(
                        screen: NeurologistsScreen(
                            gender: gender,
                            patientAge: patientAge,
                            patientEmail: patientEmail,
                            patientName: '$firstName $lastName',
                            patientUid: patientUid,
                            patientImage: patientImage),
                        icon: 'icons/neurologist.png',
                        text: 'Neurology'),
                    const SizedBox(width: 20),
                    DepartmentContainer(
                        screen: OphthalmologistsScreen(
                            gender: gender,
                            patientAge: patientAge,
                            patientEmail: patientEmail,
                            patientName: patientName,
                            patientUid: patientUid,
                            patientImage: patientImage),
                        icon: 'icons/eyes.png',
                        text: 'Ophthalmology'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                            Icon(Icons.arrow_forward_ios, color: blue, size: 15)
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
              Text(
                'Health Tips for You',
                style: headLine3(black),
              ),
              const SizedBox(height: 15),
              ValueListenableBuilder<int>(
                valueListenable: currentIndexNotifier,
                builder: (context, currentIndex, child) {
                  final healthTip = healthTips[currentIndex];
                  return HealthTipContainer(size: size, healthTip: healthTip);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'My illness history',
                style: headLine3(black),
              ),
              IllnessHistory(cloudStoreRef: cloudStoreRef),
            ],
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
      height: size.height * 0.16,
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
              healthTip['title'].toString(),
              style: headLine1(white),
            ),
            const SizedBox(height: 5),
            Text(healthTip['content'].toString(), style: bodyText4(white)),
          ],
        ),
      ),
    );
  }
}
