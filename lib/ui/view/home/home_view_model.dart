import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';


class HomeViewModel extends BaseModel
{
  List<ItemName> items;
  User user;
  bool isFirstTime = true;
  String deviceplatform;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();


  void receivePushNotification() {
    firebaseMessaging.getToken().then((token) {
      print('FirebaseToken=======>${token}');
    });
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message ${json.encode(message['notification']['title'])}');
        print('push notification');

        return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => OrderHistoryView())),
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
  }

  getItemName() async
  {
    setState(ViewState.Busy);
    items = await API.getItemName();
    setState(ViewState.Idle);
  }

  Future userDetail() async {
    user = await UserPreferences.getUser();
  }


  void init() {
    if(isFirstTime) {
      getItemName();
      userDetail();
      receivePushNotification();
      isFirstTime = false;
    }
  }


}