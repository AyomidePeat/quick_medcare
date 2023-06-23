import 'package:flutter/material.dart';

import '../../widgets/doctor_container.dart';

class OphthalmologistsScreen extends StatefulWidget {
  const OphthalmologistsScreen({super.key});

  @override
  State<OphthalmologistsScreen> createState() => _OphthalmologistsScreenState();
}

class _OphthalmologistsScreenState extends State<OphthalmologistsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body:  Row(
                    children: [
                      DoctorContainer(
                          image: 'images/marvin.jpg',
                          name: 'Dr. Marvin Klein',
                          role: 'Ophthalmologist'),
                    ],
                  ),);
  }
}