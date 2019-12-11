import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view_model.dart';
import 'package:graineasy/ui/view/order_detail/order_detail_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:graineasy/utils/check_internet/utility.dart';

const URL = "https://graineasy.com";

class OrderHistoryView extends StatefulWidget {
  String id;

  OrderHistoryView();

  @override
  _OrderHistoryViewState createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> with CommonAppBar {

  List<Order> order = new List<Order>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderHistoryViewModel>(builder: (context, model, child) {
      model.init(widget.id, order, model.perPage, model.present);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('My Orders'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(OrderHistoryViewModel model) {
    return Stack(
      children: <Widget>[_getBaseContainer(model), getProgressBar(model.state)],
    );
  }

  void showMessage(OrderHistoryViewModel model) {
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

  _getBaseContainer(OrderHistoryViewModel model) {
    return model.orderList != null && order != null
        ? getCategoryWidget(model)
        : Container();
  }

  getCategoryWidget(OrderHistoryViewModel model) {
    return model.orderList.length <= 0
        ? WidgetUtils.showMessageAtCenterOfTheScreen('No orders found')
        : ListView.builder(
        itemCount: (order.length <= model.orderList.length)
            ? order.length + 1
            : model.orderList.length,
        itemBuilder: (BuildContext cont, int ind) {
          return Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              child: GestureDetector(onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        OrderDetailView(orderList: model.orderList[ind],)));
              },
                child: (ind == order.length) ?
                Container(
                  color: Palette.assetColor,
                  child: FlatButton(
                    child: Text("Load More",
                      style: TextStyle(color: Palette.whiteTextColor,
                          fontSize: 15),),
                    onPressed: () {
                      loadMoreData(model);
                    },
                  ),
                ) :
                Card(
                    elevation: 4.0,
                    child: Container(
                        padding:
                        const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // three line description
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                model.orderList[ind].item.name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'To Deliver On :' +
                                    Utility.dateTimeToString(
                                        model.orderList[ind].placedTime),
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black54),
                              ),
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.amber.shade500,
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                rowWidget(
                                    'Order id', model.orderList[ind]
                                    .orderno),
                                rowWidget('Order Amount',
                                    model.orderList[ind].cost.toString()),
                                rowWidget('Order Type',
                                    model.orderList[ind].ordertype),
                              ],
                            ),
                            model.orderList[ind].address == null
                                ? Container()
                                : Divider(
                              height: 10.0,
                              color: Colors.amber.shade500,
                            ),

                            model.orderList[ind].address == null
                                ? Container()
                                : Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 20.0,
                                  color: Colors.amber.shade500,
                                ),
                                Text(model.orderList[ind].address,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black54)),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.amber.shade500,
                            ),
                            _status(model.orderList[ind].status)
                          ],
                        ))),
              ));
        });
  }

  Widget _status(status) {
    if (status == 'cancelled') {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 18.0,
            color: Colors.red,
          ),
          onPressed: () {
            // Perform some action
          });
    } else {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.green),
          ),
          icon: const Icon(
            Icons.check_circle,
            size: 18.0,
            color: Colors.green,
          ),
          onPressed: () {
            // Perform some action
          });
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }

  rowWidget(String title, String value) {
    return Container(
        padding: EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 13.0, color: Colors.black54),
            ),
            Container(
              margin: EdgeInsets.only(top: 3.0),
              child: Text(
                value,
                style: TextStyle(fontSize: 15.0, color: Colors.black87),
              ),
            )
          ],
        ));
  }


  void loadMoreData(OrderHistoryViewModel model) {
    setState(() {
      if ((model.present + model.perPage) > model.orderList.length) {
        order.addAll(
            order.getRange(model.present, model.orderList.length));
      } else {
        order.addAll(
            order.getRange(model.present, model.present + model.perPage));
      }
      model.present = model.present + model.perPage;
    });
  }
}
