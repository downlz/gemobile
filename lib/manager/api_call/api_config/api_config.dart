
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';

class ApiConfig {
  static final String baseURL = 'http://192.168.0.105:3000/api/';    // Any idea to store different URL for PROD and DEV! 3.16.57.93
  static String login =baseURL +'auth';
  static String register = baseURL + 'user';
  static String forgotPassword =baseURL +'user/resetpassword';
  static String getCategoryName =baseURL +'itemname';
  static String getCategoryNameByItemName =baseURL +'item/byItemname/';
  static String getItemDetails =baseURL +'item/';
  static String getUserDetail = baseURL + 'user/me';
  static String getAddress = baseURL + 'address/phone/';
  static String getOrderList = baseURL + 'order';
  static String getState = baseURL + 'state';
  static String getCity = baseURL + 'city';
  static String price = baseURL + 'price';
  static String addAddresses = baseURL + 'address';
  static String getUserAddresses = baseURL + 'address';
  static String getCalculatePrice = baseURL + 'price';
  static String updateAddress = baseURL + 'address/';

  // Order APIs
  static String getLastOrderNumber = baseURL + 'order/orderno';
  static String createOrder = baseURL + 'order';
  static String getAddressByIdAndPhone = baseURL + 'address/byuser/phone/';       // Replaced with getUserAddresses,No longer needed
  static String updateOrderStatus = baseURL + 'order/';
  static String addManualBill = baseURL + 'uploadbill/';
  static String updateManualBill = baseURL + 'uploadbill/';
  static String getManualBill = baseURL + 'uploadbill/';
  static String getUserOrders = baseURL + 'order/user/';
  static String getAgentOrders = baseURL + 'order/agent/:id';

  // Bargain APIs
  static String raiseBargainRequest = baseURL + 'bargain';
  static String updateBargainRequest = baseURL + 'bargain/';
  static String getBargainDtl = baseURL + 'uploadbill/';
  static String pauseBargain = baseURL + 'bargain/pause/';
  static String releaseBargain = baseURL + 'uploadbill/';

  //get FCM Key
  static String updateUserApiForGetFcmKey = baseURL + 'user/';

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
