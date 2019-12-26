import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/manage_order/manage_order/manage_order_view.dart';
import 'package:path/path.dart' as path;


class ManageOrderDetailViewModel extends BaseModel {
  String selectedOrderStatus;
  File filePath;
  User user;
  User users;
  bool isListEmpty = false;
  bool manuallBillExists = false;
  TextEditingController remarkController = new TextEditingController();
  var remarkFocus = new FocusNode();

  bool isFirstTime = true;
  Order order;


  init(String id, Order orderList) async {
    if (isFirstTime) {
      if (id != null) {
        setState(ViewState.Busy);
        orderList = await API.getOrderById(id);
        setState(ViewState.Idle);
        this.order = orderList;
        if (order.manualbill.filename != null) {
          manuallBillExists = true;
        }
        isFirstTime = false;
      }
      userDetail();
      this.order = orderList;
      print(order.id);
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

  uploadBill(ManageOrderDetailViewModel model)
  async {
    String filePaths=filePath.path;
    String fileExtension=path.extension(filePaths);
    String fileName=path.basename(filePaths);
    String base64Image = base64Encode(filePath.readAsBytesSync());

    print(filePaths+fileExtension+fileName);
    setState(ViewState.Busy);
    await API.uploadOrderBill(filePath, order.id);
    setState(ViewState.Idle);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ManageOrderView()));
  }


  userDetail() async {
    user = await UserPreferences.getUser();
    API.user = user;
  }

}
