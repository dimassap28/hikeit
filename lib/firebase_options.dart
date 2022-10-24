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
    apiKey: 'AIzaSyBjjXwmkhCY708mLf7HThmdi9orL_Yvr7g',
    appId: '1:195264918638:web:01e665edba7e39d3aaa27f',
    messagingSenderId: '195264918638',
    projectId: 'flutterpushnotification-3f87a',
    authDomain: 'flutterpushnotification-3f87a.firebaseapp.com',
    storageBucket: 'flutterpushnotification-3f87a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkmYydurzttoDNoZbUH0f0dKRWQHI5c4U',
    appId: '1:195264918638:android:b1ea0fb877586f91aaa27f',
    messagingSenderId: '195264918638',
    projectId: 'flutterpushnotification-3f87a',
    storageBucket: 'flutterpushnotification-3f87a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOsy5m3KOweBcHSFzOx-8SM_TRnSMfdxg',
    appId: '1:195264918638:ios:99568b08a6726274aaa27f',
    messagingSenderId: '195264918638',
    projectId: 'flutterpushnotification-3f87a',
    storageBucket: 'flutterpushnotification-3f87a.appspot.com',
    iosClientId: '195264918638-cmpr26d0j9bt38pr2atokra5e0mt5fqi.apps.googleusercontent.com',
    iosBundleId: 'com.example.hikingApp',
  );
}
