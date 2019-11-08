import 'package:graineasy/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('email');
    prefs.remove('mobileNumber');
    prefs.remove('profileImage');
    prefs.remove('token');
  }

  static Future<String> getSupportedBuildVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('supportedBuilds');
  }

  static Future<String> getBuildUnderReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('buildUnderReview');
  }




  static Future<bool> saveUserDetails(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', user.name);

    prefs.setString('_id', user.id);
    prefs.setBool('isAdmin', user.isAdmin);
    prefs.setBool('isBuyer', user.isBuyer);
    prefs.setBool('isSeller', user.isSeller);
    prefs.setBool('isAgent', user.isAgent);
    prefs.setBool('isActive', user.isActive);
    prefs.setString('token', user.token);
    prefs.setString('phone', user.phone);

    return true;
  }

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = new User();
    user.name = prefs.getString("name");
    user.id = prefs.getString("_id");
    user.isAdmin = prefs.getBool("isAdmin");
    user.isBuyer = prefs.getBool("isBuyer");
    user.isSeller = prefs.getBool("isSeller");
    user.isAgent = prefs.getBool("isAgent");
    user.isActive = prefs.getBool("isActive");
    user.token = prefs.getString("token");
    user.phone = prefs.getString("phone");
    return user;
  }


}
