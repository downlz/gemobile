import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/gbcart_item.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/gbcart_screen/gbcart_view.dart';

class GBDetailsViewModel extends BaseModel {
  Groupbuy gbitemDetails;
  Item itemDetails;
  bool isFirstTime = true;
  Bargain bargainDetail;
  User user;
  int avlQty;
  bool sellercheck = false;

  Future init(Groupbuy gbitem, String id) async {
    if (isFirstTime) {
      setState(ViewState.Busy);
      gbitemDetails = gbitem;
      user = await UserPreferences.getUser();
      sellercheck = user.isSeller;
      getAvlQty(gbitemDetails.id);
      setState(ViewState.Idle);
      isFirstTime = false;
    }
  }

  void getAvlQty(String id) async {

    setState(ViewState.Busy);
    avlQty = await API.getAvlQty(id);
    setState(ViewState.Idle);
  }

  void getItemDetails(String id) async {
    setState(ViewState.Busy);
    itemDetails = await API.getItemFromId(id);
    setState(ViewState.Idle);
  }

  void calculateGBPrice(double dealprice, String buyerId,Groupbuy gbitem,
      int qty) async {
    setState(ViewState.Busy);

//    var totalPrice = await API.getCalculatePrice(
//        item.id, sellerId, buyerId, qty);
    var totalPrice = (dealprice * qty).toString();
    List<GBCartItem> cartItems = [];
    cartItems.add(new GBCartItem(qty, totalPrice, gbitem));
    setState(ViewState.Idle);
    print(totalPrice);
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) =>
                GBCartView(cartItems)));
  }


  Future initiateBargain(String buyerQuote, String quantity) async {
    setState(ViewState.Busy);
    await API.createBargainRequest(
        itemDetails.id, user.id, buyerQuote, quantity);
    checkBargainActiveOrNot(false);
  }


  Future checkBargainActiveOrNot(bool showProgress) async
  {
    if (showProgress)
      setState(ViewState.Busy);
    bargainDetail = !user.isSeller ?
    await API.checkBuyerRequestActiveOrNot(itemDetails.id, user.id) :
    await API.checkSellerRequestActiveOrNot(
        itemDetails.id, itemDetails.seller.id);
    setState(ViewState.Idle);
  }
}

