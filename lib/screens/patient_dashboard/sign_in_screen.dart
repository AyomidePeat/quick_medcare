// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quick_medcare/screens/admin_dashboard/admin.dart';
import 'package:quick_medcare/screens/doctors_dashboard/home_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/home_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_up_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/health_tips.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/main_button.dart';
import 'package:quick_medcare/widgets/text_button_widget.dart';
import 'package:quick_medcare/widgets/textfield_widget.dart';
import '../../firebase_reposisitories/firebase_auth.dart';
import '../doctors_dashboard/add_patient_details.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthenticationMethod authHandler = AuthenticationMethod();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: grey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.08),
              Text('Sign In',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: blue,
                      fontFamily: 'Poppins-Regular')),
              const SizedBox(height: 30),
              CustomTextField(
                  obscureText: false,
                  controller: emailController,
                  hint: 'Email',
                  icon: const Icon(Icons.email,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  obscureText: isObscure,
                  controller: passwordController,
                  hint: 'Password',
                  icon: const Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 136, 133, 133),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                     
                      TextButton(
                        onPressed: () => setState(() {
                          isObscure = !isObscure;
                        }),
                        child: Text(isObscure?
                          'Show Password':'Hide Password',
                          style: bodyText3(black),
                        ),
                      )
                    ],
                  ),
                  CustomTextButton(
                    text: 'Forgot Password',
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(height: 20),
              MainButton(
                onpressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  String message = await authHandler.signIn(
                      email: emailController.text,
                      password: passwordController.text);
                  if (message == 'Success') {
                    DocumentSnapshot snapshot = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get();
                    Map<String, dynamic> data =
                        snapshot.data() as Map<String, dynamic>;

                    String role = data['role'] ?? '';
                    if (role == 'doctor') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorHomeScreen(
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                  )));
                    } else if (role == 'patient') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                  )));
                    } else if (role == 'admin') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminDashboard()));
                    }
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: blue,
                        content: Text(message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16))));
                  }
                },
                width: size.width,
                height: 40,
                child: isLoading
                    ? LoadingAnimationWidget.inkDrop(color: white, size: 25)
                    : Text('Sign In', style: TextStyle(color: white)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New here?'),
                  CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      text: 'Sign Up'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
