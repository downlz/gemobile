import 'package:graineasy/HomeScreen.dart';
import 'package:graineasy/item_details.dart';
import 'package:graineasy/logind_signup.dart';
import 'package:graineasy/item_screen.dart';
import 'package:graineasy/Cart_Screen.dart';
import 'package:graineasy/orderhistory_screen.dart';
import 'package:graineasy/Payment_Screen.dart';
import 'package:graineasy/checkout_screen.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'dart:io';
//import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override


  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.

            primaryColor: Colors.white,
            primaryColorDark: Colors.white30,
            accentColor: Colors.blue

        ),
      routes: <String,WidgetBuilder>{
        "/HomeScreen": (BuildContext context) => Home_screen(),
        "/ItemDetails": (BuildContext context) => Item_Details(),
        "/LoginScreen": (BuildContext context) => Login_Screen(),
        "/ItemScreen": (BuildContext context) => Item_Screen(),
        "/CartScreen": (BuildContext context) => Cart_screen(),
        "/OrderHistory": (BuildContext context) => Oder_History(),
        "/PaymentScreen": (BuildContext context) => Payment_Screen(),
        "/CheckoutScreen": (BuildContext context) => Checkout()
      },
      home: new MyHomePage(title: 'Graineasy'),
    );
  }
}

//Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//  if (message.containsKey('data')) {
//    // Handle data message
//    final dynamic data = message['data'];
//  }
//
//  if (message.containsKey('notification')) {
//    // Handle notification message
//    final dynamic notification = message['notification'];
//  }
//
//  // Or do other work.
//}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
//  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

// TODO...

}

class _MyHomePageState extends State<MyHomePage> {

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home_screen()));

  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Container(
      alignment: Alignment.center,
      decoration: new BoxDecoration(color: Colors.white),
      child: new Container(
        color: Colors.black12,
        margin: new EdgeInsets.all(30.0),
        width: 250.0,
        height: 250.0,
        child: new Image.asset(
          'images/gelogo.png',
        ),
      ),
    );
  }



}
