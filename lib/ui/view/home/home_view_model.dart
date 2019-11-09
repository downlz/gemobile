import 'package:flutter/material.dart';
import 'package:graineasy/HomeScreen.dart';
import 'package:graineasy/exception/data_exception.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/listeners/login_listener.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/ui/localization/app_localization.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/utils/check_internet/utility.dart';


class HomeViewModel extends BaseModel
{
  List<ItemName> items = [];

  bool isFirstTime = true;
  getItemName() async
  {
    setState(ViewState.Busy);
    items = await API.getItemName();
    setState(ViewState.Idle);
  }

  void init() {
    if(isFirstTime)
      {
        isFirstTime = false;
        getItemName();
      }
  }

}