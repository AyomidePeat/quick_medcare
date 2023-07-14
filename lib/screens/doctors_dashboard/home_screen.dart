import 'package:flutter/material.dart';
import 'package:quick_medcare/screens/doctors_dashboard/patient_file.dart';
import 'package:quick_medcare/widgets/custom_container.dart';

import '../../utils/colors.dart';
import '../../utils/textstyle.dart';
import '../../widgets/main_button.dart';

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  int regNo = 09457;
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
          children: [
            TextField(
              cursorColor: black,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Search Patient',
                  hintStyle: bodyText2(context),
                  fillColor: white,
                  filled: true,
                  prefixIcon: const Icon(Icons.search)),
            ),
            const SizedBox(height: 20),
            const AppointmentContainer(),
            const SizedBox(height: 20),
            Text('Recent patients', style: bodyText1(context)),
            Flexible(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: CustomContainer(
                        color: Colors.transparent,
                        height: 130,
                        width: double.infinity,
                        border: Border.all(width: 0.4, color: Colors.lightBlue),
                        child: Row(
                          children: [
                            CustomContainer(
                                color: Colors.transparent,
                                height: 100,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Image.asset('images/patient.jpg'),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jane Doe',
                                    style: headLine4(black),
                                  ),
                                  Text(
                                    '$category',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 10,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'ID No: $regNo',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 10,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MainButton(
                                      height: 30,
                                      width: 120,
                                      onpressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PatientFile()));
                                      },
                                      child: const Text(
                                        'View Profile',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Regular',
                                            fontSize: 10,
                                            color: Colors.white),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentContainer extends StatelessWidget {
  const AppointmentContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.2,
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
                  backgroundImage: AssetImage('images/patient.jpg'),
                  minRadius: 25,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: bodyText3(black),
                    ),
                    Text('10:30AM. General Consultation',
                        style: bodyText3(black))
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
                  style: bodyText3(black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
