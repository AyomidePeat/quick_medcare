import 'package:flutter/material.dart';

import '../../widgets/doctor_container.dart';

class DermatologistsScreen extends StatefulWidget {
  const DermatologistsScreen({super.key});

  @override
  State<DermatologistsScreen> createState() => _DermatologistsScreenState();
}

class _DermatologistsScreenState extends State<DermatologistsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Row(
                    children: [
                      DoctorContainer(
                          image: 'images/joseph.jpg',
                          name: 'Dr. Joseph James',
                          role: 'Dermatologist'),
                    ],
                  ),);
  }
}