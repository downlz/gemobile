import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';


class CartViewModel extends BaseModel {
  List<CartItem> cartItems;
  List<Address> addresses;
  List<Order> order;
  bool isFirstTime = true;
  double totalPriceOfTheOrder = 0;
  int selectedAddressPosition = 0;

  Future init(List<CartItem> cartItems) async {
    if (isFirstTime) {
      isFirstTime = false;
      this.cartItems = cartItems;
//      calculateTotalPrice(this.cartItems);
      User user = await UserPreferences.getUser();
      getAddresses(user.phone, user.id);
    }
  }

  void getAddresses(String phone, String id) async {
    setState(ViewState.Busy);
    addresses = await API.getAddress(phone, id);
    setState(ViewState.Idle);
  }

//  void getLastOrderNumber() async {
//    setState(ViewState.Busy);
//    order = await API.getLastOrderNumber();
//    calculateOrderNumber(order);
//    setState(ViewState.Idle);
//  }


  createOrder(Item item) async {
    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    await API.placeOrder(
        cartItems[0], addresses[selectedAddressPosition], user.id);
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
