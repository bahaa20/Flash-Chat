import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddFriendScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String friendEmail;
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new friend',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 20,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
              onChanged: (value) {
                friendEmail = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: FlatButton(
                onPressed: () async {
                  // FieldValue.arrayUnion(
                  //     [(_auth.currentUser.email + '+' + friendEmail)])
                  DocumentReference messages = _fireStore
                      .collection('users')
                      .doc(friendEmail.toString());

                  var myName = await _fireStore
                      .collection('users')
                      .doc(_auth.currentUser.email)
                      .get();
                  var friendName = await _fireStore
                      .collection('users')
                      .doc(friendEmail)
                      .get();


                  if (friendName.data()['name'].toString() != null) {
                    print(_auth.currentUser.email);
                    messages.set({
                      'Friends': {
                        '${myName.data()['name'].toString()}\+' +
                                _auth.currentUser.email:
                            (_auth.currentUser.email + '+' + friendEmail)
                      }
                    }, SetOptions(merge: true));

                    messages = _fireStore
                        .collection('users')
                        .doc(_auth.currentUser.email);
                    messages.set({
                      'Friends': {
                        '${friendName.data()['name'].toString()}\+' +
                                friendEmail:
                            (_auth.currentUser.email + '+' + friendEmail)
                      }
                    }, SetOptions(merge: true));


                    await _fireStore
                        .collection('messages')
                        .doc(_auth.currentUser.email + '+' + friendEmail)
                        .set({'messages': []});

                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
