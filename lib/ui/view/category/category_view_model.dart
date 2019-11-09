import 'package:flutter/material.dart';
import 'package:graineasy/HomeScreen.dart';
import 'package:graineasy/exception/data_exception.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/listeners/login_listener.dart';
import 'package:graineasy/model/category.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/ui/localization/app_localization.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/utils/check_internet/utility.dart';

import 'package:graineasy/model/Item.dart';

class CategoryViewModel extends BaseModel
{
  bool isListEmpty =  false;
  List<Item> items ;

  bool isFirstTime = true;
  getCategories(String name) async
  {
    setState(ViewState.Busy);
    items = await API.getCategoryFromItemName(name);

    setState(ViewState.Idle);
  }

  void init(String name) {
    if(isFirstTime)
      {
        getCategories(name);
        isFirstTime = false;

      }
  }

  void getItemDetails(String id) async{
    print("Selected item id==> $id");
    setState(ViewState.Busy);
    await API.getItemFromId(id);
    setState(ViewState.Idle);
  }

}