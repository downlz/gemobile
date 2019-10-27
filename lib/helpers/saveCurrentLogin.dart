import 'package:shared_preferences/shared_preferences.dart';
import 'package:graineasy/model/user.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var user;
  if ((responseJson != null && !responseJson.isEmpty)) {
    user = User.fromJson(responseJson).name;
  } else {
    user = "";
  }

  var token = (responseJson != null && !responseJson.isEmpty) ? User.fromJson(responseJson).token : "";
  var phone = (responseJson != null && !responseJson.isEmpty) ? User.fromJson(responseJson).phone : "";
//  var isActive = (responseJson != null && !responseJson.isEmpty) ? User.fromJson(responseJson).isActive : "";
//  var isAdmin = (responseJson != null && !responseJson.isEmpty) ? User.fromJson(responseJson).isAdmin : "";
//  var isSeller = (responseJson != null && !responseJson.isEmpty) ? User.fromJson(responseJson).isSeller : "";
//  var isBuyer = (responseJson != null && !responseJson.isEmpty) ? User.fromJson(responseJson).isBuyer : "";
//  var isAgent = (responseJson != null && !responseJson.isEmpty) ? User.fromJson(responseJson).isAgent : "";

  await preferences.setString('LastUser', (user != null && user.length > 0) ? user : "");
  await preferences.setString('LastToken', (token != null && token.length > 0) ? token : "");
//  await preferences.setString('LastStatus', (isActive != null && isActive.length > 0) ? isActive : "");
//  await preferences.setString('LastAdmin', (isAdmin != null && isAdmin.length > 0) ? isAdmin : "");
//  await preferences.setString('LastBuyer', (isBuyer != null && isBuyer.length > 0) ? isBuyer : "");
//  await preferences.setString('LastSeller', (isSeller != null && isSeller.length > 0) ? isSeller : "");
//  await preferences.setString('LastAgent', (isAgent != null && isAgent.length > 0) ? isAgent : "");
  await preferences.setString('LastPhone', (phone != null && phone.length > 0) ? phone : "");

}