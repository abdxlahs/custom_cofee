import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_cofee/Models/UserData.dart';
import 'package:firebase_core/firebase_core.dart';

import '../Models/Data.dart';

class DataBase {
  final String? uid;
  DataBase({this.uid});

  final CollectionReference userData =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(String? name, String? sugar, int? strength) async {
    return await userData.doc(uid).set({
      'Name': name,
      'Sugar': sugar,
      'Strenth': strength,
    });
  }

  //user data model from firestore
  UserData _userData(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['Name'],
      sugar: snapshot['Sugar'],
      strength: snapshot['Strenth'],
    );
  }

  //list from SnapShot
  List<Data> _userDatafromSnapquery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Data(
        name: doc.get('Name') ?? '',
        sugar: doc.get('Sugar') ?? "0",
        strength: doc.get('Strenth') ?? 100,
      );
    }).toList();
  }

  Stream<List<Data>> getUserData() {
    return userData.snapshots().map(_userDatafromSnapquery);
  }

// get data from firestore
  Stream<UserData> get userDatafromfirebase {
    return userData.doc(uid).snapshots().map(_userData);
  }
}
