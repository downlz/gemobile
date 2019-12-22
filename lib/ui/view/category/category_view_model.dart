import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/Item.dart';
import 'package:flutter/scheduler.dart';

class CategoryViewModel extends BaseModel
{
  bool isListEmpty =  false;
  List<Item> items ;

  bool isFirstTime = true;

  void init(String name) {
    if(isFirstTime){
        getCategories(name);
        isFirstTime = false;
        print('Inside');}
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(ViewState.Idle));
    print('outside - cat');
  }

  getCategories(String name) async {
    setState(ViewState.Busy);
    items = await API.getCategoryFromItemName(name);
    setState(ViewState.Idle);
  }

}