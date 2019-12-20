import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:graineasy/model/agentbuyer.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/gbcart_item.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';


class GBCartViewModel extends BaseModel {
  List<GBCartItem> cartItems;
  List<Address> addresses;
  List<AgentBuyer> agentbuyer;
  AgentBuyer selectedAgentBuyer;
  List<Order> order;
  bool isFirstTime = true;
  double totalPriceOfTheOrder = 0;
  int selectedAddressPosition = 0;
  User user;

  Future init(List<GBCartItem> cartItems) async {
    if (isFirstTime) {
      isFirstTime = false;
      this.cartItems = cartItems;
//      calculateTotalPrice(this.cartItems);
      user = await UserPreferences.getUser();
      getAddresses(user.phone, user.id);
      getAgentBuyerAddr(user.id);
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


  createOrder(Groupbuy gbitem) async
  {
    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    await API.placeGBOrder(
        cartItems[0], addresses[selectedAddressPosition], user.id ,'groupbuying');
    setState(ViewState.Idle);
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => OrderHistoryView()));
  }


//  void calculateTotalPrice(List<GBCartItem> cartItems) {
//    for (GBCartItem cartItem in cartItems) {
//      totalPriceOfTheOrder = totalPriceOfTheOrder + cartItem.totalPrice;
//    }
//  }
}
