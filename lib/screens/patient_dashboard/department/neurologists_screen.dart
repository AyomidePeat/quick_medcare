import 'package:flutter/material.dart';

import '../../../widgets/doctor_container.dart';

class NeurologistsScreen extends StatefulWidget {
  const NeurologistsScreen({super.key});

  @override
  State<NeurologistsScreen> createState() => _NeurologistsScreenState();
}

class _NeurologistsScreenState extends State<NeurologistsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body:Row(
                    children: [
                      DoctorContainer(
                          image: 'images/marian.jpg',
                          name: 'Dr. Marian Adewole',
                          role: 'Neurologist'),
                    ],
    ));
  }
}