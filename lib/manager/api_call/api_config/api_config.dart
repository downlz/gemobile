
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';

class ApiConfig {
  static final String baseURL = 'http://3.16.57.93:3000/api/';
  static String login =baseURL +'auth';
  static String forgotPassword =baseURL +'user/resetpassword';
  static String getCategoryName =baseURL +'itemname';
  static String getCategoryNameByItemName =baseURL +'item/byItemname/';
  static String getItemDetails =baseURL +'item/';
  static int successStatusCode = 200;

  static getHeader() {
    return {"Content-Type": "application/json"};
  }

  static getHeaderWithToken() async
  {

    return {"Content-Type": "application/json",
    "Authorization":'Bearer '+await UserPreferences.getToken()};
  }


}
