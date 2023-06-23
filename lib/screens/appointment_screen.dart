import 'package:flutter/material.dart';
import 'package:quick_medcare/widgets/calendar_widget.dart';



class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
   String department = 'Gynaecology';
   TimeOfDay? _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Select Preferred Time',
      builder: (context, Widget? child) {
        return  Theme(
        data: ThemeData(
          
        ),child: child!,
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          const CalenderWidget(),
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
                  ? _selectedTime!. format(context)
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
    //  DropdownButton<String>(
    //                       dropdownColor: const Color.fromARGB(255, 32, 68, 97),
    //                       value: 'Gynaecology',
    //                       onChanged: (newValue) {
    //                         setState(() {
    //                           department = newValue!;
    //                         });
    //                       },
    //                       items: <String>[
    //                         'Neurosurgery',
    //                         'Dentistry',
    //                         'Ophthamology',
    //                         'Dermatology'
    //                         'Gynaecology'
                            
    //                       ].map<DropdownMenuItem<String>>((String value) {
    //                         return DropdownMenuItem<String>(
    //                           value: value,
    //                           child: Text(
    //                             value,
    //                             style: const TextStyle(
    //                                 //fontFamily: 'Poppins',
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 14),
    //                           ),
    //                         );
    //                       }).toList(),
    //                     ),
        ],),
      )
    );
  }
}
