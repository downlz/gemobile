import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';

class OrderHistoryViewModel extends BaseModel {
  bool isListEmpty = false;
  List<Order> orderList;

  bool isFirstTime = true;

  getOrders() async {
    setState(ViewState.Busy);
    User user = await UserPreferences.getUser();
    print('userid====>${user.id}');
    if (user.isSeller || user.isBuyer) {                // Ideally seller would not have any orders
      orderList = await API.getUserOrders(user.id);
    } else if (user.isAdmin){
      orderList = await API.getOrders();
    } else if (user.isAgent){
      orderList = await API.getAgentOrders(user.id);
    } else {
      // Will think in future
    }
    orderList = await API.getParticularUserOrders(user.id);
    setState(ViewState.Idle);
  }

  void init(String id) {
    if (isFirstTime) {
      getOrders();
      isFirstTime = false;
    }
  }
}
