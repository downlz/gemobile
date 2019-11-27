import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/order.dart';

class OrderDetailViewModel extends BaseModel {
  bool isFirstTime = true;
  Order order;

  Future init(String id, Order orderList) async {
    if (isFirstTime) {
      this.order = orderList;
      if (id != null) {
        setState(ViewState.Busy);
        orderList = await API.getOrderById(id);
        setState(ViewState.Idle);
        this.order = orderList;
        print('orderId===========>${this.order}');
      }
      isFirstTime = false;
    }
  }


}
