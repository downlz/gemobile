import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/groupbuy.dart';

class GroupbuyViewModel extends BaseModel
{
  List<Groupbuy> gbItems;
  bool isFirstTime = true;

  init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
// Do something here
      if (isFirstTime) {
        getActiveGroupBuyItems();
        isFirstTime = false;
      }
      print('GB Vat view test');
    });
  }

  getActiveGroupBuyItems() async {
    setState(ViewState.Busy);
    gbItems = await API.getGBListings();
    setState(ViewState.Idle);
  }

}