// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:otspocket/screens/onboarding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login.dart';

String inpath = "/";
int? initscreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initscreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFFFFFFFF),
          scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: Center(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Image.asset(
                    "asset/images/logo.jpeg",
                    fit: BoxFit.contain,
                    height: 160,
                  ),
                ],
              ),
            ),
          ),
          duration: 3000,
          backgroundColor: Color(0xFFFFFFFF),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          nextScreen: initscreen == 0 || initscreen == null
              ? OnboardingPage()
              : LoginPage()),
    );
  }
}
