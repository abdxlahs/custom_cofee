import 'package:custom_cofee/Shared/Loading.dart';
import 'package:custom_cofee/Services/authServices.dart';

import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final SwitchScreen;
  SignIn({required this.SwitchScreen});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  String email = '';
  String password = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Kustom Kofee'),
        elevation: 0.0,
        actions: <Widget>[
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.brown)),
              onPressed: () {
                widget.SwitchScreen();
              },
              child: const Icon(Icons.app_registration))
        ],
      ),
      // body: ElevatedButton(
      //   style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.all(
      //           const Color.fromARGB(255, 155, 111, 96))),
      //   child: const Text('SignIn Anon'),
      //   onPressed: () async {
      //     dynamic result = await _auth.SinInAnon();
      //     if (result == null) {
      //       print("error Sign in");
      //     } else {
      //       print("signed in");1
      //       print(result);
      //     }
      //   },
      // ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            label: Text(
                              "E-mail",
                              style: TextStyle(color: Colors.grey),
                            ),
                            ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter the Email" : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            label: Text(
                              "Password",
                              style: TextStyle(color: Colors.grey),
                            )),
                        validator: (value) => value!.length < 6
                            ? "Please enter the Password more than 6 char "
                            : null,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 155, 111, 96))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.SignInWihEmailAndPassword(
                                    email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    "You can't Sign In With This Credendentials";
                              });
                            }
                          }
                        },
                        child: const Text("Jump In to make Cofee")),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
