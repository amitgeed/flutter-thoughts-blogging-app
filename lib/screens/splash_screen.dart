import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twbh/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, WelcomeScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: ShapesPainter(),
            child: Container(
              height: double.infinity,
            ),
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'T',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 60.0,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'HOUGHTS',
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.deepOrangeAccent.withOpacity(0.5);
    var bottom = Offset(size.width, size.height + 10);
    canvas.drawCircle(bottom, 150.0, paint);

    paint.color = Colors.blueAccent.withOpacity(0.5);

    var top = Offset(size.width - size.width, size.height - size.height + 10);

    canvas.drawCircle(top, 150.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
