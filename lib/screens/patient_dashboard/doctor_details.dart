import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/screens/patient_dashboard/appointment_screen.dart';

import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/calendar_widget.dart';

import '../../chatting/chat_screen.dart';
import '../../widgets/main_button.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String image;
  final String receiverName;
  final String department;
  final String specialization;
  final String info;
  final String experience;
  final String numberOfPatients;
  final String receiverEmail;
  final String uid;
  final String senderName;
  final String senderEmail;
  final String senderImage;
  final String gender;
  final String senderUid;

  const DoctorDetailsScreen(
      {super.key,
      required this.image,
      required this.department,
      required this.specialization,
      required this.info,
      required this.experience,
      required this.numberOfPatients,
      required this.uid,
      required this.receiverName,
      required this.receiverEmail,
      required this.senderName,
      required this.senderEmail,
      required this.senderImage,
      required this.gender,
      required this.senderUid});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  bool textRead = false;
  final appointmentController = TextEditingController();
  TimeOfDay? _selectedTime;
  var pickedDate;
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Select Preferred Time',
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData(),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.3,
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                  color: blue, borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                    color: white,
                  ),
                  const SizedBox(width: 40),
                  Center(
                      child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    radius: 100,
                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${widget.receiverName}',
                    overflow: TextOverflow.fade,
                    style: headLine2(black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.department} • ${widget.experience} years of practice',
                    style: bodyText4(black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people, color: Colors.green),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Treated over ${widget.numberOfPatients} patients',
                        style: bodyText4(black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: blue,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('Works 8am - 4pm', style: bodyText4(black))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MainButton(
                          onpressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                        senderUid: widget.senderUid,
                                        gender: widget.gender,
                                        receiverUserEmail: widget.receiverEmail,
                                        receiverUserId: widget.uid,
                                        receiverName: widget.receiverName,
                                        senderName: widget.senderName,
                                        senderEmail: widget.senderEmail,
                                        receiverImage: widget.image,
                                        senderImage: widget.senderImage,
                                        userType: 'patient')));
                          },
                          height: 40,
                          width: double.infinity,
                          child: Text(
                            'Chat with doctor',
                            style: TextStyle(color: white),
                          ))
                      .animate()
                      .then(duration: 300.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(duration: 500.ms, begin: 3),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: blue),
                    child: Text(
                      'About',
                      style: headLine4(white),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ExpandableText(widget.info, readMoreText: 'Read more',
                      onLinkPressed: (readMore) {
                    setState(() {
                      textRead = readMore;
                    });
                  },
                      readLessText: "Show less",
                      linkTextStyle: headLine4(black),
                      trimType: TrimType.lines,
                      trim: textRead ? 29 : 10,
                      style: bodyText4(black)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: blue),
                    child: Text(
                      'Book an appointment',
                      style: headLine4(white),
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () async {
                      DateTime? pickeddate = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CalenderWidget();
                        },
                      );

                      if (pickeddate != null) {
                        setState(() {
                          pickedDate = DateFormat('EEEE, MMMM dd, yyyy')
                              .format(pickeddate);
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pickedDate != null
                                ? pickedDate
                                : 'Select a Convinient Date',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedTime != null
                                ? _selectedTime!.format(context)
                                : 'Select a Convinient Time',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: appointmentController,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: 'Enter Appointment note',
                          border: InputBorder.none),
                    ),
                  ),
                   SizedBox(height: 15),
                  MainButton(
                    onpressed: () {},
                    child: Text(
                      'Book appointment with Dr. ${widget.receiverName}',
                      style: TextStyle(color: white),
                    ),
                    height: 40,
                    width: double.infinity,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  final String details;
  final String aspect;
  final icon;
  final Color color;
  const DetailsContainer({
    super.key,
    required this.size,
    required this.details,
    required this.aspect,
    required this.icon,
    required this.color,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 0.29,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details,
                  style: headLine4(black),
                ),
                Text(
                  aspect,
                  style: bodyText3(black),
                )
              ],
            ),
          ],
        ));
  }
}
