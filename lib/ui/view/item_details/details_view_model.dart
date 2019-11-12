import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/Item.dart';

class DetailsViewModel extends BaseModel {
  bool isListEmpty = false;
  Item itemDetails;
  bool isFirstTime = true;

  void init(String id) {
    if (isFirstTime) {
      getItemDetails(id);
      isFirstTime = false;
    }
  }

  void getItemDetails(String id) async {
    print("Selected item id==> $id");
    setState(ViewState.Busy);
    itemDetails = await API.getItemFromId(id);
    setState(ViewState.Idle);
  }
}
