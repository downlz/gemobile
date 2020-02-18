import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/agentbuyer.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';
//import 'package:graineasy/helpers/showDialogSingleButton.dart';
//import 'package:package_info/package_info.dart';

class CartViewModel extends BaseModel {
  List<CartItem> cartItems;
  List<Address> addresses;
  List<AgentBuyer> agentbuyer;
  AgentBuyer selectedAgentBuyer;
  List<Order> order;
  bool isFirstTime = true;
  double totalPriceOfTheOrder = 0;
  int selectedAddressPosition = 0;
  User user;
  String payeeAcc;
//  bool caughtError = false;
  String version;

  Future init(List<CartItem> cartItems) async {
    if (isFirstTime) {
      isFirstTime = false;
      this.cartItems = cartItems;
//      calculateTotalPrice(this.cartItems);
      user = await UserPreferences.getUser();
      getAddresses(user.phone, user.id);
      getAgentBuyerAddr(user.id);
//      PackageInfo packageInfo = await PackageInfo.fromPlatform();
//      version = packageInfo.version;

    }
  }

  void getAddresses(String phone, String id) async {
    setState(ViewState.Busy);
    addresses = await API.getAddress(phone, id);
    setState(ViewState.Idle);
  }

  void getAgentBuyerAddr(String id) async {
    setState(ViewState.Busy);
    agentbuyer = await API.getUserAgentBuyer(id);
    setState(ViewState.Idle);
  }

//  void getLastOrderNumber() async {
//    setState(ViewState.Busy);
//    order = await API.getLastOrderNumber();
//    calculateOrderNumber(order);
//    setState(ViewState.Idle);
//  }


  createOrder(Item item,String userType,int payeeacc) async
  {
       switch (payeeacc) {
        case 1:
          payeeAcc = 'nodal';
          break;
        case 2:
          payeeAcc = 'seller';
          break;
//        case 2:
//          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
//          break;
    }
    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    if (userType == 'agent') {

    await API.placeOrder(cartItems[0], agentbuyer[selectedAddressPosition], user.id,'agentorder',payeeAcc);
    }
    else {

      try {
        await API.placeOrder(cartItems[0], addresses[selectedAddressPosition], user.id,'regular',payeeAcc);
      }
      catch(e,stackTrace) {
          print('error caught: $e');
          print('stackTrace============>$stackTrace');

//          print(user.name);
//          await API.logErrorTrace(user.name,e,version,'CartViewModel','ANDRIOD');
//          showDialogSingleButton(context,'Application Error','An error was found $e',"Ok");
//          caughtError = true;
      }
    }
       // Sending regular order manually
       setState(ViewState.Idle);
       Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context) => OrderHistoryView()));
  }

//  void calculateTotalPrice(List<CartItem> cartItems) {
//    for (CartItem cartItem in cartItems) {
//      totalPriceOfTheOrder = totalPriceOfTheOrder + cartItem.totalPrice;
//    }
//  }

}
