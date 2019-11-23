import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_repository.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/state.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:graineasy/ui/view/home/home_view.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';
import 'package:http/http.dart' as http;

import 'api_config/api_config.dart';


class API extends BaseRepository
{

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  static User user;
  static UserModel users;

  static List<String> addressType = [
    'factory',
    'outlet',
    'retail',
    'warehouse',
    'others',
    'registered',
    'delivery'
  ];

  static List<String> orderStatus = [
    'new',
    'confirmed',
    'cancelled',
    'ready',
    'shipped',
    'delivered'
  ];

  static List<String> bargainAction = [
    'placed',
    'negotiation',
    'lastbestprice',
    'accepted',
    'rejected',
    'paused',
    'expired'
  ];


  static void alertMessage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => OrderHistoryView()
                    ));
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => HomeView()
                    ));
              },
            ),
          ],
        );
      },
    );
  }

  static Future<List<ItemName>> getItemName()async{
    var response = await http.get(ApiConfig.getCategoryName,
        headers:  await ApiConfig.getHeaderWithToken());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      List<ItemName> items = ItemName.fromJsonArray(jsonDecode(response.body));
      return items;
    }
    return[];
  }


  static Future<List<Item>> getCategoryFromItemName(String itemName)async{
    print('Item name ==> ${itemName}');
    var response = await http.get(ApiConfig.getCategoryNameByItemName+itemName,
        headers:  await ApiConfig.getHeaderWithToken());
    var add = 'data';
    if (response.statusCode == ApiConfig.successStatusCode) {
      print("cat=====>${response.body}");
      List<Item> items = Item.fromJsonArray(jsonDecode(response.body));
      return items;
    }
    return [];
  }

  static Future<List<Address>> getAddress(String phone, String id) async {
    var response = await http.get(ApiConfig.getUserAddresses+'/byuser/'+id+'/phone/'+phone,
//        'http://3.16.57.93:3000/api/address/byuser/${id}/phone/${phone}',
        headers: await ApiConfig.getHeaderWithToken());
//    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      List<Address> items = Address.fromJsonArray(jsonDecode(response.body));
      return items;
    }
    return[];
  }

  static Future<Item> getItemFromId(String itemId) async {
    var response = await http.get(ApiConfig.getItemDetails+itemId,
        headers:  await ApiConfig.getHeaderWithToken());
    print('respo==>  ${response.body}');
    if (response.statusCode == ApiConfig.successStatusCode) {
      Item item = Item.fromJson(jsonDecode(response.body));
      return item;
    }
    return null;
  }


  static Future<UserModel> getUserDetail() async {
    var response = await http.get(ApiConfig.getUserDetail,
        headers: await ApiConfig.getHeaderWithToken());
    print('respo==>  ${response.body}');
    if (response.statusCode == ApiConfig.successStatusCode) {
      UserModel userDetail = UserModel.fromJson(jsonDecode(response.body));
      UserModel user = UserModel.fromJson(jsonDecode(response.body));
      UserPreferences.saveUserAllDetails(user);
      return userDetail;
    }
    return null;
  }

  static Future<List<Order>> getOrders() async {
    var response = await http.get(ApiConfig.getOrderList,
        headers: await ApiConfig.getHeaderWithToken());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      List<Order> orders = Order.fromJsonArray(jsonDecode(response.body));
      return orders;
    }
    return [];
  }

  static Future<List<Order>> getLastOrderNumber() async {
    var response = await http.get(ApiConfig.getLastOrderNumber,
        headers: await ApiConfig.getHeaderWithToken());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      List<Order> orders = Order.fromJsonArray(jsonDecode(response.body));
      return orders;
    }
    return [];
  }


  static calculatePrice(int qty, String item, String buyer,
      String seller) async {
    var data = {
      'qty': qty,
      'itemId': item,
      'buyerId': buyer,
      'sellerId': seller
    };

    var response = await http.post(ApiConfig.price,
        headers: await ApiConfig.getHeaderWithToken(),
        body: convert.jsonEncode(data));
    if (response.statusCode == ApiConfig.successStatusCode) {
//      print(response.body);
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);

      return response.body;
    } else {
      return null;
    }
  }

  static Future<List<StateObject>> getStateList() async {
    var response = await http.get(ApiConfig.getState,
        headers: await ApiConfig.getHeader());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      List<StateObject> items = StateObject.fromJsonArray(
          jsonDecode(response.body));
      print('sadasassa->${items.length}');
      return items;
    }
    return [];
  }

  static Future<List<City>> getCityList() async {
    var response = await http.get(ApiConfig.getCity,
        headers: await ApiConfig.getHeader());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      List<City> items = City.fromJsonArray(jsonDecode(response.body));
      print('sadasassa->${items.length}');
      return items;
    }
    return [];
  }

  static register(String name, String email, String phone, String password,
      String gst, String address, String city, String state,
      String pincode) async {
    var data = {
      'GST': gst,
      'address': address,
      'cityId': city,
      'email': email,
      'name': name,
      'phone': '+91' + phone,
      'pin': pincode,
      'stateId': state,
      'password': password
    };

    var response = await http.post(ApiConfig.register,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      print(response.body);
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
      return 'Register User';
    } else {
      return 'error';
    }
  }

  static addAddresses(String partyName, String phone, String gstInNo,
      String address, String selectedState, String selectedCity,
      String selectedAddressType, String pinCode) async {
    User user = await UserPreferences.getUser();

    var data = {
      "text": address,
      "pin": pinCode,
      "city": selectedCity,
      "addressbasicdtl": {
        "partyname": partyName,
        "gstin": gstInNo
      },
      "state": selectedState,
      "phone": '+91' + phone,
      "addresstype": selectedAddressType,
      "addedby": user.id
    };

    var response = await http.post(ApiConfig.addAddresses,
        headers: await ApiConfig.getHeaderWithToken(),
        body: convert.jsonEncode(data));
    print('response ${data}');
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      print(response.body);
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
      return 'Add Address';
    } else {
      return null;
    }
  }

  static getCalculatePrice(String id, String sellerId, String buyerId,
      int qty) async {
    var data = {
      'itemId': id,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'qty': qty,
    };

    var response = await http.post(ApiConfig.getCalculatePrice,
        headers: await ApiConfig.getHeaderWithToken(),
        body: convert.jsonEncode(data));
    if (response.statusCode == ApiConfig.successStatusCode) {
      print(response.body);
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['price'];
    } else {
      return 0;
    }
  }

