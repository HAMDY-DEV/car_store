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
    apiKey: 'AIzaSyBAkRxTI7gtzYHdg2UIkbn6NPbitmdiXbI',
    appId: '1:890052968608:web:9a81fe413572155ce749c5',
    messagingSenderId: '890052968608',
    projectId: 'car-store-2024',
    authDomain: 'car-store-2024.firebaseapp.com',
    storageBucket: 'car-store-2024.appspot.com',
    measurementId: 'G-3Y3SP35HJ7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5UHwKmbZqxs7ZhtiMtgVnlVSbEFBHPhI',
    appId: '1:890052968608:android:0910e5bae2d6b34de749c5',
    messagingSenderId: '890052968608',
    projectId: 'car-store-2024',
    storageBucket: 'car-store-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpOwQMG62OQRi0P3PWRZ-6ayxgL2fa2gg',
    appId: '1:890052968608:ios:208425dbe2d2f67be749c5',
    messagingSenderId: '890052968608',
    projectId: 'car-store-2024',
    storageBucket: 'car-store-2024.appspot.com',
    iosBundleId: 'com.example.carStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpOwQMG62OQRi0P3PWRZ-6ayxgL2fa2gg',
    appId: '1:890052968608:ios:208425dbe2d2f67be749c5',
    messagingSenderId: '890052968608',
    projectId: 'car-store-2024',
    storageBucket: 'car-store-2024.appspot.com',
    iosBundleId: 'com.example.carStore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBAkRxTI7gtzYHdg2UIkbn6NPbitmdiXbI',
    appId: '1:890052968608:web:bf126cb1ff4f0dcee749c5',
    messagingSenderId: '890052968608',
    projectId: 'car-store-2024',
    authDomain: 'car-store-2024.firebaseapp.com',
    storageBucket: 'car-store-2024.appspot.com',
    measurementId: 'G-8ZCMSJVT32',
  );
}
