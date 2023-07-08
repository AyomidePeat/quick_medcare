import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_in_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/widgets/main_button.dart';
import 'package:quick_medcare/widgets/text_button_widget.dart';
import 'package:quick_medcare/widgets/textfield_widget.dart';

import '../../firebase_reposisitories/firebase_auth.dart';

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
  AuthenticationMethod authHandler = AuthenticationMethod();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showSuccessSnackBar(
    ScaffoldMessengerState scaffoldMessengerState,
  ) {
    scaffoldMessengerState.showSnackBar(
      const SnackBar(
        content: Text('Sign Up Successful'),
      ),
    );
  }
  void showErrorSnackBar(
    ScaffoldMessengerState scaffoldMessengerState,
  ) {
    scaffoldMessengerState.showSnackBar(
      const SnackBar(
        content: Text('Fill all fields'),
      ),
    );
  }

  void replaceWithSignInScreen() {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => const SignInScreen()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
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
                        borderRadius: BorderRadius.circular(15),
                        color: white),
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
                    obscureText: false,
                    controller: firstNameController,
                    hint: 'First Name',
                    icon: const Icon(Icons.person,
                        color: Color.fromARGB(255, 136, 133, 133))),
                const SizedBox(height: 20),
                CustomTextField(
                    obscureText: false,
                    controller: lastNameController,
                    hint: 'Last Name',
                    icon: const Icon(Icons.person,
                        color: Color.fromARGB(255, 136, 133, 133))),
                const SizedBox(height: 20),
                CustomTextField(
                    obscureText: false,
                    controller: emailController,
                    hint: 'Email',
                    icon: const Icon(Icons.email,
                        color: Color.fromARGB(255, 136, 133, 133))),
                const SizedBox(height: 20),
                CustomTextField(
                    obscureText: true,
                    controller: passwordController,
                    hint: 'Password',
                    icon: const Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 136, 133, 133),
                    )),
                const SizedBox(height: 20),
                CustomTextField(
                    obscureText: false,
                    controller: genderController,
                    hint: 'Gender',
                    icon: const Icon(Icons.girl,
                        color: Color.fromARGB(255, 136, 133, 133))),
                // CustomTextField(
                //     controller: ageController,
                //     hint: 'Your age',
                //     icon: const Icon(Icons.boy,
                //         color: Color.fromARGB(255, 136, 133, 133))),
                // const SizedBox(height: 20),

                // const SizedBox(height: 20),
                // CustomTextField(
                //     controller: heightController,
                //     hint: 'Height',
                //     icon: const Icon(Icons.height,
                //         color: Color.fromARGB(255, 136, 133, 133))),
                // const SizedBox(height: 20),
                // CustomTextField(
                //     controller: weightController,
                //     hint: 'Weight',
                //     icon: const Icon(Icons.monitor_weight,
                //         color: Color.fromARGB(255, 136, 133, 133))),

                // const SizedBox(height: 20),
                // CustomTextField(
                //     controller: weightController,
                //     hint: 'Health Insurance Agency',
                //     icon: const Icon(Icons.monitor_weight,
                //         color: Color.fromARGB(255, 136, 133, 133))),
                // const SizedBox(height: 20),
                // CustomTextField(
                //     controller: weightController,
                //     hint: 'Blood Type',
                //     icon: const Icon(Icons.monitor_weight,
                //         color: Color.fromARGB(255, 136, 133, 133))),
                // const SizedBox(height: 20),
                // CustomTextField(
                //     controller: weightController,
                //     hint: 'Genotype',
                //     icon: const Icon(Icons.monitor_weight,
                //         color: Color.fromARGB(255, 136, 133, 133))),
                // const SizedBox(height: 20),
                // CustomTextField(
                //     controller: weightController,
                //     hint: 'Cholesterol',
                //     icon: const Icon(Icons.monitor_weight,
                //         color: Color.fromARGB(255, 136, 133, 133))),
                // const SizedBox(height: 20),
                // CustomTextField(
                //     controller: weightController,
                //     hint: 'Blood Pressure',
                //     icon: const Icon(Icons.monitor_weight,
                //         color: Color.fromARGB(255, 136, 133, 133))),
                // const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Checkbox(
                //         value: true,
                //         onChanged: (value) {
                //           value = true;
                //         }),
                //     SizedBox(
                //       width: size.width * 0.7,
                //       child: Text(
                //         'I Agree to the Terms and Conditions',
                //         style: bodyText2(context),
                //         overflow: TextOverflow.fade,
                //       ),
                //     )
                //   ],
                // ),
                const SizedBox(height: 20),
                MainButton(
                  onpressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    String message = await authHandler.signUp(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        gender: genderController.text,
                        email: emailController.text,
                        password: passwordController.text);
                    if (message == 'Success') {
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Sign Up Successful',
                          
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16)),
                              backgroundColor: blue,));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         backgroundColor: blue,
                          content: Text(message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16))));
                    

                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  width: size.width,
                  height: 40,
                  child: isLoading
                      ? LoadingAnimationWidget.inkDrop(color: white, size: 25)
                      : Text('Sign Up Account',
                          style: TextStyle(color: white)),
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
                                  builder: (context) =>
                                      const SignInScreen()));
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
