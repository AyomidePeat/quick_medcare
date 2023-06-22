import 'package:flutter/material.dart';
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

  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign Up', style: headline1(context)),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: firstNameController,
                  hint: 'First Name',
                  icon: Icon(Icons.person)),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: lastNameController,
                  hint: 'Last Name',
                  icon: Icon(Icons.person)),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: emailController,
                  hint: 'Email',
                  icon: Icon(Icons.email)),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: passwordController,
                  hint: 'Password',
                  icon: Icon(Icons.lock)),
              Row(
                children: [
                  Checkbox(
                      value: true,
                      onChanged: (value) {
                        value = true;
                      }),
                  Text(
                    'I Agree to the Terms and Conditions',
                    style: bodyText2(context),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(
                      onpressed: () {},
                      text: 'Sign Up Account',
                      height: 50,
                      width: 150),
                  const Text('You have an account?'),
                  CustomTextButton(onPressed: () {}, text: 'Sign In')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
