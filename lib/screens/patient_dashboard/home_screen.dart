import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';
import 'package:quick_medcare/models/patient_model.dart';
import 'package:quick_medcare/screens/patient_dashboard/appointment_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/dentists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/dermatologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/gynaecologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/neurologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/department/ophthalmologists_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/profile_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/department_container.dart';
import 'package:quick_medcare/widgets/illness_container.dart';

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
  List icon = [
    'icons/tooth.png',
    'icons/skin.png',
    'icons/maternity.png',
    'icons/neurologist.png',
    'icons/eyes.png',
  ];
  List illness = ['Toothache', 'Rashes', 'Antenatal', 'Migrain', 'Eye pain'];
  List date = [
    '21.05.2023',
    '10.04.2023',
    '09.02.2023',
    '04.02.2023',
    '06.01.2023'
  ];
  List treatmentMode = [
    'physical treatment',
    'online prescription',
    'hospital visit',
    'online prescription',
    'online diagnosis'
  ];
  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    final size = MediaQuery.of(context).size;
    String currentDate = DateFormat('EEEE').format(DateTime.now());
    String? imageUrl = 'images/userIcon.png';
    String firstName = '';
    String gender = '';
    String lastName = '';
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
                    const Icon(Icons.notifications_none_sharp),
                    const SizedBox(width: 5),
                    FutureBuilder<String?>(
                     future: cloudStoreRef.getDpWithListener((newImageUrl) {
    setState(() {
      imageUrl = newImageUrl;
    });
  }),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            backgroundImage:
                                Image.asset('images/userIcon.png').image,
                          );
                        } else {
                          
                            imageUrl = snapshot.data!                           ;

                        
                          return GestureDetector(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl!),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen(image:imageUrl,
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
                    DepartmentContainer(
                        screen: DentistsScreen(),
                        icon: 'icons/tooth.png',
                        text: 'Dentistry'),
                    SizedBox(width: 20),
                    DepartmentContainer(
                        screen: DermatologistsScreen(),
                        icon: 'icons/skin.png',
                        text: 'Dermatology'),
                    SizedBox(width: 20),
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
                'Upcoming appointment',
                style: headLine3(black),
              ),
              const SizedBox(height: 15),
              AppointmentContainer(size: size),
              const SizedBox(
                height: 25,
              ),
              Text(
                'My illness history',
                style: headLine3(black),
              ),
              Flexible(
                  child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return IllnessContainer(
                          icon: icon[index],
                          illness: illness[index],
                          treatmentMode: treatmentMode[index],
                          date: date[index])
                      .animate()
                      .slideY(
                          begin: 3,
                          duration: Duration(milliseconds: index * 300));
                },
                itemCount: icon.length,
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AppointmentScreen()));
          },
          backgroundColor: blue,
          tooltip: 'Book Appointment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class AppointmentContainer extends StatelessWidget {
  const AppointmentContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: blue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('images/marian.jpg'),
                  minRadius: 25,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Joeph Marian Adewole ',
                      style: bodyText2(white),
                    ),
                    Text('10:30AM. General Consultation',
                        style: bodyText4(white))
                  ],
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 41, 86, 233)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Starts in 2 mins',
                  style: bodyText3(white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
