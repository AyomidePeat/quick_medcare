import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';
import 'package:quick_medcare/screens/doctors_dashboard/doctor_appointment_widget.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    final getAppointmentRef = ref.watch(cloudStoreProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.blue[100],
          centerTitle: true,
          title: Text('Your Appointments', style: headLine3(black)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
              )),
        ),
        body: StreamBuilder(
          stream: getAppointmentRef.getappointmentsForDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(color: blue)]);
            } else {
              final appointments = snapshot.data!;
              String patient = '';
              String time = '';
              String date = '';
              for (int index = 0; index < appointments.length; index++) {
                patient = appointments[index].patient;
                time = appointments[index].time;
                date = appointments[index].date;
              }
              return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DoctorAppointmentWidget(
                          patient: patient, time: time, date: date),
                    );
                  });
            }
          },
        ));
  }
}
