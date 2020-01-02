import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/user.dart';

class BargainHistoryViewModel extends BaseModel {
  List<Bargain> bargainList = [];
  bool isFirstTime = true;
  int present = 0;
  int pageNumber = 1;
  int perPage = 8;
  User user;
  bool hasNextPage = true;
  String loadingText = '';
  init() {
    if (isFirstTime) {
      getBargainHistory();
      isFirstTime = false;
    }
  }

  getBargainHistory() async {
    user = await UserPreferences.getUser();
    List<Bargain> bargainList;

    setState(ViewState.Busy);
    if (user.isAdmin) {
      bargainList = await API.getAllBargain(pageNumber);
    } else {
      bargainList = await API.getUserBargainHistory(user.isSeller, user.id, pageNumber);
    }
//    if (bargainList.length != 0) {
//      bargain.addAll(bargainList.getRange(present, present + perPage));
//      present = present + perPage;
//    }
    if (bargainList.length <= 0) {
      hasNextPage = false;
      loadingText = 'No bargain data found';
    }
    else
      hasNextPage = true;
    this.bargainList.addAll(bargainList);
    setState(ViewState.Idle);
  }

}
