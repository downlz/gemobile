import 'package:graineasy/model/user.dart';
import 'package:graineasy/model/usermodel.dart';
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
    prefs.setBool('isBuyer', user.isBuyer);
    prefs.setBool('isAdmin', user.isAdmin);
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
    user.isSeller = prefs.getBool("isSeller");
    user.isBuyer = prefs.getBool("isBuyerm");
    user.isAgent = prefs.getBool("isAgent");
    user.isActive = prefs.getBool("isActive");
    user.token = prefs.getString("token");
    user.phone = prefs.getString("phone");
    return user;
  }


  static Future<bool> saveFCMDeviceDtl(UserModel usermodel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmkey', usermodel.fcmkey);
    prefs.setString('devicedtl', usermodel.devicedtl);
    return true;
  }


  static Future<UserModel> getFCMDeviceDtl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel userModel = new UserModel();
    userModel.fcmkey = prefs.getString("fcmkey");
    userModel.devicedtl = prefs.getString("devicedtl");

    return userModel;
  }
  static Future<bool> saveUserAllDetails(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('vendorCode', user.vendorCode);

    prefs.setString('_id', user.id);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('phone', user.phone);
    prefs.setString('pan', user.pan);
    prefs.setString('GST', user.gst);
    prefs.setBool('isBuyer', user.isBuyer);
    prefs.setString('phone', user.phone);

    return true;
  }

  static Future<UserModel> getUserAllDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = new UserModel();
    user.name = prefs.getString("name");
    user.id = prefs.getString("_id");
    user.email = prefs.getString("email");
    user.phone = prefs.getString("phone");
    user.pan = prefs.getString("pan");
    user.gst = prefs.getString("GST");
    user.isBuyer = prefs.getBool("isActive");
    user.phone = prefs.getString("phone");
    return user;
  }

  static Future<String> getToken() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get('token');
  }




}
