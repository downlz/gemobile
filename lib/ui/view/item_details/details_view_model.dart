import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/cart_screen/cart_view.dart';
import 'package:graineasy/ui/view/BargainDetail/bargain_history_view.dart';

class DetailsViewModel extends BaseModel {
  Item itemDetails;
  bool isFirstTime = true;
  Bargain bargainDetail;
  User user;
  String itemBargainStatus;

  bool checkSeller = false;
  bool checkAgent = false;


  void init(Item item, String id) async {
    if (isFirstTime)
      if (id != null) {
        user = await UserPreferences.getUser();

        setState(ViewState.Busy);
        itemDetails = await API.getItemFromId(id);
        setState(ViewState.Idle);
//        isFirstTime = false;
//              checkBargainActiveOrNot(false);


    }
      else {
        if (isFirstTime) {
          itemDetails = item;
          user = await UserPreferences.getUser();
          getItemDetails(itemDetails.id);
//          isFirstTime = false;
          checkBargainActiveOrNot(true);
        }
      }
    checkSeller = user.isSeller;
    checkAgent = user.isAgent;
    isFirstTime = false;
    print('item details loop');
  }

  void getItemDetails(String id) async {
//    print("Selected item id==> $id");
    setState(ViewState.Busy);
    itemDetails = await API.getItemFromId(id);
    setState(ViewState.Idle);
//    print('selected==${itemDetails.price}');
  }

  void calculatePrice(Item item, String sellerId, String buyerId,
      int qty) async {
    setState(ViewState.Busy);

    var totalPrice = await API.getCalculatePrice(
        item.id, sellerId, buyerId, qty);
    List<CartItem> cartItems = [];
    cartItems.add(new CartItem(qty, totalPrice, item));
    setState(ViewState.Idle);
//    print(totalPrice);
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
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) =>
                BargainHistoryView()));
  }


  Future checkBargainActiveOrNot(bool showProgress) async
  {
//    print('Product id============> ${itemDetails.id}');
    if (showProgress)
      setState(ViewState.Busy);
    bargainDetail = !user.isSeller ? await API.checkBuyerRequestActiveOrNot(itemDetails.id, user.id) :
                    await API.checkSellerRequestActiveOrNot(itemDetails.id, itemDetails.seller.id);
    setState(ViewState.Idle);
    itemBargainStatus = bargainDetail.bargainstatus;

  }
}

