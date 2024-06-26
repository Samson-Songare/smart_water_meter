// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBIJ3aiDrxUfmh-aaB3h0TT9b1DxbzmbC8',
    appId: '1:840104311904:web:3563bbf2da61261a7d1705',
    messagingSenderId: '840104311904',
    projectId: 'final-smart-meter',
    authDomain: 'final-smart-meter.firebaseapp.com',
    databaseURL: 'https://final-smart-meter-default-rtdb.firebaseio.com',
    storageBucket: 'final-smart-meter.appspot.com',
    measurementId: 'G-4YEE724T08',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPwEQAg8TJ2slBNmKQcipf9tX-fsjTARs',
    appId: '1:840104311904:android:b46bf420ec08c7137d1705',
    messagingSenderId: '840104311904',
    projectId: 'final-smart-meter',
    databaseURL: 'https://final-smart-meter-default-rtdb.firebaseio.com',
    storageBucket: 'final-smart-meter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbUSA8FHThoR1fvdBNdF8FIv0qlruA-Hw',
    appId: '1:840104311904:ios:ef6c1653fb6e90c57d1705',
    messagingSenderId: '840104311904',
    projectId: 'final-smart-meter',
    databaseURL: 'https://final-smart-meter-default-rtdb.firebaseio.com',
    storageBucket: 'final-smart-meter.appspot.com',
    iosBundleId: 'com.example.smartWaterMeter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbUSA8FHThoR1fvdBNdF8FIv0qlruA-Hw',
    appId: '1:840104311904:ios:ef6c1653fb6e90c57d1705',
    messagingSenderId: '840104311904',
    projectId: 'final-smart-meter',
    databaseURL: 'https://final-smart-meter-default-rtdb.firebaseio.com',
    storageBucket: 'final-smart-meter.appspot.com',
    iosBundleId: 'com.example.smartWaterMeter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBIJ3aiDrxUfmh-aaB3h0TT9b1DxbzmbC8',
    appId: '1:840104311904:web:3563bbf2da61261a7d1705',
    messagingSenderId: '840104311904',
    projectId: 'final-smart-meter',
    authDomain: 'final-smart-meter.firebaseapp.com',
    databaseURL: 'https://final-smart-meter-default-rtdb.firebaseio.com',
    storageBucket: 'final-smart-meter.appspot.com',
    measurementId: 'G-4YEE724T08',
  );

}