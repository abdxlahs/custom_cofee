import 'package:custom_cofee/Screens/Home/Settings_Form.dart';
import 'package:custom_cofee/Screens/Home/UserDataList.dart';
import 'package:custom_cofee/Services/DataBase.dart';
import 'package:custom_cofee/Services/authServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Data.dart';

class Home extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _bottomSliderSettingbar() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Data>>.value(
      value: DataBase().getUserData(),
      catchError: (_, __) => [],
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[70],
        appBar: AppBar(
          backgroundColor: Colors.brown,
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.brown)),
                onPressed: () => _bottomSliderSettingbar(),
                icon: const Icon(Icons.settings),
                label: const Text('Settings')),
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.brown)),
                onPressed: () async {
                  return await _auth.SignOut();
                },
                icon: const Icon(Icons.person),
                label: const Text('Logout')),
          ],
        ),
        body: Stack(
          children: <Widget>[
            const Image(
              image: AssetImage('asset/images/cofee.png'),
              fit: BoxFit.fill,
            ),
            UserDataList(),
          ],
        ),
      ),
    );
  }
}
