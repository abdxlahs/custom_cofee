import 'package:custom_cofee/Services/DataBase.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/User.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_element
  TheUser? _theuserfromFirebase(User user) {
    //  ignore: unnecessary_null_comparison
    return user != null ? TheUser(Uid: user.uid) : null;
  }

  // aUTH CHANGES
  Stream<TheUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => (_theuserfromFirebase(user!)));
  }

//register with Email & password
  Future RegisterWihEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      DataBase(uid: user!.uid).updateUserData('New User', '0', 100);
      return _theuserfromFirebase(user!);
    } catch (e) {
      print(e.toString());
    }
  }

  //sign in anon
  Future SinInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user!.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sig in with Email & password
  Future SignInWihEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _theuserfromFirebase(user!);
    } catch (e) {
      print(e.toString());
    }
  }

//sig out
  Future<dynamic> SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
