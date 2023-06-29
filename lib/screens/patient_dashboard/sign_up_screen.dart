import 'package:flutter/material.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_in_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/main_button.dart';
import 'package:quick_medcare/widgets/text_button_widget.dart';
import 'package:quick_medcare/widgets/textfield_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final genderController = TextEditingController();
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
              Center(
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), color: white),
                  child: const Icon(Icons.camera_alt_outlined),
                ),
              ),
              Text('Sign Up',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: blue,
                      fontFamily: 'Poppins-Regular')),
              const SizedBox(height: 30),
              CustomTextField(
                  controller: firstNameController,
                  hint: 'First Name',
                  icon: const Icon(Icons.person,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: lastNameController,
                  hint: 'Last Name',
                  icon: const Icon(Icons.person,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
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
              CustomTextField(
                  controller: ageController,
                  hint: 'Your age',
                  icon: const Icon(Icons.boy,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: genderController,
                  hint: 'Gender',
                  icon: const Icon(Icons.girl,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: heightController,
                  hint: 'Height',
                  icon: const Icon(Icons.height,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: weightController,
                  hint: 'Weight',
                  icon: const Icon(Icons.monitor_weight,
                      color: Color.fromARGB(255, 136, 133, 133))),
             
              const SizedBox(height: 20),
              CustomTextField(
                  controller: weightController,
                  hint: 'Health Insurance Agency',
                  icon: const Icon(Icons.monitor_weight,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: weightController,
                  hint: 'Blood Type',
                  icon: const Icon(Icons.monitor_weight,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: weightController,
                  hint: 'Genotype',
                  icon: const Icon(Icons.monitor_weight,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: weightController,
                  hint: 'Cholesterol',
                  icon: const Icon(Icons.monitor_weight,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: weightController,
                  hint: 'Blood Pressure',
                  icon: const Icon(Icons.monitor_weight,
                      color: Color.fromARGB(255, 136, 133, 133))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                      value: true,
                      onChanged: (value) {
                        value = true;
                      }),
                  SizedBox(
                    width: size.width * 0.7,
                    child: Text(
                      'I Agree to the Terms and Conditions',
                      style: bodyText2(context),
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              MainButton(
                onpressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                },
                width: size.width,
                height: 40,
                child: Text('Sign Up Account', style: TextStyle(color: white)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You have an account?'),
                  CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      text: 'Sign In'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
