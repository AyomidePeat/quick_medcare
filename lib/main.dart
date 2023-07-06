import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quick_medcare/firebase_options.dart';
import 'package:quick_medcare/screens/patient_dashboard/splash_screen.dart';
import 'package:quick_medcare/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
    );

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
              titleMedium: TextStyle(fontSize: 14, color: white),
              titleSmall: TextStyle(fontSize: 10, color: white)),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: black)
              .copyWith(background: white),
        ),
        home: const SplashScreen());
  }
}
