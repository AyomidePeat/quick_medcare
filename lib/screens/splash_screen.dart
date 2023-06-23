import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quick_medcare/screens/onboarding/sign_up_screen.dart';
import 'package:quick_medcare/widgets/main_button.dart';

import '../utils/colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 41, 86, 233),
        body: Column(
          
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 0,
                  ),
                  Text(
                    'Exceptional Care\nJust for You.',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: white,
                        fontFamily: 'Poppins-Regular'),
                  ).animate().slideY(duration: 1500.ms),
                  const SizedBox(height: 10),
                  Text(
                    'Say yes to Fast, Easy, and Affordable urgent care!',
                    style: TextStyle(
                        fontSize: 15,
                        color: white,
                        fontFamily: 'Poppins-Regular'),
                  )
                      .animate()
                      .then(duration: 500.ms)
                      .slideY(begin: 3, duration: 1500.ms),
                  const SizedBox(height: 20),
                  MainButton(
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      height: 40,
                      width: 170,
                      child: Row(children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: white,
                              fontFamily: 'Poppins-Regular'),
                        ),
                        Icon(Icons.arrow_forward, color: white)
                      ])).animate().fadeIn(delay: 1500.ms, duration: 1500.ms),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SizedBox(
                height: size.height * 0.5,
                child: Image.asset(
                  'images/doctor.png',
                  fit: BoxFit.fitHeight,
                )).animate().then(duration: 500.ms).fadeIn(duration: 1300.ms)
          ],
        ));
  }
}
