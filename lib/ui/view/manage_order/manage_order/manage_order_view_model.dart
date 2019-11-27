import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';

class ManageOrderViewModel extends BaseModel {
  bool isListEmpty = false;
  User user;
  List<Order> orderList;

  bool isFirstTime = true;

  getOrders() async {
    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    orderList = await API.getParticularUserOrders(user.id);
    setState(ViewState.Idle);
  }

  void init() {
    if (isFirstTime) {
      getOrders();
      isFirstTime = false;
    }
  }
}
