//import 'package:flutter/material.dart';
//import 'package:graineasy/manager/api_call/API.dart';
//import 'package:graineasy/manager/base/base_view.dart';
//import 'package:graineasy/model/order.dart';
//import 'package:graineasy/ui/theme/app_responsive.dart';
//import 'package:graineasy/ui/theme/palette.dart';
//import 'package:graineasy/ui/theme/text_style.dart';
//import 'package:graineasy/ui/view/Bargain/bargain_request/bargain_request_model.dart;
//import 'package:graineasy/ui/widget/AppBar.dart';
//import 'package:graineasy/ui/widget/widget_utils.dart';
//import 'package:graineasy/utils/check_internet/utility.dart';
//import 'package:graineasy/utils/ui_helper.dart';
//
//const URL = "https://graineasy.com";
//
//class BargainRequestView extends StatefulWidget {
//  Order orderList;
//
//  BargainRequestView(this.orderList);
//
//  @override
//  _CartViewState createState() => _CartViewState();
//}
//
//class _CartViewState extends State<BargainRequestView> with CommonAppBar {
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return BaseView<BargainRequestViewModel>(
//        builder: (context, model, child) {
//      return new Scaffold(
//        appBar: new AppBar(
//          title: Text('Manage Order Detail'),
//          backgroundColor: Colors.white,
//        ),
//        body: _getBody(model),
//      );
//    });
//  }
//
//  Widget _getBody(BargainRequestViewModel model) {
//    return Stack(
//      children: <Widget>[
//        widget.orderList != null ? _getBaseContainer(model) : Container(),
//        getProgressBar(model.state)
//      ],
//    );
//  }
//
//  void showMessage(BargainRequestViewModel model) {
//    try {
//      Future.delayed(const Duration(milliseconds: 500), () {
//        if (model.shouldShowMessage) {
//          model.messageIsShown();
//          showErrorMessage(context, model.message, model.isError);
//        }
//      });
//    } catch (e) {
//      print(e);
//    }
//  }
//
//  _getBaseContainer(BargainRequestViewModel model) {
//    String status = widget.orderList.status;
//    return SingleChildScrollView(
//      child: new Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          orderDetailList(model),
//          Container(
//              padding: EdgeInsets.only(left: 10),
//              alignment: Alignment.centerLeft,
//              child: Text(
//                'Select OrderStatus:',
//                style: TextStyle(
//                    color: Palette.assetColor,
//                    fontSize: 18,
//                    fontWeight: FontWeight.w500),
//              )),
//          Padding(
//            padding: const EdgeInsets.only(left: 10, right: 10),
//            child: DropdownButton<String>(
//              underline: Container(
//                decoration: BoxDecoration(
//                    border:
//                        Border(bottom: BorderSide(color: Palette.assetColor))),
//              ),
//              isExpanded: true,
//              elevation: 4,
//              icon: Icon(
//                Icons.arrow_drop_down,
//                color: Palette.assetColor,
//              ),
//              hint: new Text(
//                widget.orderList.status,
//                style: AppTextStyle.getLargeHeading(false, Palette.assetColor),
//              ),
//              value: model.selectedOrderStatus,
//              onChanged: (String selectedOrderStatus) {
//                setState(() {
//                  model.selectedOrderStatus = selectedOrderStatus;
//                });
//              },
//              items: API.orderStatus.map((String status) {
//                return new DropdownMenuItem<String>(
//                  value: status,
//                  child: new Text(
//                    status,
//                    style: TextStyle(color: Palette.assetColor),
//                  ),
//                );
//              }).toList(),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
//            child: model.selectedOrderStatus == 'cancelled'
//                ? getTextFormField(model)
//                : Container(),
//          ),
//          widget.orderList.status != model.selectedOrderStatus
//              ? getUpdateBtn(model)
//              : Container()
//        ],
//      ),
//    );
//  }
//
//  orderDetailList(BargainRequestViewModel model) {
//    return Container(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Card(
//            color: Palette.whiteTextColor,
//            child: Container(
//                margin: EdgeInsets.all(10),
//                width: double.infinity,
//                height: 200,
//                child:
//                    WidgetUtils.getCategoryImage(widget.orderList.item.image)),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
//            child: new Text(
//              widget.orderList.item.name,
//              style: TextStyle(
//                  fontSize: 20.0,
//                  color: Palette.assetColor,
//                  fontWeight: FontWeight.bold),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 10),
//            child: new Text(
//              "OrderId: " + widget.orderList.id,
//              style: TextStyle(
//                  fontSize: 16.0,
//                  color: Palette.assetColor,
//                  fontWeight: FontWeight.w500),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 10),
//            child: new Text(
//              "Amount: " + widget.orderList.cost.toString(),
//              style: TextStyle(
//                  fontSize: 16.0,
//                  color: Palette.assetColor,
//                  fontWeight: FontWeight.w500),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 10),
//            child: new Text(
//              "Order Type: " + widget.orderList.ordertype,
//              style: TextStyle(
//                  fontSize: 16.0,
//                  color: Palette.assetColor,
//                  fontWeight: FontWeight.w500),
//            ),
//          ),
//
//          Padding(
//            padding: const EdgeInsets.only(left: 10),
//            child: new Text(
//              "Status: " + widget.orderList.status,
//              style: TextStyle(
//                  fontSize: 16.0,
//                  color: Palette.assetColor,
//                  fontWeight: FontWeight.w500),
//            ),
//          ),
//
//          Padding(
//            padding: const EdgeInsets.only(left: 10),
//            child: new Text(
//              "Address: " +
//                  widget.orderList.item.address.text +
//                  "" +
//                  widget.orderList.item.address.city.name,
//              style: TextStyle(
//                  fontSize: 16.0,
//                  color: Palette.assetColor,
//                  fontWeight: FontWeight.w500),
//            ),
//          ),
//
//          Padding(
//            padding: const EdgeInsets.only(left: 10, top: 3),
//            child: new Text(
//              "OrderDate: " +
//                  Utility.dateTimeToString(widget.orderList.placedTime),
//              style: TextStyle(
//                  fontSize: 16.0,
//                  color: Palette.assetColor,
//                  fontWeight: FontWeight.w500),
//            ),
//          ),
//
////            Padding(
////              padding: const EdgeInsets.only(left: 10),
////              child: Text(
////                'To Deliver On :' +
////                    Utility.dateTimeToString(
////                       widget.orderList.placedTime),
////                style: TextStyle(
////                    fontSize: 14.0, color:Palette.assetColor),
////              ),
////            ),
//          UIHelper.verticalSpaceSmall1,
//        ],
//      ),
//    );
//  }
//
//  getTextFormField(BargainRequestViewModel model) {
//    return TextFormField(
//      controller: model.remarkController,
//      focusNode: model.remarkFocus,
//      style: TextStyle(
//        color: Palette.assetColor,
//      ),
//      keyboardType: TextInputType.text,
//      decoration: InputDecoration(
//        hintText: 'Remark',
//
//        disabledBorder: new UnderlineInputBorder(
//          borderSide: new BorderSide(color: Palette.assetColor),
//        ),
//        focusedBorder: new UnderlineInputBorder(
//          borderSide: new BorderSide(color: Palette.assetColor),
//        ),
//        enabledBorder: new UnderlineInputBorder(
//          borderSide: new BorderSide(color: Palette.assetColor),
//        ),
//        errorBorder: new UnderlineInputBorder(
//          borderSide: new BorderSide(color: Palette.assetColor),
//        ),
//        border: new UnderlineInputBorder(
//          borderSide: new BorderSide(color: Palette.assetColor),
//        ),
//
////                            border: OutlineInputBorder(
////                                borderRadius: BorderRadius.circular(25.0)),
//        hintStyle: TextStyle(
//          color: Palette.assetColor,
//        ),
//      ),
//    );
//  }
//
//  getUpdateBtn(BargainRequestViewModel model) {
//    return Padding(
//      padding: const EdgeInsets.all(10.0),
//      child: RaisedButton(
//        color: Palette.loginBgColor,
//        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//        child: Text(
//          'Update Order',
//          style: AppTextStyle.commonTextStyle(
//              Palette.whiteTextColor,
//              AppResponsive.getFontSizeOf(30),
//              FontWeight.bold,
//              FontStyle.normal),
//        ),
//        onPressed: () {
//          model.updateStatus(widget.orderList.id, model.selectedOrderStatus);
//          print('data');
//        },
//      ),
//    );
//  }
//}
