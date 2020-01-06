import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/user.dart';

Future getuserRole() async {
  User user = await UserPreferences.getUser();
   if (user.isAdmin) {
     return 'admin';
   } else if(user.isAgent){
     return 'agent';
  } else if (user.isBuyer){
  return 'buyer';
  } else if (user.isSeller){
  return 'seller';
  } else if (user.isTransporter){
  return 'transporter';
  } else {
  return 'Not setup yet';
  }
}