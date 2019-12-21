import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/view/order_detail/order_detail_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:graineasy/utils/check_internet/utility.dart';
import 'package:graineasy/utils/ui_helper.dart';
//import 'package:intl/intl.dart';

const URL = "https://graineasy.com";

class OrderDetailView extends StatefulWidget {

  Order orderList;
  String id;

  OrderDetailView({this.orderList, this.id});

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
      model.init(widget.id, widget.orderList);
      print(widget.orderList);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Order Details'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(OrderDetailViewModel model) {
    return Stack(
      children: <Widget>[
        model.order != null ? model.order.item != null ? _getBaseContainer(
            model) : Container() : Container(),
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
                WidgetUtils.getCategoryImage(model.order.item.image)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
            child: new Text(
              model.order.item.name + " " + model.order.item.category.name,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Order No: " + model.order.orderno,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Amount: " + "\u20B9" + model.order.cost.toString(),
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Quantity: " + model.order.quantity.toString() + " " + model.order.unit,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Order Type: " + model.order.ordertype,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              model.order.status=='cancelled' ?
              "Status:"+model.order.status + "(" + model.order.remarks +")"
                  : "Status:"+model.order.status,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Shipping Address: " +
                  getShippingAddress(model.order)
                  +
                  model.order.item.address.text +
                  "" +
                  model.order.item.address.city.name,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10, top: 3),
            child: new Text(
              "Order Date: " +
                  Utility.dateTimeToString(model.order.placedTime),
//                DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.parse(model.order.placedTime));
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
  getShippingAddress(Order orderitem){
    String shipaddr;
    if (orderitem.isshippingbillingdiff == true) {

      shipaddr =  orderitem.shippingaddress.addridentifier.partyname +
          " " +
          orderitem.shippingaddress.addridentifier.gstin +
          " " +
          orderitem.shippingaddress.text +
          " " +
          orderitem.shippingaddress.state.name +
          " " +
          orderitem.shippingaddress.pin +
          " " +
          orderitem.shippingaddress.phone;
    } else if (orderitem.isshippingbillingdiff == false) {
      shipaddr =  orderitem.shippingaddress.addridentifier.partyname +
          " " +
          orderitem.buyer.name +
          " " +
          orderitem.buyer.gst +
          " " +
          orderitem.address +
          " " +
          orderitem.buyer.phone;
    } else {
      shipaddr =  orderitem.buyer.name +
          " " +
          orderitem.buyer.gst +
          " " +
          orderitem.buyer.addresses[0].text +
          " " +
          orderitem.buyer.addresses[0].city.name +
          " " +
          orderitem.buyer.addresses[0].city.state.name +
          " " +
          orderitem.buyer.addresses[0].pin +
          " " +
          orderitem.buyer.phone;
    }
    return shipaddr;
  }
}
