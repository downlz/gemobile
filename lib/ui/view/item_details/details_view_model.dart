import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/ui/view/cart_screen/cart_view.dart';

class DetailsViewModel extends BaseModel {
  Item itemDetails;
  bool isFirstTime = true;
  static String price;

  void init(String id) {
    if (isFirstTime) {
      getItemDetails(id);
      isFirstTime = false;
    }
  }

  void getItemDetails(String id) async {
    print("Selected item id==> $id");
    setState(ViewState.Busy);
    itemDetails = await API.getItemFromId(id);
    setState(ViewState.Idle);
  }

  void calculatePrice(Item item, String sellerId, String buyerId,
      int qty) async {
    setState(ViewState.Busy);
    int totalPrice = await API.getCalculatePrice(
        item.id, sellerId, buyerId, qty);
    List<CartItem> cartItems = [];
    cartItems.add(new CartItem(qty, totalPrice, item));
    setState(ViewState.Idle);

    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) =>
                CartView(cartItems)));
  }

}
