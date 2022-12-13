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
    apiKey: 'AIzaSyCRXY2HyjZ7E0EEQ52zbuYtOKjYuOSM_rc',
    appId: '1:652881261933:web:a0d6c80c98fa885850d664',
    messagingSenderId: '652881261933',
    projectId: 'todo-22096',
    authDomain: 'todo-22096.firebaseapp.com',
    storageBucket: 'todo-22096.appspot.com',
    measurementId: 'G-DESW8YWJT9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1TplHG4uo1rrVe9xpjUzECm82vRU40WA',
    appId: '1:652881261933:android:80a56480b37743e050d664',
    messagingSenderId: '652881261933',
    projectId: 'todo-22096',
    storageBucket: 'todo-22096.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCd-5fv6m5dlwPN4TGGfk4wDNUI0NkBS0',
    appId: '1:652881261933:ios:8c2838a3a38249b550d664',
    messagingSenderId: '652881261933',
    projectId: 'todo-22096',
    storageBucket: 'todo-22096.appspot.com',
    iosClientId: '652881261933-inno362p3o6d9m9p9aqe239m729t7d60.apps.googleusercontent.com',
    iosBundleId: 'com.example.pssplBlocDemo',
  );
}
