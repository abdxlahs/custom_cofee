import 'package:custom_cofee/Models/UserData.dart';
import 'package:custom_cofee/Services/DataBase.dart';
import 'package:custom_cofee/Shared/Loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/User.dart';
import '../../Shared/constants.dart';
import '../../Models/UserData.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<TheUser?>(context);
    return StreamBuilder<UserData>(
        stream: DataBase(uid: User!.Uid).userDatafromfirebase,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data;
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownButtonFormField<String>(
                    value: _currentSugars ?? userData.sugar,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    value: (_currentStrength ?? userData.strength)!.toDouble(),
                    activeColor: Colors.brown[700],
                    inactiveColor: Colors.brown[100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.brown)),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DataBase(uid: User.Uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentSugars ?? userData.sugar,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
