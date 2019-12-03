import 'package:flutter/material.dart';
import 'package:graineasy/di/locator.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:graineasy/ui/view/router.dart';

import 'manager/api_call/API.dart';
import 'model/user.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  checkUserLoggedinOrNot();
}

void checkUserLoggedinOrNot() async {
  User user = await UserPreferences.getUser();
  UserModel users = await UserPreferences.getUserAllDetail();
//  await getFCMKey();
  if (user != null &&
      user.name != null &&
      await UserPreferences.getToken() != null) {
    API.user = user;
    API.users = users;
    runApp(MyApp(Screen.Home_screen));
  } else {
    runApp(MyApp(Screen.Login));
  }
}
//
//getFCMKey()
//async {
//  String token = await FirebaseMessaging().getToken();
//
//  print('Token=======>${token}');
//
//}

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
          accentColor: Colors.blue),
      initialRoute: screenName.toString(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
