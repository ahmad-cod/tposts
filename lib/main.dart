import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_demo/auth/auth.dart';
import 'package:socialmedia_demo/auth/login_or_register.dart';
import 'package:socialmedia_demo/firebase_options.dart';
import 'package:socialmedia_demo/pages/home_page.dart';
import 'package:socialmedia_demo/pages/profile_page.dart';
import 'package:socialmedia_demo/pages/users_page.dart';
import 'package:socialmedia_demo/theme/dark_mode.dart';
import 'package:socialmedia_demo/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const AuthPage(),
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },
    );
  }
}