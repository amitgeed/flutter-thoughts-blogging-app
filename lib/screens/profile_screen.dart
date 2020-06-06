import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twbh/screens/welcome_screen.dart';
import 'package:twbh/utils/my_bottom_navbar.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, MyBottomNavbar.id);
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: _firebaseAuth.currentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInformation(context, snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    // const start = "";
    const end = "@";

    // final startIndex = user.email.toString().indexOf(start);
    final endIndex = user.email.toString().indexOf(end, 0);

    return Center(
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                backgroundColor: Colors.deepOrangeAccent,
                radius: 50.0,
                child: Text(
                  "${user.email.toString().substring(0, 1).toUpperCase()}",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "${user.email.toString().substring(0, endIndex).toUpperCase()}",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${user.email}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Joined on ${DateFormat("MM/dd/yyyy").format(user.metadata.creationTime)}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                _firebaseAuth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
              child: Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.deepOrange],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        // spreadRadius: 5.0,
                      ),
                    ]),
                child: Text(
                  'LogOut',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
