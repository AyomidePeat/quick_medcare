import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/widgets/calendar_widget.dart';
import 'package:quick_medcare/widgets/main_button.dart';

import '../../utils/textstyle.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  var pickedDate;

  TimeOfDay? _selectedTime;
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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: blue,
          centerTitle: true,
          title: Text('Book an appointment', style: headLine3(white)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // CalenderWidget(
              // ),
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
              MainButton(
                  onpressed: () {
                    print(
                        'Selected Time: $_selectedTime, Selected date : $pickedDate');
                  },
                  child: Text('Print date'),
                  height: 40,
                  width: 100)
            ],
          ),
        ));
  }
}
