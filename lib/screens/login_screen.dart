import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashshatapp/constants.dart';
import 'package:flashshatapp/screens/myContacts_screen.dart';
import 'package:flashshatapp/screens/refactors.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userPassword, userEmail;
  final _auth = FirebaseAuth.instance;
  UserCredential userCredential;
  bool spinning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors. grey,
        opacity: .7,
        progressIndicator: CircularProgressIndicator(backgroundColor: Colors.white,
        ),
        inAsyncCall: spinning,
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
                label: 'Log In',
                onPressed: () async {
                  setState(() {
                    spinning = true;
                  });
                  try {
                    userCredential = await _auth.signInWithEmailAndPassword(
                        email: userEmail, password: userPassword);
                    if (userCredential.user != null) {
                      Navigator.pushNamed(context, MyContacts.id);
                    }
                    setState(() {
                      spinning = false;
                    });
                  } catch (e) {
                    setState(() {
                      spinning = false;
                    });
                  }
                },
                color: Colors.lightBlueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
