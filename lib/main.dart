import 'package:firebase_core/firebase_core.dart';
import 'package:flashshatapp/screens/myContacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashshatapp/screens/welcome_screen.dart';
import 'package:flashshatapp/screens/login_screen.dart';
import 'package:flashshatapp/screens/registration_screen.dart';
import 'package:flashshatapp/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context)=> WelcomeScreen(),
        LoginScreen.id:(context)=> LoginScreen(),
        RegistrationScreen.id:(context)=> RegistrationScreen(),
        ChatScreen.id:(context)=> ChatScreen(),
        MyContacts.id:(context)=>MyContacts(),
      },
    );
  }
}
