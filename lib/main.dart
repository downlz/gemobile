import 'package:graineasy/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/ui/view/router.dart';

import 'model/user.dart';

//void main() => runApp(new MyApp());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  checkUserLoggedinOrNot();
}


void checkUserLoggedinOrNot() async {
  User user = await UserPreferences.getUser();
  if (user != null && user.name != null) {
    runApp(MyApp(Screen.Home_screen));
  } else {
    runApp(MyApp(Screen.Login));
  }
}

class MyApp extends StatelessWidget {
  Screen screenName;
  MyApp(this.screenName);
  // This widget is the root of your application.
  @override


  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
            primaryColor: Colors.white,
            primaryColorDark: Colors.white30,
            accentColor: Colors.blue

        ),
      initialRoute: screenName.toString(),
      onGenerateRoute: Router.generateRoute,
//      routes: <String,WidgetBuilder>{
//        "/HomeScreen": (BuildContext context) => Home_screen(),
//        "/ItemDetails": (BuildContext context) => Item_Details(),
//        "/LoginScreen": (BuildContext context) => LoginView(),
//        "/ItemScreen": (BuildContext context) => Item_Screen(),
//        "/CartScreen": (BuildContext context) => Cart_screen(),
//        "/OrderHistory": (BuildContext context) => Oder_History(),
//        "/PaymentScreen": (BuildContext context) => Payment_Screen(),
//        "/CheckoutScreen": (BuildContext context) => Checkout()
//      },

    );
  }
}


//class MyHomePage extends StatefulWidget {
//
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
////  _MessageHandlerState createState() => _MessageHandlerState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//
//  startTime() async {
//    var _duration = new Duration(seconds: 3);
//    return new Timer(_duration, navigationPage);
//  }
//
//  void navigationPage() {
//    Navigator.pushNamedAndRemoveUntil(context, '/LoginScreen',(Route<dynamic> route) => false);
//
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    startTime();
//  }
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//
//    return Container();
//  }
//
//
//
//}
