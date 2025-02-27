// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/firebase_options.dart';
import 'package:huong_nghiep/providers/authentication/emailverify_provider.dart';
import 'package:huong_nghiep/providers/authentication/signin_provider.dart';
import 'package:huong_nghiep/providers/authentication/signup_provider.dart';
import 'package:huong_nghiep/providers/home/home_provider.dart';

import 'package:huong_nghiep/screens/other/error_screen.dart';
import 'package:huong_nghiep/screens/other/on_boarding_screen.dart';
import 'package:huong_nghiep/screens/other/slashing_screen.dart';
import 'package:huong_nghiep/screens/authentication/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'screens/authentication/facbook_login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();
  final showHome = pref.getBool('showHome') ?? false;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  ErrorWidget.builder = ((FlutterErrorDetails details) => ErrorScreen());
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  final bool showHome;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInProvider>(
            create: (context) => SignInProvider()),
        ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider()),
        ChangeNotifierProvider<EmailVerifyProvider>(
            create: (context) => EmailVerifyProvider()),
        ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider()),
      ],
      child: GetMaterialApp(
        title: 'Tư vấn hướng nghiệp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: Colors.blue,
        ),
        // home: FacebookLoginScreen(),
        home: showHome
            ? FirebaseAuth.instance.currentUser == null
                ? SignInScreen()
                : SplashingScreen()
            : OnBoardingScreen(),
      ),
    );
  }
}
