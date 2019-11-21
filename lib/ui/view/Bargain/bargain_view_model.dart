import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';

class BargainViewModel extends BaseModel {

  void init(Bargain bargainDetail) {
  }

  Future counterBtnClick(Bargain bargainDetail) async {
    if (bargainDetail.seller.isBuyer == false) {
      setState(ViewState.Busy);
      await API.updateBuyerBargainRequest(bargainDetail.id);
      setState(ViewState.Idle);
    }
    else {
      setState(ViewState.Busy);
      await API.updateSellerBargainRequest(bargainDetail.id);
      setState(ViewState.Idle);
    }
  }


  Future pauseBtnClick(Bargain bargainDetail) async {
    setState(ViewState.Busy);
    await API.pauseBargainRequest(bargainDetail.id);
    setState(ViewState.Idle);
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context) => OrderHistoryView()
        ));
  }

  Future acceptBtnClick(Bargain bargainDetail) async {
    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    await API.updateBuyerStatus(bargainDetail.id);
    setState(ViewState.Idle);
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context) => OrderHistoryView()
        ));
  }

  Future rejectBtnClick(Bargain bargainDetail) async {
    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    await API.updateBuyerRejectStatus(bargainDetail.id);
    setState(ViewState.Idle);
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context) => OrderHistoryView()
        ));
  }


}
