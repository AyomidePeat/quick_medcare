import 'package:flutter/material.dart';
import 'package:quick_medcare/screens/home_screen.dart';
import 'package:quick_medcare/screens/splash_screen.dart';
import 'package:quick_medcare/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins-Regular',
          textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: black),
            displayMedium: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: black),
            displaySmall: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: black),
            bodyLarge: TextStyle(fontSize: 16, color: black),
            bodyMedium: TextStyle(fontSize: 14, color: black),
            bodySmall: TextStyle(fontSize: 12, color: black),
            titleMedium: TextStyle(fontSize: 14, color: white),titleSmall: TextStyle(fontSize: 10, color: white)
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: black)
              .copyWith(background: white),
        ),
        home: const HomeScreen());
  }
}
