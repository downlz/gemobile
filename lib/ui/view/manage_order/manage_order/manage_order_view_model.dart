import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';

class ManageOrderViewModel extends BaseModel {
  User user;
  List<Order> orderList = [];
  int pageNumber = 1;
  bool hasNextPage = true;
  bool isFirstTime = true;

  getOrders() async {
    List<Order> orderList;

    User user = await UserPreferences.getUser();
    setState(ViewState.Busy);
    print("pageNumber======$pageNumber");
    if (user.isSeller) {                // Ideally seller would not have any orders
      orderList = await API.getUserOrder(pageNumber);
    } else if (user.isAdmin){
      orderList = await API.getUserOrder(pageNumber);
    } else if (user.isAgent){
      orderList = await API.getAgentOrders(user.id);
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
