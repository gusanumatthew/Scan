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
        return macos;
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
    apiKey: 'AIzaSyAZGj17kOrp19KP093RdI5k8QhQ800O8To',
    appId: '1:186229997323:web:9f58a6598b8a34ac622c0e',
    messagingSenderId: '186229997323',
    projectId: 'alome-a545c',
    authDomain: 'alome-a545c.firebaseapp.com',
    storageBucket: 'alome-a545c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwxDs91RSbqgPZgYmVtuRTzVsSpkgTVJg',
    appId: '1:186229997323:android:d487cb69f99aa83f622c0e',
    messagingSenderId: '186229997323',
    projectId: 'alome-a545c',
    storageBucket: 'alome-a545c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_tFHxeAIOjDf1tZ0_depkacIqiGaPfxM',
    appId: '1:186229997323:ios:66b7e028846b753e622c0e',
    messagingSenderId: '186229997323',
    projectId: 'alome-a545c',
    storageBucket: 'alome-a545c.appspot.com',
    iosClientId: '186229997323-6sg07sji6ojps3ij8kd4p24ok2jj7mbf.apps.googleusercontent.com',
    iosBundleId: 'com.example.alome',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_tFHxeAIOjDf1tZ0_depkacIqiGaPfxM',
    appId: '1:186229997323:ios:66b7e028846b753e622c0e',
    messagingSenderId: '186229997323',
    projectId: 'alome-a545c',
    storageBucket: 'alome-a545c.appspot.com',
    iosClientId: '186229997323-6sg07sji6ojps3ij8kd4p24ok2jj7mbf.apps.googleusercontent.com',
    iosBundleId: 'com.example.alome',
  );
}
