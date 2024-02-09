import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/appointment_widget.dart';

class BookedAppointments extends ConsumerStatefulWidget {
  const BookedAppointments({super.key});

  @override
  ConsumerState<BookedAppointments> createState() => _BookedAppointmentsState();
}

class _BookedAppointmentsState extends ConsumerState<BookedAppointments> {
  @override
  Widget build(BuildContext context) {
    final getAppointmentRef = ref.watch(cloudStoreProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: blue,
          centerTitle: true,
          title: Text('Booked Appointments', style: headLine3(white)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: white,
              )),
        ),
        body: StreamBuilder(
          stream: getAppointmentRef.getappointmentsForPatients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(color: blue)]);
            }if (snapshot.data!.isEmpty) {
              return Center(
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Image.asset('icons/record.png', height: 200, width: 200),
                const SizedBox(height: 25),
                const Text('You have not booked appointment yet'),
              ],
            ),
          );
            } else {
              final appointments = snapshot.data!;
              String doctor = '';
              String time = '';
              String date = '';
              for (int index = 0; index < appointments.length; index++) {
                doctor = appointments[index].doctor;
                time = appointments[index].time;
                date = appointments[index].date;
              }
              return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AppointmentWidget(
                          doctor: doctor, time: time, date: date),
                    );
                  });
            }
          },
        ));
  }
}
