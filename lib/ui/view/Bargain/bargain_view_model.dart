import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/home/home_view.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';

class BargainViewModel extends BaseModel {
  Bargain bargainDetail;
  User user;
  bool isFirstTime = true;

  bool isBargainOn = true;

  void init(Bargain bargainDetail) async {
    if (isFirstTime) {
      this.bargainDetail = bargainDetail;
      user = await UserPreferences.getUser();
      checkQuotationEnded();
      staticChecks();
      isFirstTime = false;
      notifyListeners();
    }
  }

  Future counterBtnClick(String quote) async {
    setState(ViewState.Busy);
    await API.updateBuyerBargainRequest(bargainDetail.id, quote, user.isBuyer);
    setState(ViewState.Idle);
  }

  Future pauseBtnClick(Bargain bargainDetail) async {
    setState(ViewState.Busy);
    await API.pauseBargainRequest(bargainDetail.id);
    setState(ViewState.Idle);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  Future acceptReject(String status) async {
    setState(ViewState.Busy);
    await API.updateBuyerStatus(bargainDetail.id, status);
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
}
