import 'package:breathe/screens/forms/register_page.dart';
import 'package:breathe/screens/side_drawer_screens/profile_screen.dart';
import 'package:breathe/screens/splash_screens/splash_screen_1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen1(),
    );
  }
}
