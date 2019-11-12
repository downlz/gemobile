import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/itemname.dart';


class HomeViewModel extends BaseModel
{
  List<ItemName> items;

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
        getItemName();
        isFirstTime = false;

      }
  }

}