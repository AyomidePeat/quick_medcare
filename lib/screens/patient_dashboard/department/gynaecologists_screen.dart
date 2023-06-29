import 'package:flutter/material.dart';
import 'package:quick_medcare/screens/patient_dashboard/doctor_details.dart';

import '../../../utils/textstyle.dart';


class GynaecologistsScreen extends StatefulWidget {
  const GynaecologistsScreen({super.key});

  @override
  State<GynaecologistsScreen> createState() => _GynaecologistsScreenState();
}

class _GynaecologistsScreenState extends State<GynaecologistsScreen> {
  List time = ['10:20 AM', '02:00 PM', '4:30 PM'];
  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

    return Scaffold( appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:  Text('Meet our Gynaecologists',style:headline2(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(
                            image: 'images/christabel.jpg',
                            name: 'Dr. Christabel Gold',
                            department: 'Gynaecologist',
                            specialization: 'Child birth',
                            time: time)));
              },
              child: Row(
                children: [
                   Container(
                    height: 130,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                    image: const DecorationImage(image: AssetImage('images/christabel.jpg')),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                  ),
                      
                       
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               'Dr. Christabel Gold',
                               style: headline3(context),
                             ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:10),
                                child: Row(
                                  children: [
                                    for (int i = 0; i <= 4; i++)
                                      const Icon(Icons.star, color: Color.fromARGB(255, 255, 204, 65), size:18),
                                  ],
                                ),
                              ),
                             Text(
                               'Gynaecologist',
                               style: bodyText2(context),
                             ),
                           ],
                         ),
                       ),
                ],
              ),
            ),
           const SizedBox(height:30),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(
                            image: 'images/heritage.jpg',
                            name: 'Dr. Heritage Odewale',
                            department: 'Gynaecologist',
                            specialization: 'Ante-natal',
                            time: time)));
              },
              child: Row(
                children: [
                   Container(
                    height: 130,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                    image: const DecorationImage(image: AssetImage('images/heritage.jpg')),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                  ),
                      
                       
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(width: size.width*0.3,
                               child: Text(
                                 'Dr. Heritage Odewale',overflow: TextOverflow.fade,
                                 style: headline3(context),
                               ),
                             ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:10),
                                child: Row(
                                  children: [
                                    for (int i = 0; i <= 4; i++)
                                      const Icon(Icons.star, color: Color.fromARGB(255, 255, 204, 65), size:18),
                                  ],
                                ),
                              ),
                             Text(
                               'Gynaecologist',
                               style: bodyText2(context),
                             ),
                           ],
                         ),
                       ),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}