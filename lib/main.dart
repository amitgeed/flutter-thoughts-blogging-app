import 'package:flutter/material.dart';
import 'package:twbh/screens/home_screen.dart';
import 'package:twbh/screens/login_screen.dart';
import 'package:twbh/screens/post_screen.dart';
import 'package:twbh/screens/profile_screen.dart';
import 'package:twbh/screens/registration_screen.dart';
import 'package:twbh/screens/setting_screen.dart';
import 'package:twbh/screens/splash_screen.dart';
import 'package:twbh/screens/welcome_screen.dart';
import 'package:twbh/utils/my_bottom_navbar.dart';

bool darkThemeEnabled = true;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: WelcomeScreen(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MyBottomNavbar.id: (context) => MyBottomNavbar(),
        HomeScreen.id: (context) => HomeScreen(),
        PostScreen.id: (context) => PostScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        SettingScreen.id: (context) => SettingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
