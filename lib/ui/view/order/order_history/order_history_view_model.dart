import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';

class OrderHistoryViewModel extends BaseModel {
  bool isListEmpty = false;
  List<Order> orderList;
  List<Order> orderListLimit;

  bool isFirstTime = true;
  int present = 0;
  int perPage = 15;
  int pageid = 1;
  var isPageLoading = false;

  getOrders(String id, List<Order> order, int present, int perPage) async {
    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    if (user.isSeller || (user.isBuyer && !user.isAdmin)) {
      orderList = await API.getUserOrders(user.id);
    } else if (user.isAdmin){
//      orderList = await API.getOrders();
      orderList = await API.getOrdersByPageid(pageid);
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
//    notifyListeners();
  }

  init(String id, List<Order> order, int perPage, int present) {
    if (isFirstTime) {
      getOrders(id, order, present, perPage);
      isFirstTime = false;
    }
  }

  getOrdersByPage(List<Order> order) async {
    pageid  = pageid + 1;
    orderList = await API.getOrdersByPageid(pageid);

    setState(ViewState.Busy);

      if ((present + perPage) > orderList.length) {
        order.addAll(
            order.getRange(present, orderList.length));
      } else {
        order.addAll(
            order.getRange(present, present + perPage));
      }
      present = present + perPage;

    setState(ViewState.Idle);
  }

}
