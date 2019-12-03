import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/ui/view/manage_order/manage_order/manage_order_view.dart';

class ManageOrderDetailViewModel extends BaseModel {
  String selectedOrderStatus;

  bool isListEmpty = false;
  TextEditingController remarkController = new TextEditingController();
  var remarkFocus = new FocusNode();

  bool isFirstTime = true;
  Order order;

  Future init(String id, Order orderList) async {
    if (isFirstTime) {
      if (id != null) {
        setState(ViewState.Busy);
        orderList = await API.getOrderById(id);
        setState(ViewState.Idle);
        this.order = orderList;
        print('orderId===========>${this.order.status}');
        isFirstTime = false;
      }
      this.order = orderList;
    }
  }
  updateStatus(String id) async {
    setState(ViewState.Busy);
    await API.updateOrderStatus(id, selectedOrderStatus, remarkController.text);
    setState(ViewState.Idle);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ManageOrderView()));
  }
}
