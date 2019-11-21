import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/order.dart';

class ManageOrderViewModel extends BaseModel {
  bool isListEmpty = false;
  List<Order> orderList;

  bool isFirstTime = true;

  getOrders() async {
    setState(ViewState.Busy);
    orderList = await API.getOrders();
    setState(ViewState.Idle);
  }

  void init() {
    if (isFirstTime) {
      getOrders();
      isFirstTime = false;
    }
  }
}
