// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCFj2ZE1_Y6vmyGBzbzctIy9WS5ERapTvY',
    appId: '1:1059091180763:web:a16c9411972cf105b330fe',
    messagingSenderId: '1059091180763',
    projectId: 'quickmedcare-528e5',
    authDomain: 'quickmedcare-528e5.firebaseapp.com',
    storageBucket: 'quickmedcare-528e5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwGOGYsoMQONg-mxNTkx1tdAmVl2DyIBc',
    appId: '1:1059091180763:android:4c9394bdf5a8e332b330fe',
    messagingSenderId: '1059091180763',
    projectId: 'quickmedcare-528e5',
    storageBucket: 'quickmedcare-528e5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_fDI7SDt4jylWGSPxXnS_xwo1XSh__H0',
    appId: '1:1059091180763:ios:aaedfd640f62bda5b330fe',
    messagingSenderId: '1059091180763',
    projectId: 'quickmedcare-528e5',
    storageBucket: 'quickmedcare-528e5.appspot.com',
    iosClientId: '1059091180763-6thhl5ve750orrrq5fftn5fqm3321s5m.apps.googleusercontent.com',
    iosBundleId: 'com.example.quickMedcare',
  );
}
