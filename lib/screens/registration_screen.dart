import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashshatapp/constants.dart';
import 'package:flashshatapp/screens/myContacts_screen.dart';
import 'package:flashshatapp/screens/refactors.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String userEmail, userPassword,username;
  final _auth = FirebaseAuth.instance;
  bool spinning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinning,
        color: Colors.grey,
        opacity: .7,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    username = value;
                  },
                  decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your name'),
                ),

                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userEmail = value;
                  },
                  decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    userPassword = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                LoginRegisterButton(
                  label: 'Register',
                  onPressed: () async {
                    setState(() {
                      spinning = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword);
                      if (newUser != null) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userEmail)
                            .set({'name': username});
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userEmail)
                            .set({'Friends': {}
                        }, SetOptions(merge: true));
                        Navigator.pushNamed(context, MyContacts.id);
                      }
                      setState(() {
                        spinning = false;
                      });
                    } catch (e) {
                      setState(() {
                        spinning = false;
                      });
                      print(e);
                    }
                  },
                  color: Colors.blueAccent,
                )
              ],
            ),
          ),
        ),
    );
  }
}
