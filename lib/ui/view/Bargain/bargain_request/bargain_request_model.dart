//import 'package:flutter/material.dart';
//import 'package:graineasy/manager/api_call/API.dart';
//import 'package:graineasy/manager/base/basemodel.dart';
//import 'package:graineasy/ui/view/Bargain/bargain_request/bargain_request_view.dart;
//
//class BargainRequestViewModel extends BaseModel {
//  String selectedOrderStatus;
//
//  bool isListEmpty = false;
//  TextEditingController remarkController = new TextEditingController();
//  var remarkFocus = new FocusNode();
//
//  updateStatus(String id, String status) async {
//    setState(ViewState.Busy);
//    await API.updateOrderStatus(id, status, remarkController.text);
//    setState(ViewState.Idle);
//    Navigator.pop(context);
//    Navigator.pushReplacement(
//        context, MaterialPageRoute(builder: (context) => ManageOrderView()));
//  }
//}
