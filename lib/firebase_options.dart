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
    apiKey: 'AIzaSyDCJOVgJ2wYLZUqyAaToBUBZH8o7LPHBeQ',
    appId: '1:856105737406:web:2b82e77af5e049d32292ef',
    messagingSenderId: '856105737406',
    projectId: 'cs50-queue',
    authDomain: 'cs50-queue.firebaseapp.com',
    storageBucket: 'cs50-queue.appspot.com',
    measurementId: 'G-SBWCVE2WWC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOaDp4FinFsI1jiN6pHFS5POrt3th01wA',
    appId: '1:856105737406:android:ed2ddef522fba7a52292ef',
    messagingSenderId: '856105737406',
    projectId: 'cs50-queue',
    storageBucket: 'cs50-queue.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_MyU2QI32ZE1p2rf3O4B1A7t65TBtVWU',
    appId: '1:856105737406:ios:8c8baf02925c81c32292ef',
    messagingSenderId: '856105737406',
    projectId: 'cs50-queue',
    storageBucket: 'cs50-queue.appspot.com',
    iosClientId: '856105737406-jsifhg4a6g3j4o43hcukef7lfg952fc9.apps.googleusercontent.com',
    iosBundleId: 'com.cs50.cs50Queue',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_MyU2QI32ZE1p2rf3O4B1A7t65TBtVWU',
    appId: '1:856105737406:ios:8c8baf02925c81c32292ef',
    messagingSenderId: '856105737406',
    projectId: 'cs50-queue',
    storageBucket: 'cs50-queue.appspot.com',
    iosClientId: '856105737406-jsifhg4a6g3j4o43hcukef7lfg952fc9.apps.googleusercontent.com',
    iosBundleId: 'com.cs50.cs50Queue',
  );
}
