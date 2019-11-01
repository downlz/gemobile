import 'package:shared_preferences/shared_preferences.dart';

saveLogout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString('LastUser', "");
  await preferences.setString('LastToken', "");
//  await preferences.setString('LastStatus', "");
//  await preferences.setString('LastAdmin', "");
//  await preferences.setString('LastBuyer', "");
//  await preferences.setString('LastSeller', "");
//  await preferences.setString('LastAgent', "");
  await preferences.setString('LastPhone', "");
}