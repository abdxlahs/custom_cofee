import 'package:custom_cofee/Screens/Home/UserCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Data.dart';

class UserDataList extends StatefulWidget {
  @override
  userDataList createState() => userDataList();
}

class userDataList extends State<UserDataList> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<Data>>(context);
    if (data != "null") {
      data.forEach((Element) {
        print(Element.name);
        print(Element.strength);
        print(Element.sugar);
      });
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index){
        return (UserCard(user: data[index],));
      },

    );
  }
}
