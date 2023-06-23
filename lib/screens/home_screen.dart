import 'package:flutter/material.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
   { 
 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String currentDate =
        DateFormat(' EEEE, MMMM dd, yyyy').format(DateTime.now());

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
                    Text('Hello, John ', style: headline2(context)),
                    SizedBox(height:5),
                    Text(
                      'How do you feel today?',
                      overflow: TextOverflow.fade,
                      style: bodyText3(context),
                    ),
                    const SizedBox(height: 5),
                    Text(currentDate,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 230, 225, 225),
                            fontFamily: 'Poppins-Regular')),
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
              const SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    
                    DepartmentContainer(screen: DentistsScreen(),
                        text: 'Dentistry'),
                          SizedBox(width:20),
                    DepartmentContainer(screen: DermatologistsScreen(),
                        text: 'Dermatology'),
                          SizedBox(width:20),
                          DepartmentContainer(screen: GynaecologistsScreen(),
                        text: 'Gynaecology'),
                        SizedBox(width:20),
                         DepartmentContainer(screen: NeurologistsScreen(),
                        text: 'Neurology'),
                        SizedBox(width:20),
                    DepartmentContainer(screen: OphthalmologistsScreen(),
                        text: 'Ophthalmology'),
                          
                   
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'Upcoming appointment',
                style: bodyText2(context),
              ),
              const SizedBox(height: 15),
              Container(
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
                          const CircleAvatar(),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. Christabel Heritage ',
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
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text('Starts in 2 mins'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
             
              const SizedBox(height: 25),
              
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
