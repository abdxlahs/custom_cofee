import 'package:custom_cofee/Models/User.dart';
import 'package:custom_cofee/Services/authServices.dart';
import 'package:custom_cofee/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(StreamProvider<TheUser?>.value(
    catchError: (_, __) => null,
    initialData: null,
    value: AuthService().user,
    child: (MaterialApp(
      home: Wrapper(),
    )),
  ));
}
