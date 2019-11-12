import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/view/cart_screen/cart_view_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:graineasy/utils/ui_helper.dart';

const URL = "https://graineasy.com";

class CartView extends StatefulWidget {
  final List<CartItem> cartItems;

  CartView(this.cartItems);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> with CommonAppBar {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(builder: (context, model, child) {
      model.init(widget.cartItems);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Cart'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(CartViewModel model) {
    return Stack(
      children: <Widget>[
        model.userModel != null ? _getBaseContainer(model) : Container(),
//        _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(CartViewModel model) {
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

  _getBaseContainer(CartViewModel model) {
    return new Column(
      children: <Widget>[
        orderList(model),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 3),
          child: Divider(
            color: Palette.assetColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(
                'Total Price:',
                style: TextStyle(color: Palette.assetColor, fontSize: 15),
              ),
              alignment: Alignment.topRight,
            ),
            UIHelper.horizontalSpaceSmall,
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text('${model.totalPriceOfTheOrder}',
                  style: TextStyle(
                      color: Palette.assetColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Address',
              style: TextStyle(
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            )),
        Container(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: 155.0,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: model.userModel.addresses.length,
              itemBuilder: (BuildContext cont, int ind) {
                return addressWidget(model.userModel.addresses[ind]);
              },
            ),
          ),
        ),
        Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: RaisedButton(
              color: Palette.assetColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              onPressed: () {},
              child: Text('Place Order',
                  style: TextStyle(
                      color: Palette.whiteTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ))
      ],
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  addressWidget(Address address) {
    return Card(
        elevation: 3.0,
        margin: EdgeInsets.all(10),
        child: Container(
            padding: EdgeInsets.all(10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text(
                  address.text,
                  style: TextStyle(
                    color: Palette.assetColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                _verticalDivider(),
                new Text(
                  address.city.name + ', ' + address.city.state.name,
                  style: TextStyle(
                      color: Palette.assetColor,
                      fontSize: 13.0,
                      letterSpacing: 0.5),
                ),
                _verticalDivider(),
                new Text(
                  address.pin,
                  style: TextStyle(
                      color: Palette.assetColor,
                      fontSize: 13.0,
                      letterSpacing: 0.5),
                ),
                new Container(
                  margin: EdgeInsets.only(
                      left: 00.0, top: 05.0, right: 0.0, bottom: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        'Delivery Address',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Palette.assetColor,
                            fontWeight: FontWeight.w200),
                      ),
                      _verticalD(),
                      new Checkbox(
                        value: true,
                        onChanged: (bool value) {
                          setState(() {
//                            checkboxValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  setWidgetData(String title, String value) {
    return Column(
      children: <Widget>[
        new Text(
          title,
          style: TextStyle(fontSize: 16.0, color: Palette.assetColor),
        ),
        UIHelper.verticalSpaceExtraSmall,
        new Text(
          value,
          style: TextStyle(
              fontSize: 16.0,
              color: Palette.assetColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  orderList(CartViewModel model) {
    return ListView.builder(
        itemCount: model.cartItems.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext cont, int ind) {
          return Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  child: Container(
                      width: 80,
                      height: 80,
                      color: Palette.assetColor,
                      child: WidgetUtils.getCategoryImage(
                          widget.cartItems[ind].item.image)),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          model.cartItems[ind].item.name,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Palette.assetColor,
                              fontWeight: FontWeight.bold),
                        ),
                        UIHelper.verticalSpaceSmall1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            setWidgetData('Unit Price',
                                model.cartItems[ind].item.price.toString()),
                            setWidgetData(
                                'Qty', model.cartItems[ind].qty.toString()),
                            setWidgetData('Total',
                                model.cartItems[ind].totalPrice.toString()),
                          ],
                        ),
                      ],
                    ),
                    /*Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            new Text(
                              widget.data[ind].name,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Palette.assetColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            new Text(
                              widget.data[ind].price.toString()+'(per kg)',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Palette.assetColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            new Text(
                              widget.qty +'(qty)'+ ' * ' +  widget.data[ind].price.toString()+'(per kg)',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Palette.assetColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),*/
                  ),
                )
              ],
            ),
          );
        });
  }
}
