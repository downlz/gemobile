
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';

class ApiConfig {
  static final String baseURL = 'http://3.16.57.93:3000/api/'; // Any idea to store different URL for PROD and DEV! 3.16.57.93
  static String login =baseURL +'auth';
  static String register = baseURL + 'user';
  static String forgotPassword =baseURL +'user/resetpassword';
  static String getCategoryName = baseURL + 'itemName';
  static String getCategoryNameByItemName =baseURL +'item/byItemname/';
  static String getItemDetails =baseURL +'item/';
  static String getUserDetail = baseURL + 'user/me';
  static String getAddress = baseURL + 'address/phone/';
  static String getUserOrderList = baseURL + 'order/user/';
  static String getOrderList = baseURL + 'order';
  static String getState = baseURL + 'state';
  static String getCity = baseURL + 'city';
  static String price = baseURL + 'price';
  static String addAddresses = baseURL + 'address';
  static String getUserAddresses = baseURL + 'address';
  static String getCalculatePrice = baseURL + 'price';
  static String updateAddress = baseURL + 'address/';
  static String searchItem = baseURL + 'item/search/';


  // Order APIs
  static String getLastOrderNumber = baseURL + 'order/orderno';
  static String createOrder = baseURL + 'order';
  static String getAddressByIdAndPhone = baseURL + 'address/byuser/phone/';       // Replaced with getUserAddresses,No longer needed
  static String updateOrderStatus = baseURL + 'order/';
  static String uploadBill = baseURL + 'uploadbill';
  static String updateManualBill = baseURL + 'uploadbill/';
  static String getManualBill = baseURL + 'uploadbill/';
  static String getUserOrders = baseURL + 'order/user/';
  static String getOrderById = baseURL + 'order/id/';
  static String getAgentOrders = baseURL + 'order/agent/';

  // Billing APIs
  static String getPO = baseURL + 'getpo';
  static String getInvoice = baseURL + 'getinvoice';

  // Bargain APIs
  static String raiseBargainRequest = baseURL + 'bargain/';
  static String updateBargainRequest = baseURL + 'bargain/';
  static String getBargainDtl = baseURL + 'bargain/';
  static String pauseBargain = baseURL + 'bargain/pause/';
  static String releaseBargain = baseURL + 'bargain/release/';
  static String lapseTimeBargain = baseURL + 'bargain/lapsetime/';

  // Group Buy APIs
  static String getGBListings = baseURL + 'gblisting/';
  static String getActiveGBListings = baseURL + 'gblisting/active/';
  static String getGBListingDtl = baseURL + 'gblisting/';
  static String getAvlQty = baseURL + 'gblisting/getqty/avl/';
  static String getBookedQty = baseURL + 'gblisting/getqty/booked/';

  // Bank Account
  static String getBankAccount = baseURL + 'bankaccount/';
  static String addBankAccount = baseURL + 'bankaccount/';
  static String updBankAccount = baseURL + 'bankaccount/';
  static String getUserBankAccount = baseURL + 'bankaccount/user/';

  // Agent Buyer
  static String getAllAgentBuyer = baseURL + 'agentbuyer/';
  static String addAgentBuyer = baseURL + 'agentbuyer/';
  static String updAgentBuyer = baseURL + 'agentbuyer/';
  static String getUserAgentBuyer = baseURL + 'agentbuyer/byuser/';

  // Banner
  static String getBanner = baseURL + 'banner/';

  // Application preference
  static String getAppPref = baseURL + 'apppref/';

  //get FCM Key
  static String updateUserApiForGetFcmKey = baseURL + 'user/';
  static int successStatusCode = 200;

  static var getRecentlyAddedItem = baseURL + 'item/recent';
  static var getMostOrdered = baseURL + 'item/ordered/';
  static var getItemNear = baseURL + 'item/nearme/';
  static var getManufacturerData = baseURL + 'manufacturer/';


  static getHeader() {
    return {"Content-Type": "application/json"};
  }

  static getHeaderWithToken() async
  {
    return {
      "Authorization": await UserPreferences.getToken()};
  }

  static getHeaderWithTokenAndContentType() async
  {
    return {
      "Content-Type": "application/json",
      "Authorization": await UserPreferences.getToken()};
  }
  static getHeaderWithAccept() async
  {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": await UserPreferences.getToken()};
  }


}
