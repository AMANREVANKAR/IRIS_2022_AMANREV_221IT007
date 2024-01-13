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
    apiKey: 'AIzaSyDgw78tnH0Qg-RcApyOUp5Hlh_iEJIuRjI',
    appId: '1:537836645520:web:ef4aa835f5ddd915633c15',
    messagingSenderId: '537836645520',
    projectId: 'messinfo-bb96b',
    authDomain: 'messinfo-bb96b.firebaseapp.com',
    storageBucket: 'messinfo-bb96b.appspot.com',
    measurementId: 'G-YLJPPQ2EGQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5n4nRqsd4CiK1l0bfwLrAeCwsRTI2emc',
    appId: '1:537836645520:android:e9b8572f3cbdac3e633c15',
    messagingSenderId: '537836645520',
    projectId: 'messinfo-bb96b',
    storageBucket: 'messinfo-bb96b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZrzikxqFIYVR_4YPl6ZoziZMJi6-G8So',
    appId: '1:537836645520:ios:63b73e4892b42ad2633c15',
    messagingSenderId: '537836645520',
    projectId: 'messinfo-bb96b',
    storageBucket: 'messinfo-bb96b.appspot.com',
    iosBundleId: 'com.example.messinfo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZrzikxqFIYVR_4YPl6ZoziZMJi6-G8So',
    appId: '1:537836645520:ios:866ca9c84a80ebcf633c15',
    messagingSenderId: '537836645520',
    projectId: 'messinfo-bb96b',
    storageBucket: 'messinfo-bb96b.appspot.com',
    iosBundleId: 'com.example.messinfo.RunnerTests',
  );
}