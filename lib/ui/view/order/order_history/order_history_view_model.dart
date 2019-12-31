import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';

class OrderHistoryViewModel extends BaseModel {
  List<Order> orderList = [];
  bool isFirstTime = true;
  int pageNumber = 1;
  bool hasNextPage = true;

  getOrders() async {
    List<Order> orderList;
    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    if (user.isAdmin) {
      orderList = await API.getAdminOrders(pageNumber);
    }
    else if (user.isSeller || user.isBuyer) {
//      orderList = await API.getUserOrders(user.id);
      orderList = await API.getUserOrder(pageNumber);
    }
    else if (user.isAgent) {
//      orderList = await API.getAgentOrders(user.id);
      orderList = await API.getAgentOrder(pageNumber);
    } else {
      // Will think in future
    }
    if (orderList.length <= 0)
      hasNextPage = false;
    else
      hasNextPage = true;
    this.orderList.addAll(orderList);
    setState(ViewState.Idle);
  }

  init() {
    if (isFirstTime) {
      getOrders();
      isFirstTime = false;
    }
  }

}