//
  static updateAddress(String id, String address,
      String pin, String cityId, String stateId, String phone,
      String addressType) async {
    User user = await UserPreferences.getUser();
    var data = {
      'text': address,
      'pin': pin,
      'city': cityId,
      'state': stateId,
      'phone': phone,
      'addresstype': addressType,
      'addedby': user.id,
    };

    var response = await http.put(ApiConfig.updateAddress + id,
        headers: await ApiConfig.getHeaderWithToken(),
        body: convert.jsonEncode(data));
    print(response.statusCode);
    if (response.statusCode == ApiConfig.successStatusCode) {
      print('update===${response.body}');
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
      return 'Update User';
    } else {
      return 'error';
    }
  }

  static updateUserApiToGetFCMKey() async {
    String devicedtl = 'iOS';
    if (Platform.isAndroid) {
      devicedtl = 'andriod';
    }
    var data = {
      'fcmkey': await FirebaseMessaging().getToken(),
      "devicedtl": devicedtl
    };
    User user = await UserPreferences.getUser();

    var response = await http.put(ApiConfig.updateUserApiForGetFcmKey + user.id,
        headers: await ApiConfig.getHeaderWithToken(), body: data);
    print(response);
    return;
  }

  static placeOrder(CartItem cart, Address address, String userID) async {
    var data = {
      'quantity': cart.qty,
      'unit': cart.item.unit.mass,
      'cost': cart.item.price,
      'price': cart.totalPrice.toString(),
      // Price is shown correctly in screen but incorrect value coming here
      'itemId': cart.item.id,
      'addressId': address.id,
      'buyerId': userID,
      'sellerId': cart.item.seller.id,
      'placedTime': new DateTime.now().millisecondsSinceEpoch,
      'ordertype': "regular",                                     // To be updated based on type of order
      'status': "new",
      'isshippingbillingsame': false,
      'partyname': address.addridentifier.partyname,
      'gstin': address.addridentifier.gstin,
      'address': address.text,
      'state': address.state.id,
      'phone': address.phone,
      'addresstype': address.addresstype,
      'addedby': userID,
      'addressreference' : address.id,
      'isExistingAddr' : true
    };
    // This is done to generate valid purchase order and calculate GST. Buyer may be buying on behalf of someone and hence it would be billed to that party
    if (address.addresstype != 'registered'){
      data['isshippingbillingdiff'] = true;
      data['partyname'] = address.addridentifier.partyname;
      data['gstin'] = address.addridentifier.gstin;
      data['address'] =  address.text;
      data['pincode'] = address.pin;
      data['state'] = address.state.id;
      data['phone'] = address.phone;
      data['addresstype'] = address.addresstype;
      data['city'] = address.city.id;
    }

    var response = await http.post(ApiConfig.createOrder,
        headers: {"Content-Type": "application/json",
          "Authorization": 'Bearer ' + await UserPreferences.getToken()},
        body: jsonEncode(data));
//    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      print(response.body);
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return 'Create Order';
    } else {
      return 'error';
    }
  }


  static updateOrderStatus(String id, String status, String remarks) async {
    var data = {
      'status': status,
      'remarks' : remarks,
      'lastUpdated': new DateTime.now().millisecondsSinceEpoch
    };

    var response = await http.put(ApiConfig.updateOrderStatus + id,
        headers: {"Content-Type": "application/json",
          "Authorization": await UserPreferences.getToken()},
        body: jsonEncode(data));
    print(response.statusCode);
    if (response.statusCode == ApiConfig.successStatusCode) {
      print('update===${response.body}');
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
      return 'Successfully updated order status';
    } else {
      return 'error';
    }
  }


  static Future<List<StateObject>> getManualOrderBill(String id) async {
    var response = await http.get(ApiConfig.getManualBill + id,
        headers: await ApiConfig.getHeader());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      // Add Code to read output json for bill link
//      List<StateObject> items = StateObject.fromJsonArray(
//          jsonDecode(response.body));
//      print('sadasassa->${items.length}');
//      return items;
    }
    return [];
  }

  static Future<List<StateObject>> uploadManualOrderBill(String id) async {
    var response = await http.post(ApiConfig.addManualBill + id,
        headers: await ApiConfig.getHeader());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      // Add Code to add a file to an order
//      List<StateObject> items = StateObject.fromJsonArray(
//          jsonDecode(response.body));
//      print('sadasassa->${items.length}');
//      return items;
    }
    return [];
  }

  static Future<List<StateObject>> updateManualOrderBill(String id) async {
    var response = await http.put(ApiConfig.updateManualBill + id,
        headers: await ApiConfig.getHeader());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      // Add Code to update a file to an order
//      List<StateObject> items = StateObject.fromJsonArray(
//          jsonDecode(response.body));
//      print('sadasassa->${items.length}');
//      return items;
    }
    return [];
  }

  static Future<List<StateObject>> getUserOrders(String id) async {
    var response = await http.get(ApiConfig.getUserOrders + id,
        headers: await ApiConfig.getHeader());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      // Add Code to read output json for bill link
//      List<StateObject> items = StateObject.fromJsonArray(
//          jsonDecode(response.body));
//      print('sadasassa->${items.length}');
//      return items;
    }
    return [];
  }

  //Bargain APIs Calls


  static Future<Bargain> checkBuyerRequestActiveOrNot(String itemId,
      String buyerId) async
  {
    print("itemId===>${itemId}");
    print("buyerId===>${buyerId}");
    var response = await http.get(
        ApiConfig.raiseBargainRequest + 'buyer/' + buyerId + '/item/' + itemId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": await UserPreferences.getToken()
        });
    if (response.statusCode == ApiConfig.successStatusCode) {
      Bargain bargain = Bargain.fromJsonArray(jsonDecode(response.body))[0];
      print("checkBuyer==${response.body}");
      return bargain;
    }
    return null;
  }

  static Future<Bargain> checkSellerRequestActiveOrNot(String itemId,
      String sellerId) async {
    print("itemId===>${itemId}");
    print("SellerId===>${sellerId}");
    var response = await http.get(
        ApiConfig.raiseBargainRequest + 'seller/' + sellerId + '/item/' +
            itemId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": await UserPreferences.getToken()
        });
    if (response.statusCode == ApiConfig.successStatusCode) {
      Bargain bargain = Bargain.fromJsonArray(jsonDecode(response.body))[0];
      print('checkSeller===>${response.body}');
      return bargain;
    }
    return null;
  }

  static createBargainRequest(String itemId, String buyerId, String buyerQuote,
      String quantity) async
  {
    var data = {
      'itemId': itemId,
      'buyerId': buyerId,
      'buyerquote': int.parse(buyerQuote),
      'quantity': int.parse(quantity)
    };
    print("itemid${itemId}");
    print("buyerId${buyerId}");
    var response = await http.post(ApiConfig.raiseBargainRequest,
        headers: {
          "Content-Type": "application/json",
          "Authorization": await UserPreferences.getToken()
        },
        body: convert.jsonEncode(data));
    print("create=>${response.body}");
    if (response.statusCode == ApiConfig.successStatusCode) {
      return true;
    }
    return false;
  }


  static updateBuyerBargainRequest(String id, String quote,
      bool isBuyer, String action) async {
    var data = {
      "buyerquote": quote,
      "action": action
    };
    if (!isBuyer)
      data = {
        "sellerquote": quote,
        "action": action
      };
    var response = await http.put(ApiConfig.updateBargainRequest + id,
        headers: await ApiConfig.getHeaderWithTokenAndContentType(),
        body: convert.jsonEncode(data));
    if (response.statusCode == ApiConfig.successStatusCode) {
      print('response body with hson decode===> ${jsonDecode(response.body)}');
      Bargain bargain = Bargain.fromJson(jsonDecode(response.body));
      return bargain;
    }
    return null;
  }
