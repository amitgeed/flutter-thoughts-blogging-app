import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twbh/main.dart';
import 'package:twbh/utils/my_bottom_navbar.dart';

class SettingScreen extends StatefulWidget {
  static const String id = 'setting_screen';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, MyBottomNavbar.id);
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Dark Theme"),
              trailing: Switch(
                value: darkThemeEnabled,
                activeColor: Colors.deepOrangeAccent,
                onChanged: (changedTheme) {
                  setState(() {
                    darkThemeEnabled = changedTheme;
                    main();
                    print(darkThemeEnabled);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class Bloc {
//   final _themeController = StreamController<bool>();
//   get changeTheme => _themeController.sink.add;
//   get darkThemeEnabled => _themeController.stream;
// }

// final bloc = Bloc();
