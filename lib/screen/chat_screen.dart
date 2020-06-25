import 'package:abiolachat/widget/chat/messages.dart';
import 'package:abiolachat/widget/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/* created by Abiola Gbode
repo -> https://github.com/abiolagbode
whatsapp: +2348176391092
email: infogbodeabiola@gmail.com
 */

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final stream = Firestore.instance
      .collection("chats/BWAwHpix7sLPPoroFGev/messages")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HiChat"),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Logout"),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(
      //       Icons.add,
      //     ),
      //     onPressed: () {
      //       Firestore.instance
      //           .collection("chats/BWAwHpix7sLPPoroFGev/messages")
      //           .add({'text': "This was added by clicking the a button"});
      //       // .listen((data) {
      //       //   data.documents.forEach((document) {
      //       //     print(document['text']);
      //       //   });
      //       // print(data.documents[0]['text']);
      //     }),
    );
  }
}
