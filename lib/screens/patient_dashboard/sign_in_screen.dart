import 'package:flutter/material.dart';
import 'package:quick_medcare/screens/doctors_dashboard/home_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/home_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_up_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/main_button.dart';
import 'package:quick_medcare/widgets/text_button_widget.dart';
import 'package:quick_medcare/widgets/textfield_widget.dart';

import '../../firebase_reposisitories/firebase_auth.dart';

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
              CustomTextField(obscureText: false,
                  controller: emailController,
                  hint: 'Email',
                  icon: const Icon(Icons.email,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(obscureText: true,
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
                      Checkbox(
                          value: true,
                          onChanged: (value) {
                            value = true;
                          }),
                      Text(
                        'Remember',
                        style: bodyText2(context),
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
                onpressed: () async{
                   setState(() {
                      isLoading = true;
                    });
                   String message = await authHandler.signIn(
                        email: emailController.text,
                        password: passwordController.text);
                          if (message=='Success' ){
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                 
                                  content: Text("Account created successfully",
                                    
                                      style: TextStyle(fontSize: 16))));
                            
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            } else {
                                setState(() {
                            isLoading = false;
                          });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: blue,
                                  content: Text(message,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16))));
                            }
                },
                width: size.width,
                height: 40,
                child: Text('Sign In', style: TextStyle(color: white)),
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
                                builder: (context) => SignUpScreen()));
                      },
                      text: 'Sign Up'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Patients()));
                      },
                      text: 'Sign in as a doctor'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
