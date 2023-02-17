import 'package:custom_cofee/Shared/Loading.dart';
import 'package:flutter/material.dart';

import '../../Models/Data.dart';

class UserCard extends StatelessWidget {
  final Data? user;
  UserCard({this.user});

  @override
  Widget build(BuildContext context) {
    int c = user!.strength!;
    print(" ${user!.name}, $c");

    String name = '';
    name = user!.name!;
    if (user!.strength! != 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: const EdgeInsets.fromLTRB(20, 8, 20, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('asset/images/coffee_icon.png'),
              radius: 20,
              backgroundColor: Colors.brown[user!.strength!],
            ),
            title: Text(
              name,
            ),
            subtitle: Text('pour ${user!.sugar} Sugars in cofee'),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
