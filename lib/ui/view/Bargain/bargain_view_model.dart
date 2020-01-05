import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/home/home_view.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';
import 'package:intl/intl.dart';

class BargainViewModel extends BaseModel {
  Bargain bargainDetail;
  User user;
  bool isFirstTime = true;
  bool isBargainOn = true;
  bool isBuyerQuote = true;
  String lapseTime;
  String getBargainStatus = null;

  void init(Bargain bargainDetail, String id) async {
    print(isFirstTime);
    if (isFirstTime) {
      if (id == null) {
        print('hello');
        isFirstTime = false;
        String lapsetm = await API.lapseTimeBargain(bargainDetail.id);
        lapseTime = DateFormat("dd-MMM-yy hh:mm a").format(DateTime.parse(lapsetm));
        setState(ViewState.Busy);
        this.bargainDetail = bargainDetail;
        user = await UserPreferences.getUser();
        checkQuotationEnded();

        setState(ViewState.Idle);
//        notifyListeners();
      }
      else {
        print('moglo=========${id}');
        isFirstTime = false;
        print('callinglapse');
        String lapsetm = await API.lapseTimeBargain(id);
        lapseTime = DateFormat("dd-MMM-yy hh:mm a").format(DateTime.parse(lapsetm));
        setState(ViewState.Busy);
        print('fetching id');
        bargainDetail = await API.particularBargainDetail(id);
        user = await UserPreferences.getUser();
        if (bargainDetail.bargaincounter == 3 && bargainDetail.thirdquote != null &&
            bargainDetail.thirdquote.sellerquote > 0) {
          isBargainOn = false;
        }
        isBargainOn = true;
        this.bargainDetail = bargainDetail;
        print('now showing');
        print('Update----------->${this.bargainDetail.lastupdated}');

        setState(ViewState.Idle);
      }
      getBargainStatus = bargainDetail.bargainstatus;

    }
    print('outsidehello');
  }

  Future counterBtnClick(String quote, String action) async
  {
    setState(ViewState.Busy);
    bargainDetail = await API.updateBuyerBargainRequest(
        bargainDetail.id, quote, user.isBuyer, action);
    setState(ViewState.Idle);
  }

  Future pauseBtnClick(Bargain bargainDetail) async {
    setState(ViewState.Busy);
    await API.pauseBargainRequest(bargainDetail.id);
    bargainDetail = !user.isSeller ?
    await API.checkBuyerRequestActiveOrNot(bargainDetail.item.id, user.id) :
    await API.checkSellerRequestActiveOrNot(bargainDetail.item.id, user.id);
    setState(ViewState.Idle);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  Future acceptReject(String status) async
  {
    setState(ViewState.Busy);
//    var data = {};
//    if (user.isBuyer) {
//      data = {
//        'buyerquote': getBuyerQuote(),
//        'action': status
//      };
//    } else {
//      data = {
//        'sellerquote': getSellerQuote(),
//        'action': status
//      };
//    }
//    print(data);

    await API.updateBuyerStatus(bargainDetail.id, status, user.isBuyer);
    setState(ViewState.Idle);
    if (status == 'accepted')
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OrderHistoryView()));
    else
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  void checkQuotationEnded() {

    if (bargainDetail.bargaincounter == 3 && bargainDetail.thirdquote != null &&
        bargainDetail.thirdquote.sellerquote > 0) {
      isBargainOn = false;
      return;
    }
    isBargainOn = true;
  }

  void staticChecks() {
//    bargainDetail.bargainstatus = 'paused';
//    bargainDetail.pausebargain.isPaused = true;
//    user.isSeller = true;
//    user.isBuyer = false;
//    user.isSeller = false;
//    user.isBuyer = true;
//    bargainDetail.thirdquote.sellerquote = 0;
//    bargainDetail.thirdquote=null;
  }

  getBuyerQuote() {
    switch (bargainDetail.bargaincounter) {
      case 1:
        return bargainDetail.firstquote.buyerquote;
        break;
      case 2:
        return bargainDetail.secondquote.buyerquote;
        break;
      case 3:
        return bargainDetail.thirdquote.buyerquote;
        break;
    }
  }

  getSellerQuote() {
    switch (bargainDetail.bargaincounter) {
      case 2:
        return bargainDetail.firstquote.sellerquote;
        break;
      case 3:
        if (bargainDetail.thirdquote != null &&
            bargainDetail.thirdquote.sellerquote != null &&
            bargainDetail.thirdquote.sellerquote > 0)
          return bargainDetail.thirdquote.sellerquote;
        else
          return bargainDetail.secondquote.sellerquote;
        break;
    }
  }
}