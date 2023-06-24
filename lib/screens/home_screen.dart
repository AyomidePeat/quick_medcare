import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/screens/appointment_screen.dart';
import 'package:quick_medcare/screens/department/dentists_screen.dart';
import 'package:quick_medcare/screens/department/dermatologists_screen.dart';
import 'package:quick_medcare/screens/department/gynaecologists_screen.dart';
import 'package:quick_medcare/screens/department/neurologists_screen.dart';
import 'package:quick_medcare/screens/department/ophthalmologists_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/department_container.dart';
import 'package:quick_medcare/widgets/illness_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List icon = [
    'icons/tooth.png',
    'icons/skin.png',
    'icons/maternity.png',
    'icons/neurologist.png',
    'icons/eyes.png',
  ];
  List illness = ['Toothache', 'Rashes', 'Antenatal', 'Migrain', 'Eye pain'
  ];
  List date = ['21.05.2023', '10.04.2023', '09.02.2023', '04.02.2023', '06.01.2023'];
  List treatmentMode = ['physical treatment', 'online prescription','hospital visit', 'online prescription', 'online diagnosis'];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String currentDate = DateFormat('EEEE').format(DateTime.now());

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
                    Text('Hello, John 👋', style: headline3(context)),
                    SizedBox(height: 5),
                    Text(
                      'How do you feel this $currentDate?',
                      overflow: TextOverflow.fade,
                      style: bodyText3(context),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.notifications_none_sharp),
                    SizedBox(width: 5),
                    CircleAvatar(),
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
              const SizedBox(height: 25),
              Text(
                'Upcoming appointment',
                style: headline3(context),
              ),
              const SizedBox(height: 15),
              AppointmentContainer(size: size),
              const SizedBox(
                height: 25,
              ),
              Text(
                'My illness history',
                style: headline3(context),
              ),
              Flexible(
                child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                  return IllnessContainer(
                      icon: icon[index],
                      illness: illness[index],
                      treatmentMode: treatmentMode[index],
                      date: date[index]).animate().slideY(begin:3, duration:Duration(milliseconds: index*300 ));
                },
                itemCount: icon.length,)
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AppointmentScreen()));
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
                const CircleAvatar(backgroundImage: AssetImage('images/marian.jpg'),minRadius:25 ,),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Joeph Marian Adewole ',
                      style: bodyText4(context),
                    ),
                    Text('10:30AM. General Consultation',
                        style: bodyText5(context))
                  ],
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 41, 86, 233)),
              child:  Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Starts in 2 mins', style: bodyText4(context),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
