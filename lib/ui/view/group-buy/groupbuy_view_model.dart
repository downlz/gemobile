import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';

class GroupbuyViewModel extends BaseModel
{
  bool isListEmpty =  false;
  List<Item> items ;
  List<Groupbuy> gbitems;

  bool isFirstTime = true;

  void init() {
    print('here');
    getActiveGroupBuyItems();
  }

  getActiveGroupBuyItems() async {
    setState(ViewState.Busy);
    gbitems = await API.getGBListings();
    setState(ViewState.Idle);
  }

}