import 'package:custom_cofee/Screens/AuthenticationScreen.dart';
import 'package:custom_cofee/Screens/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:custom_cofee/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final User = Provider.of<TheUser?>(context);

    if (User == null) {
      return Auth();
    } else
      return Home();
  }
}
