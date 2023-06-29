import 'package:flutter/material.dart';
import 'package:quick_medcare/screens/patient_dashboard/home_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_up_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/main_button.dart';
import 'package:quick_medcare/widgets/text_button_widget.dart';
import 'package:quick_medcare/widgets/textfield_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                  controller: emailController,
                  hint: 'Email',
                  icon: const Icon(Icons.email,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
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
                onpressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
