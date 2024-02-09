import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/widgets/main_button.dart';

import '../../utils/textstyle.dart';

class AppointmentScreen extends StatefulWidget {
   final String date; final String time;
  const AppointmentScreen({super.key, required this.date, required this.time});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: blue,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.done, color: blue, size:50).animate().fadeIn(duration:3000.ms),
                    )).animate().fadeIn(duration:3000.ms),
                SizedBox(height: 15),
                Text('Thank You!', style: headLine2(blue)),
                SizedBox(height: 8),
                Text('Your Appointment has been Created', style: headLine3(black)),
                SizedBox(height: 15),
                Text('You booked an appointment on ${widget.date} at ${widget.time}', style: bodyText3(black), textAlign: TextAlign.center),
                 SizedBox(height: MediaQuery.of(context).size.height*0.45),
                MainButton(
                    onpressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Done', style: TextStyle(color:white),),
                    height: 40,
                    width: double.infinity)
              ],
            )
          ),
        ));
  }
}
