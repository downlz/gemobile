import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/cart_screen/cart_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';

import 'details_view_model.dart';

const URL = "https://graineasy.com";

class DetailsView extends StatefulWidget {
  final Item itemName;

  DetailsView(this.itemName);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> with CommonAppBar {
  TextEditingController quantityController = new TextEditingController();
  final qtyFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
    theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = Theme.of(context).textTheme.subhead;

    return BaseView<DetailsViewModel>(builder: (context, model, child) {
      model.init(widget.itemName.id);
      return new Scaffold(
        appBar: new AppBar(
          title: Text(widget.itemName.name),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(DetailsViewModel model) {
    return Stack(
      children: <Widget>[
        model.itemDetails != null ? _getBaseContainer(model) : Container(),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(DetailsViewModel model) {
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

  _getBaseContainer(DetailsViewModel model) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Card(
                elevation: 4.0,
                child: Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.white,
                    child: WidgetUtils.getCategoryImage(model.itemDetails.image)),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.subhead,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              model.itemDetails.name,
                              style: Theme.of(context).textTheme.subhead.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              model.itemDetails.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(fontSize: 20.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ))),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Card(
                      child: Container(
                          padding:
                          const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                          child: DefaultTextStyle(
                              style: Theme.of(context).textTheme.subhead,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  // three line description
                                  Form(
                                    key: qtyFormKey,
                                    child: Flexible(
                                      child: Container(
                                        width: 50,
                                        child: TextFormField(
                                          controller: quantityController,
                                          validator: (value) {
//                                        return Validation.validateItemQty(
//                                            value, model.itemDetails.qty);
                                            return Validation
                                                .validateEmptyItemQty(
                                                value, model.itemDetails);
                                          },
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(4),
                                          ],
                                          textAlign: TextAlign.center,
                                          style: AppWidget
                                              .darkTextFieldTextStyle(),
                                          keyboardType: TextInputType.number,
                                          decoration: AppWidget.darkTextField(
                                              'Qty'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: OutlineButton(
                                          borderSide: BorderSide(
                                              color: Colors.amber.shade500),
                                          child: const Text('Add'),
                                          textColor: Colors.amber.shade500,
                                          onPressed: () {
                                            List<Item> data = [];
                                            Item itemss = new Item(
                                                image: model.itemDetails.image,
                                                name: model.itemDetails.name,
                                                price: model.itemDetails.price);
                                            data.add(itemss);
                                            print('dataaaaa==>${data[0].name}');
                                            if (qtyFormKey.currentState
                                                .validate()) {
                                              int totalQty = int.parse(
                                                  quantityController.text);
                                              double totalPrice = totalQty *
                                                  model.itemDetails.price;
                                              List<CartItem> cartItems = [];
                                              cartItems.add(CartItem(
                                                  totalQty, totalPrice,
                                                  model.itemDetails));
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CartView(cartItems)));
                                            }
                                          },
                                          shape: new OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30.0),
                                          )),
                                    ),
                                  ),
                                ],
                              ))))),
              Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.subhead,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Details',
                              style: Theme.of(context).textTheme.subhead.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ],
                      ))),
              Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                      "Grocery stores also offer non-perishable foods that are packaged in bottles, boxes, and cans; some also have bakeries, butchers, delis, and fresh produce. Large grocery stores that stock significant amounts of non-food products, such as clothing and household items, are called supermarkets. Some large supermarkets also include a pharmacy, and customer service, redemption, and electronics sections.",
                      maxLines: 10,
                      style: TextStyle(fontSize: 13.0, color: Colors.black38))),
            ])));
  }
}
