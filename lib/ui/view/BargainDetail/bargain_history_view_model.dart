import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/user.dart';

class BargainHistoryViewModel extends BaseModel {
  List<Bargain> bargainList = null;
  bool isFirstTime = true;
  User user;

  void init() {
    if (isFirstTime)
      getBargainHistory();
    isFirstTime = false;
  }

  Future getBargainHistory() async {
    user = await UserPreferences.getUser();
    print(user.id);
    setState(ViewState.Busy);
    bargainList = await API.getUserBargainHistory(user.isSeller, user.id);
    setState(ViewState.Idle);
  }
}
