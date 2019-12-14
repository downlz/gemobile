import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/cart_screen/cart_view.dart';

class GBDetailsViewModel extends BaseModel {
  Groupbuy gbitemDetails;
  User user;

  void init(Groupbuy gbitem, String id) async {

    user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    gbitemDetails = await API.getGBListings();
    setState(ViewState.Idle);


//    if (isFirstTime)
//      if (id != null) {
//        user = await UserPreferences.getUser();
//        setState(ViewState.Busy);
//        gbitemDetails = await API.getItemFromId(id);
//        setState(ViewState.Idle);
//        isFirstTime = false;
////              checkBargainActiveOrNot(false);
//
//
//    }
//      else {
//        if (isFirstTime) {
//          gbitemDetails = item;
//          user = await UserPreferences.getUser();
//          getItemDetails(gbitemDetails.id);
//          isFirstTime = false;
////          checkBargainActiveOrNot(true);
//        }
//      }

  }

//  void getItemDetails(String id) async {
//    print("Selected item id==> $id");
//    setState(ViewState.Busy);
//    gbitemDetails = await API.getItemFromId(id);
//    setState(ViewState.Idle);
//    print('selected==${gbitemDetails.price}');
//  }

  void calculatePrice(Item item, String sellerId, String buyerId,
      int qty) async {
    setState(ViewState.Busy);

    var totalPrice = await API.getCalculatePrice(
        item.id, sellerId, buyerId, qty);
    List<CartItem> cartItems = [];
    cartItems.add(new CartItem(qty, totalPrice, item));
    setState(ViewState.Idle);
    print(totalPrice);
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) =>
                CartView(cartItems)));
  }


//  Future initiateBargain(String buyerQuote, String quantity) async {
//    setState(ViewState.Busy);
//    await API.createBargainRequest(
//        gbitemDetails.id, user.id, buyerQuote, quantity);
//    checkBargainActiveOrNot(false);
//  }
//
//
//  Future checkBargainActiveOrNot(bool showProgress) async
//  {
//    print('Product id============> ${gbitemDetails.id}');
//    if (showProgress)
//      setState(ViewState.Busy);
//    bargainDetail = !user.isSeller ?
//    await API.checkBuyerRequestActiveOrNot(gbitemDetails.id, user.id) :
//    await API.checkSellerRequestActiveOrNot(
//        gbitemDetails.id, gbitemDetails.seller.id);
//    setState(ViewState.Idle);
//  }
}

