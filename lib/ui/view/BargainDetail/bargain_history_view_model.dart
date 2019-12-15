import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/user.dart';

class BargainHistoryViewModel extends BaseModel {
  List<Bargain> bargainList = null;
  bool isFirstTime = true;
  int present = 0;
  int perPage = 8;
  User user;

  void init(String id, List<Bargain> bargain, int perPage, int present) {
    if (isFirstTime)
      getBargainHistory(id, bargain, present, perPage);
    isFirstTime = false;
  }

  Future getBargainHistory(String id, List<Bargain> bargain, int present, int perPage) async {
    user = await UserPreferences.getUser();
    print(user.id);
    setState(ViewState.Busy);
    bargainList = await API.getUserBargainHistory(user.isSeller, user.id);
    setState(ViewState.Idle);
    if (bargainList.length != 0) {
      bargain.addAll(bargainList.getRange(present, present + perPage));
      present = present + perPage;
    }
  }

}
