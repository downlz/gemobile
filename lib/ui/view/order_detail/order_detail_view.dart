import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/view/order_detail/order_detail_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:graineasy/utils/check_internet/utility.dart';
import 'package:graineasy/utils/ui_helper.dart';

const URL = "https://graineasy.com";

class OrderDetailView extends StatefulWidget {
  Order orderList;

  OrderDetailView(this.orderList);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<OrderDetailView> with CommonAppBar {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderDetailViewModel>(builder: (context, model, child) {
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Order Detail'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(OrderDetailViewModel model) {
    return Stack(
      children: <Widget>[
        widget.orderList != null ? _getBaseContainer(model) : Container(),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(OrderDetailViewModel model) {
    try {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (model.shouldShowMessage) {
          model.messageIsShown();
          showErrorMessage(context, model.message, model.isError);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  _getBaseContainer(OrderDetailViewModel model) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        orderDetailList(model),
      ],
    );
  }

  orderDetailList(OrderDetailViewModel model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            color: Palette.whiteTextColor,
            child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: 200,
                child:
                    WidgetUtils.getCategoryImage(widget.orderList.item.image)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
            child: new Text(
              widget.orderList.item.name,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "OrderId: " + widget.orderList.id,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Amount: " + widget.orderList.cost.toString(),
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Order Type: " + widget.orderList.ordertype,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Status: " + widget.orderList.status,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Address: " +
                  widget.orderList.item.address.text +
                  "" +
                  widget.orderList.item.address.city.name,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10, top: 3),
            child: new Text(
              "OrderDate: " +
                  Utility.dateTimeToString(widget.orderList.placedTime),
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

//            Padding(
//              padding: const EdgeInsets.only(left: 10),
//              child: Text(
//                'To Deliver On :' +
//                    Utility.dateTimeToString(
//                       widget.orderList.placedTime),
//                style: TextStyle(
//                    fontSize: 14.0, color:Palette.assetColor),
//              ),
//            ),
          UIHelper.verticalSpaceSmall1,
        ],
      ),
    );
  }
}
