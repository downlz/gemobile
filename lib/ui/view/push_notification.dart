import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotification extends StatefulWidget {
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging();
//bkajhdbbw8989233bhb2hh42b
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }

  void firebaseCloudMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message ${json.encode(message['notification']['title'])}');
//        print('on message ${message}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
    _firebaseMessaging.getToken().then((token) {
      print('FirebaseToken=======>${token}');
    });
  }
}
