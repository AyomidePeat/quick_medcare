import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_medcare/firebase_options.dart';
import 'package:quick_medcare/screens/patient_dashboard/home_screen.dart';
import 'package:quick_medcare/screens/patient_dashboard/splash_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/notification_services.dart';
import 'package:quick_medcare/utils/utils.dart';

Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationServices.showNotification(remoteMessage: remoteMessage);
  await callsCollection.doc(remoteMessage.data['id']).update({
    'connected':true,
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationServices.initalizeNotification();
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: "high_importance_channel");
    }
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
    await NotificationServices.showNotification(remoteMessage: remoteMessage);
    await callsCollection.doc(remoteMessage.data['id']).update({
      'connected': true,
    });
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String homeRoute = '/home';
  @override
  void initState() {
    NotificationServices.startListeningNotificationEvents();
    super.initState();
  }

  List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
    List<Route<dynamic>> pageStack = [];

    // pageStack.add(MaterialPageRoute(builder: (_) => const CheckAuthStatus()));

    if (NotificationServices.initialAction != null) {
      pageStack.add(MaterialPageRoute(
          builder: (_) => HomeScreen(
                receivedAction: NotificationServices.initialAction,
              )));
    }
    return pageStack;
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        ReceivedAction receivedAction = settings.arguments as ReceivedAction;
        return MaterialPageRoute(
            builder: (_) => HomeScreen(receivedAction: receivedAction));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 800),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return MaterialApp(
              navigatorKey: MyApp.navigatorKey,
            //  onGenerateInitialRoutes: onGenerateInitialRoutes,
             // onGenerateRoute: onGenerateRoute,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Poppins-Regular',
                useMaterial3: true,
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: black)
                    .copyWith(background: white),
              ),
              //builder: (_, child) => Unfocus(child: child!),
              home: const SplashScreen());
        });
  }
}

class Unfocus extends StatelessWidget {
  final Widget child;
  const Unfocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
