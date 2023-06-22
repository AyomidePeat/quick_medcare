import 'package:flutter/material.dart';
import 'package:quick_medcare/screens/sign_up_screen.dart';
import 'package:quick_medcare/screens/splash_screen.dart';
import 'package:quick_medcare/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'OpenSans-Bold',
          textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: black),
            displayMedium: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: black),
            displaySmall: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: black),
            bodyLarge: TextStyle(fontSize: 16, color: black),
            bodyMedium: TextStyle(fontSize: 14, color: black),
            bodySmall: TextStyle(fontSize: 12, color: black),
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: black)
              .copyWith(background: grey),
        ),
        home: const SignUpScreen());
  }
}
