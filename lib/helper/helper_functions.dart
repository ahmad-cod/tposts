import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

void alertUser(String message, BuildContext context) {
  showDialog(context: context, 
    builder: (context) => AlertDialog(
      title: Text(message),
    )
  );
}

// String get firebaseWebApiKey => dotenv.env['FIREBASE_WEB_API_KEY']!;
// String get firebaseAndroidApiKey => dotenv.env['FIREBASE_ANDROID_API_KEY']!;

// String get firebaseWebApiKey => const String.fromEnvironment("FIREBASE_WEB_API_KEY");
// String get firebaseAndroidApiKey => const String.fromEnvironment("FIREBASE_ANDROID_API_KEY");