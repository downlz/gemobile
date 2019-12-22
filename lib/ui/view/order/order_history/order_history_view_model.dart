import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';

class OrderHistoryViewModel extends BaseModel {
  bool isListEmpty = false;
  List<Order> orderList;

  bool isFirstTime = true;
  int present = 0;
  int perPage = 8;
  var isPageLoading = false;

  getOrders(String id, List<Order> order, int present, int perPage) async {
    setState(ViewState.Busy);
    User user = await UserPreferences.getUser();
    if (user.isSeller || user.isBuyer) {
      orderList = await API.getUserOrders(user.id);
    } else if (user.isAdmin){
      orderList = await API.getOrders();
    } else if (user.isAgent){
      orderList = await API.getAgentOrders(user.id);
    } else {
      // Will think in future
    }
//    orderList = await API.getParticularUserOrders(user.id);

    if (orderList.length != 0) {
      order.addAll(orderList.getRange(present, present + perPage));
      present = present + perPage;
    }
    setState(ViewState.Idle);
    notifyListeners();
  }

  void init(String id, List<Order> order, int perPage, int present) {
    if (isFirstTime) {
      getOrders(id, order, present, perPage);

      isFirstTime = false;
    }

  }
}
