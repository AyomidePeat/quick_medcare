import 'package:flutter/material.dart';

import '../../widgets/doctor_container.dart';

class GynaecologistsScreen extends StatefulWidget {
  const GynaecologistsScreen({super.key});

  @override
  State<GynaecologistsScreen> createState() => _GynaecologistsScreenState();
}

class _GynaecologistsScreenState extends State<GynaecologistsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(children: [
      DoctorContainer(
                          image: 'images/christabel.jpg',
                          name: 'Dr. Christabel Gold',
                          role: 'Gynaecologist'),
                      DoctorContainer(
                          image: 'images/heritage.jpg',
                          name: 'Dr. Heritage Odewale',
                          role: 'Gynaecologist'),
    ],),);
  }
}