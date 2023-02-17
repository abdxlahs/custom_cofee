import 'package:custom_cofee/Shared/Loading.dart';
import 'package:custom_cofee/Services/authServices.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final SwitchScreen;

  // ignore: non_constant_identifier_names
  Register({required this.SwitchScreen});
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown,
              title: const Text(
                'Register to get the personelized kofee',
                style: TextStyle(fontSize: 15),
              ),
              elevation: 0.0,
              actions: <Widget>[
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.brown)),
                    onPressed: () {
                      widget.SwitchScreen();
                    },
                    child: const Icon(Icons.login))
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
            //       print("signed in");
            //       print(result);
            //     }
            //   },
            // ),
            body: Form(
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
                                )),
                            validator: (value) =>
                                value!.isEmpty ? "Enter the Email" : null,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          const SizedBox(
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
                                    await _auth.RegisterWihEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        "please Enter the Valid Information";
                                  });
                                }
                              }
                            },
                            child: const Text("Register")),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          error,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
