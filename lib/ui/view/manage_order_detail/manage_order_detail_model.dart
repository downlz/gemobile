import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/ui/view/manage_order/manage_order/manage_order_view.dart';

class ManageOrderDetailViewModel extends BaseModel {
  String selectedOrderStatus;

  bool isListEmpty = false;
  TextEditingController remarkController = new TextEditingController();
  var remarkFocus = new FocusNode();


  updateStatus(String id) async {
    setState(ViewState.Busy);
    await API.updateOrderStatus(id, selectedOrderStatus, remarkController.text);
    setState(ViewState.Idle);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ManageOrderView()));
  }
}
