import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';

import 'details_view_model.dart';

const URL = "https://graineasy.com";

//nexttime detail page ma avu tyare and second time bargaining kru tyare
class DetailsView extends StatefulWidget {
  final Item item;

  DetailsView(this.item);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> with CommonAppBar {
  TextEditingController quantityController = new TextEditingController();
  TextEditingController buyerQuoteController = new TextEditingController();
  final qtyFormKey = GlobalKey<FormState>();
  final buyerQuoteFormKey = GlobalKey<FormState>();
  int curretnQty = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailsViewModel>(builder: (context, model, child) {
      model.init(widget.item);
      return new Scaffold(
        appBar: new AppBar(
          title: Text(widget.item.name),
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
        child: Column(children: <Widget>[
          Expanded(child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Card(
                  elevation: 4.0,
                  child: Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.white,
                      child: WidgetUtils.getCategoryImage(
                          model.itemDetails.image)),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: DefaultTextStyle(
                        style: Theme
                            .of(context)
                            .textTheme
                            .subhead,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // three line description
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                model.itemDetails.name,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                model.itemDetails.price.toString(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                    fontSize: 20.0, color: Colors.black54),
                              ),
                            ),
                          ],
                        ))),
                model.itemDetails.bargainenabled && model.bargainDetail == null
                    ? Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    'You can bargain if you want to buy more then ${model
                        .itemDetails.bargaintrgqty}',
                    style: TextStyle(color: Colors.red),),)
                    : Container(),

                Container(
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                        child: Container(
                            padding:
                            const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                            child: DefaultTextStyle(
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
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
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                            ],
                                            onChanged: (qty) {
                                              setState(() {
                                                curretnQty = int.parse(qty);
                                              });
                                            },
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
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: OutlineButton(
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade500),
                                            child: const Text('Add'),
                                            textColor: Colors.amber.shade500,
                                            onPressed: () async {
                                              if (qtyFormKey.currentState
                                                  .validate()) {
                                                User user = await UserPreferences
                                                    .getUser();
                                                model.calculatePrice(
                                                    model.itemDetails,
                                                    model.itemDetails.seller.id,
                                                    user.id, int.parse(
                                                    quantityController.text));
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
                model.itemDetails.bargainenabled && model.bargainDetail == null
                    ? Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    'You can bargain if you want to buy more then ${model
                        .itemDetails.bargaintrgqty}',
                    style: TextStyle(color: Colors.red),),)
                    : Container(),
                Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: DefaultTextStyle(
                        style: Theme
                            .of(context)
                            .textTheme
                            .subhead,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // three line description
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Details',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ],
                        ))),
                Container(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
                    child: Text(
                        "Grocery stores also offer non-perishable foods that are packaged in bottles, boxes, and cans; some also have bakeries, butchers, delis, and fresh produce. Large grocery stores that stock significant amounts of non-food products, such as clothing and household items, are called supermarkets. Some large supermarkets also include a pharmacy, and customer service, redemption, and electronics sections.",
                        maxLines: 10,
                        style: TextStyle(
                            fontSize: 13.0, color: Colors.black38))),

              ])),),
          model.bargainDetail != null ? Padding(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Container(
              alignment: Alignment.center,
              child: OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.amber.shade500),
                  child: const Text('Bargain View'),
                  textColor: Colors.amber.shade500,
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BargainView(
                                    model.bargainDetail)
                        ));
                  },
                  shape: new OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(30.0),
                  )),
            ),) : Container(),
          model.itemDetails.bargainenabled && model.bargainDetail == null &&
              model.itemDetails.bargaintrgqty <= curretnQty
              ? Divider()
              : Container(),
          model.itemDetails.bargainenabled && model.bargainDetail == null &&
              model.itemDetails.bargaintrgqty <= curretnQty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Form(
                  key: buyerQuoteFormKey,
                  child: TextFormField(
                    controller: buyerQuoteController,
                    validator: (value) {
                      return Validation
                          .validateItemQtyAndPrice(
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
                        'Add Best Quote'),
                  ),
                ),

              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10, top: 10, bottom: 10, right: 10),
                child: Container(
                  alignment: Alignment.center,
                  child: OutlineButton(
                      borderSide: BorderSide(
                          color: Colors.amber.shade500),
                      child: const Text('Initiate Bargain'),
                      textColor: Colors.amber.shade500,
                      onPressed: () async {
                        if (buyerQuoteFormKey.currentState.validate()) {
                          model.initiateBargain(buyerQuoteController.text,
                              quantityController.text);
                        }
                      },
                      shape: new OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                ),
              ),
            ],
          ) : Container(),
        ],));
  }

}
