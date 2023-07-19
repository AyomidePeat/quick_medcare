import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_in_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/widgets/main_button.dart';
import 'package:quick_medcare/widgets/text_button_widget.dart';
import 'package:quick_medcare/widgets/textfield_widget.dart';

import '../../firebase_reposisitories/firebase_auth.dart';
import '../../utils/textstyle.dart';
import '../../utils/upload_image.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AuthenticationMethod authHandler = AuthenticationMethod();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var gender = 'Male';
 XFile? _imageFile;
  ImageUpload imageUpload = ImageUpload();
  bool isImageLoading = false;

  bool isImageGood() {
    return _imageFile != null;
  }
 
  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
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
             
                Text('Sign Up',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        fontFamily: 'Poppins-Regular')),
                const SizedBox(height: 40),
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
                const SizedBox(height: 30),
                selectGender(),
                 const SizedBox(height: 20),
                Center(
                  child: Text(
                    'By Clicking Sign Up, you agree to our Terms and Conditions',
                      style:headLine4(red),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                  ),
                ),
                const SizedBox(height: 40),
                MainButton(
                  onpressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    String message = await authHandler.signUp(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        gender: gender,
                        email: emailController.text,
                        password: passwordController.text);
                    if (message == 'Success') {
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Sign Up Successful',
                          
                              textAlign: TextAlign.center,
                              style: bodyText2(white)),
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
  SizedBox selectGender() {

    return SizedBox(
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Gender*",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Row(
                  children: [
                    const Text("Male"),
                    Radio(
                        focusColor: blue,
                        activeColor: blue,
                        value: "Male",
                        groupValue: gender,
                        onChanged: (String? v) {
                          if (v != null) {
                            setState(() {
                              gender = v;
                            });
                          }
                        }),
                  ],
                ),
              ),
              SizedBox(
                width: 110,
                child: Row(
                  children: [
                    const Text("Female"),
                    Radio(
                        activeColor: blue,
                        value: "Female",
                        groupValue: gender,
                        onChanged: (String? v) {
                          if (v != null) {
                            setState(() {
                              gender = v;
                            });
                          }
                        }),
                  ],
                ),
              ),
              SizedBox(
                width: 140,
                child: Row(
                  children: [
                    const Text("Non-binary"),
                    Radio(
                        activeColor: blue,
                        value: "Non-binary",
                        groupValue: gender,
                        onChanged: (String? v) {
                          if (v != null) {
                            setState(() {
                              gender = v;
                            });
                          }
                        }),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


 