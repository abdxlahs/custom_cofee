import 'package:custom_cofee/Services/Register.dart';
import 'package:flutter/material.dart';

import '../Services/signIn.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool toogleScreen = true;
  ScreenSwitcher() {
    setState(() {
      toogleScreen = !(toogleScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toogleScreen) {
      return SignIn(
        SwitchScreen: ScreenSwitcher,
      );
    } else {
      return Register(SwitchScreen: ScreenSwitcher);
    }
  }
}
