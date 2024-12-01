import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
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
    apiKey: 'AIzaSyDBBImwyXz5enz_mSSSEsrNTaqXlWNergU',
    appId: '1:1058573989939:web:825e13afb943bdb3258b46',
    messagingSenderId: '1058573989939',
    projectId: 'premium_filter-0kg4tt',
    authDomain: 'premium_filter-0kg4tt.firebaseapp.com',
    storageBucket: 'premium_filter-0kg4tt.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDz-Hf8nkQLjnA6fYsEKIiHV71cMg8fqLc',
    appId: '1:130309518689:android:a375c24f12b462587d0120',
    messagingSenderId: '130309518689',
    projectId: 'premium-filters',
    storageBucket: 'premium-filters.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOrYICtKVMQCDGal2LWK1DKjW5MpCMtPs',
    appId: '1:130309518689:ios:56820fcdef3081ff7d0120',
    messagingSenderId: '130309518689',
    projectId: 'premium-filters',
    storageBucket: 'premium-filters.appspot.com',
    iosBundleId: 'info.freddycampos.premiumfilters.premiumFilter',
  );

}