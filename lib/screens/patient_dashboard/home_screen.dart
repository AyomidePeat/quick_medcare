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

final cloudStoreDocsProvider = FutureProvider((ref) async {
  cloudStoreProvider;
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 20));
    setState(() {
      currentIndex = (currentIndex + 1) % healthTips.length;
      startTimer();
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final healthTip = healthTips[currentIndex];
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    final size = MediaQuery.of(context).size;
    String currentDate = DateFormat('EEEE').format(DateTime.now());
    String? imageUrl = 'images/userIcon.png';
    String firstName = '';
    String gender = '';
    String lastName = '';
    String email = '';
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
                    FutureBuilder<PatientDetailsModel?>(
                        future: cloudStoreRef.getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Hello',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ));
                          } else {
                            if (snapshot.hasData && snapshot.data != null) {
                              PatientDetailsModel getPatientDetails =
                                  snapshot.data!;
                              firstName = getPatientDetails.firstName;
                              gender = getPatientDetails.gender;
                              lastName = getPatientDetails.lastName;
                              email = getPatientDetails.email;
                              return Text(
                                'Hello $firstName👋',
                                style: headLine3(black),
                              );
                            } else {
                              return const Text('Hello👋');
                            }
                          }
                        }),
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
                    const SizedBox(width: 5),
                    StreamBuilder<String?>(
                      stream: cloudStoreRef.getDp(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError || snapshot.data == null) {
                          return CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            backgroundImage:
                                Image.asset('images/userIcon.png').image,
                          );
                        } else {
                          
                          imageUrl = snapshot.data;

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
                        }
                      },
                    ),
                  ],
                ),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    DepartmentContainer(
                        screen: DentistsScreen(),
                        icon: 'icons/tooth.png',
                        text: 'Dentistry'),
                    SizedBox(width: 20),
                    DepartmentContainer(
                        screen: CardiologistsScreen(),
                        icon: 'icons/heart.png',
                        text: 'Cardiology'),
                    SizedBox(width: 20),
                    DepartmentContainer(
                        screen: DermatologistsScreen(),
                        icon: 'icons/skin.png',
                        text: 'Dermatology'),
                    SizedBox(width: 20),
                    DepartmentContainer(
                        screen: GeneralDoctorsScreen(),
                        icon: 'icons/stethoscope.png',
                        text: 'General Doctors'),
                    DepartmentContainer(
                        screen: GynaecologistsScreen(),
                        icon: 'icons/maternity.png',
                        text: 'Gynaecology'),
                    SizedBox(width: 20),
                    DepartmentContainer(
                        screen: NeurologistsScreen(),
                        icon: 'icons/neurologist.png',
                        text: 'Neurology'),
                    SizedBox(width: 20),
                    DepartmentContainer(
                        screen: OphthalmologistsScreen(),
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
              HealthTipContainer(size: size, healthTip: healthTip),
              const SizedBox(
                height: 25,
              ),
              Text(
                'My illness history',
                style: headLine3(black),
              ),
              StreamBuilder(
                  stream: cloudStoreRef.getIllnessHistory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: blue);
                    } else {
                      final illnessDetails = snapshot.data!;
                      if (illnessDetails.isNotEmpty) {
                        int index = 0;
                        String date = illnessDetails[index].date;
                        String treatmentMode =
                            illnessDetails[index].treatmentMode;
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
                                    duration:
                                        Duration(milliseconds: index * 300));
                          },
                          itemCount: illnessDetails.length,
                        ));
                      } else {
                        return Center(
                          child: Column(mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              SizedBox(height:70),
                              Image.asset('images/record.png'),
                              const Text('You have no sickness history'),
                            ],
                          ),
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
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
            SizedBox(height: 10),
            Text(
              healthTip['title'].toString(),
              style: headLine1(white),
            ),
                        SizedBox(height: 5),

            Text(healthTip['content'].toString(), style: bodyText4(white)),
          ],
        ),
      ),
    );
  }
}