// -1 -> rejected quote, 1 -> accepted quote, 0 is not accepted in req body
  static updateBuyerStatus(String id, String status, var data) async {
    var response = await http.put(ApiConfig.updateBargainRequest + id,
        headers: await ApiConfig.getHeaderWithToken(),
        body: convert.jsonEncode(data));
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
    }
    return [];
  }


  static pauseBargainRequest(String bargainId) async {
    User user = await UserPreferences.getUser();
    var data = {
      'pausetype': 'hours',
      'pausehrs': 6,
      'pausedby': user.id
    };
    var response = await http.put(ApiConfig.pauseBargain + bargainId,
        headers: await ApiConfig.getHeaderWithToken(),
        body: convert.jsonEncode(data));
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
    }
    return [];
  }

  static Future<List<StateObject>> releaseBargainRequest(String id) async {
    var response = await http.put(ApiConfig.releaseBargain + id,
        headers: await ApiConfig.getHeader());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {}
    return [];
  }

  static Future<List<Bargain>> getUserBargainHistory(bool isSeller,
      String id) async {
    String url = "http://3.16.57.93:3000/api/bargain/";
    if (isSeller)
      url = url + "seller/";
    else
      url = url + "buyer/";

    String finalUrl = url + id;
    var response = await http.get(
        finalUrl,
        headers: await ApiConfig.getHeader());

    if (response.statusCode == ApiConfig.successStatusCode) {}
    return [];
  }

  static Future<UserModel> getUserDetailForPushNotification(String title,
      String body, String id) async {
    var response = await http.get(ApiConfig.getUserDetail,
        headers: await ApiConfig.getHeaderWithToken());
    if (response.statusCode == ApiConfig.successStatusCode) {
      print(response.body);
      UserModel userDetail = UserModel.fromJson(jsonDecode(response.body));
      UserModel user = UserModel.fromJson(jsonDecode(response.body));
      UserPreferences.saveUserAllDetails(user);
      UserModel userModel = await UserPreferences.getUserAllDetail();
      String fcmKey = userModel.fcmkey;
      print(fcmKey);
      return userDetail;
    }
    return null;
  }


  Future<Map<String, dynamic>> sendAndRetrievePushNotification(String title,
      String body) async
  {
    UserModel user = await UserPreferences.getUserAllDetail();
    String fcmKey = user.fcmkey;
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$fcmKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': title,
            'title': body
          },
          'priority': 'high',
//          'data': <String, dynamic>{
//            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//            'id': '1',
//            'status': 'done'
//          },
          'to': await firebaseMessaging.getToken(),
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
    return completer.future;
  }


}