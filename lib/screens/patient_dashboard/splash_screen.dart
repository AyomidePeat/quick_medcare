import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_up_screen.dart';
import 'package:quick_medcare/widgets/main_button.dart';

import '../../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    Future.delayed(const Duration(seconds: 5), () async {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 41, 86, 233),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(
                height: size.height * 0.15,
                ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'QUICK MEDCARE',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: white,
                          fontFamily: 'Poppins-Regular'),
                    ).animate().slideY(duration: 1500.ms),
                    const SizedBox(height: 10),
                    Text(
                      'Exceptional Care Just for You.',
                      style: TextStyle(
                          fontSize: 15,
                          color: white,
                          fontFamily: 'Poppins-Regular'),
                    )
                        .animate()
                        .then(duration: 500.ms)
                        .fadeIn(duration: 1500.ms),
                    const SizedBox(height: 20),
                    // MainButton(
                    //     onpressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const SignUpScreen()));
                    //     },
                    //     height: 40,
                    //     width: 170,
                    //     child: Row(children: [
                    //       Text(
                    //         'Get Started',
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.bold,
                    //             color: white,
                    //             fontFamily: 'Poppins-Regular'),
                    //       ),
                    //       Icon(Icons.arrow_forward, color: white)
                    //     ])).animate().fadeIn(delay: 1500.ms, duration: 1500.ms),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
          ],
        ));
  }
}
