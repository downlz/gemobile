import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/manage_order/manage_order/manage_order_view_model.dart';
import 'package:graineasy/ui/view/manage_order_detail/manage_order_detail_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:graineasy/utils/check_internet/utility.dart';


class ManageOrderView extends StatefulWidget {


  @override
  _ManageOrderViewState createState() => _ManageOrderViewState();
}

class _ManageOrderViewState extends State<ManageOrderView> with CommonAppBar {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ManageOrderViewModel>(builder: (context, model, child) {
      model.init();
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Manage Orders'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(ManageOrderViewModel model) {
    return Stack(
      children: <Widget>[_getBaseContainer(model), getProgressBar(model.state)],
    );
  }

  void showMessage(ManageOrderViewModel model) {
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

  _getBaseContainer(ManageOrderViewModel model) {
    return model.orderList != null ? getCategoryWidget(model) : Container();
  }

  getCategoryWidget(ManageOrderViewModel model) {
    return model.orderList.length <= 0
        ? WidgetUtils.showMessageAtCenterOfTheScreen('No orders found')
        : ListView.builder(
            itemCount: model.orderList.length,
            itemBuilder: (BuildContext cont, int ind) {
              return Container(
                  margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManageOrderDetailView(
                                    orderList: model.orderList[ind])));
                    },
                    child: Card(
                        elevation: 4.0,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 10.0, 10.0),
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
                                    'Ordered On :' +
                                        Utility.dateToString(
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
                                    rowWidget('Order No.',
                                        model.orderList[ind].orderno),
                                    rowWidget('Order Amount',
                                        "\u20B9"+model.orderList[ind].cost.toString()),
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
}
