
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashshatapp/models/contacts.dart';
import 'package:flashshatapp/screens/add_friend_screen.dart';
import 'package:flashshatapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashshatapp/bottom_sheet_modified.dart' as bottomSheetModified;

class MyContacts extends StatefulWidget {
  static String id = 'myContactScreen';

  @override
  _MyContactsState createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  final _auth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  ContactList myContacts = ContactList();
  List<ContactWidget> contactsWidget = List<ContactWidget>();

  // StreamController<ContactList> myContactsTest;

  // Stream<ContactList> getFriendsList() async* {
  //   print('name1');
  //   var userData =
  //       _fireStore.collection('users').doc(_auth.currentUser.email).snapshots();
  //   userData.forEach((element) {
  //     Map friendsList = Map<String, dynamic>.from(element.data()['Friends']);
  //     myContacts = ContactList();
  //     friendsList.forEach((key, value) async {
  //       print('name');
  //       var friendsData =
  //           await _fireStore.collection('users').doc(key.toString()).get();
  //       // print(friendsData.data()['name']);
  //       myContacts.addContact(Contact(
  //           (friendsData.data()['name']), key.toString(), value.toString()));
  //     });
  //   });
  //   for (int i = 0; i < myContacts.Contacts.length; i++) {
  //     yield myContacts;
  //   }

    // Map friendsList =  Map<String, dynamic>.from(await userData.data()['Friends']);
    // Map friendsList ;
    // print(friendsList.length);

    // for(int i=0;i<myContacts.Contacts.length;i++) {
    //   yield myContacts.Contacts[i];
    // }
  // }

  @override
  void initState() {
    super.initState();
    // getFriendsList();
  }

  @override
  Widget build(BuildContext context) {
    // ContactList myContacts = ContactList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('👨🏼‍🤝‍👨🏼 My Contacts'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                Navigator.pop(context);
                // getMessagesStream();
              }),
        ],
        backgroundColor: Colors.lightBlueAccent,
      ),

      // StreamBuilder<DocumentSnapshot>(
      //   stream: _fireStore
      //       .collection('users')
      //       .doc(_auth.currentUser.email)
      //       .snapshots(),
      //   builder: (context, snapshots) {
      //
      //
      //
      //     snapshots.data['Friends']
      //     return ContactWidget(contact: snapshots.data['Friends']);
      //   },
      // )),
      body: SafeArea(
          //     child: StreamBuilder<ContactList>(
          //   stream: getFriendsList(),
          //   builder: (context, snapshots) {
          //     if (snapshots.hasData) {
          //       print('From body');
          //       return ListView.builder(
          //         itemCount: snapshots.data.Contacts.length,
          //         itemBuilder: (context, index) {
          //           // print(myContacts.Contacts.length.toString());
          //           return ContactWidget(contact:snapshots.data.Contacts[index] );
          //         },
          //       );
          //     }
          //     return Container();
          //   },
          // )),

          child: StreamBuilder<DocumentSnapshot>(
        stream: _fireStore
            .collection('users')
            .doc(_auth.currentUser.email)
            .snapshots(),
        builder: (context, snapshots) {
          // myContacts = ContactList();
          Map friendsList =
              Map<String, dynamic>.from(snapshots.data['Friends']);
          myContacts = ContactList();
          friendsList.forEach((key, value) {
            myContacts.addContact(Contact(key.toString().split('+')[0],
                key.toString().split('+')[1], value.toString()));
          });

          // print(myContacts.Contacts.length.toString() + " hh");
          return ListView.builder(
            itemCount: myContacts.Contacts.length,
            itemBuilder: (context, index) {
              // print(myContacts.Contacts.length.toString());
              return ContactWidget(contact: myContacts.Contacts[index]);
            },
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          bottomSheetModified.showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => AddFriendScreen(),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  final Contact contact;

  const ContactWidget({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      softWrap: true,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      contact.email,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  Navigator.pushNamed(context, ChatScreen.id,
                      arguments: contact.messagesURL);
                },
                color: Colors.lightBlueAccent,
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
