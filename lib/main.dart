import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_medcare/chat_feature/chat_screen.dart';
import 'package:quick_medcare/firebase_options.dart';
import 'package:quick_medcare/screens/admin_dashboard/admin.dart';
import 'package:quick_medcare/screens/patient_dashboard/other_details.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_in_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/sign_up_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/splash_screen.dart';
import 'package:quick_medcare/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins-Regular',
        
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: black)
              .copyWith(background: white),
        ),
        home: const SplashScreen());
  }
}
