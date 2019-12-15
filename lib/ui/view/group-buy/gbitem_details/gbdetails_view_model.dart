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
  Item itemDetails;
  bool isFirstTime = true;
  Bargain bargainDetail;
  User user;

  Future init(Groupbuy gbitem, String id) async {
//    if (isFirstTime)
//      if (id != null) {
//        setState(ViewState.Busy);
        gbitemDetails = gbitem;
        print(gbitemDetails.id);
        user = await UserPreferences.getUser();
//        gbitemDetails = await API.getGBListingDtl(id);
        setState(ViewState.Idle);
//        isFirstTime = false;
//              checkBargainActiveOrNot(false);


//    }
//      else {
//        if (isFirstTime) {
//          itemDetails = item;
//          user = await UserPreferences.getUser();
//          getItemDetails(itemDetails.id);
//          isFirstTime = false;
//          checkBargainActiveOrNot(true);
//        }
//      }

  }

  void getAvlQty(String id) async {

    setState(ViewState.Busy);
    var avlQty = await API.getAvlQty(id);
    setState(ViewState.Idle);
  }

  void getItemDetails(String id) async {
    print("Selected item id==> $id");
    setState(ViewState.Busy);
    itemDetails = await API.getItemFromId(id);
    setState(ViewState.Idle);
    print('selected==${itemDetails.price}');
  }

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


  Future initiateBargain(String buyerQuote, String quantity) async {
    setState(ViewState.Busy);
    await API.createBargainRequest(
        itemDetails.id, user.id, buyerQuote, quantity);
    checkBargainActiveOrNot(false);
  }


  Future checkBargainActiveOrNot(bool showProgress) async
  {
    print('Product id============> ${itemDetails.id}');
    if (showProgress)
      setState(ViewState.Busy);
    bargainDetail = !user.isSeller ?
    await API.checkBuyerRequestActiveOrNot(itemDetails.id, user.id) :
    await API.checkSellerRequestActiveOrNot(
        itemDetails.id, itemDetails.seller.id);
    setState(ViewState.Idle);
  }
}

