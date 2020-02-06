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


class DetailsView extends StatefulWidget {
  Item item;
  String id;

  DetailsView({this.item, this.id});

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
      model.init(widget.item, widget.id);
      return new Scaffold(
        appBar: new AppBar(
          title: Text(
              widget.item != null ? widget.item.name : model.itemDetails != null
                  ? model.itemDetails.name
                  : ''),
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
                              "\u20B9" + model.itemDetails.price.toString() + "/" +
                                    model.itemDetails.unit.mass,
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

//                model.itemDetails.bargainenabled && model.bargainDetail == null
                  model.checkSeller
                    ? Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    'Showing Items Details',
                    style: TextStyle(color: Colors.blueGrey,fontSize: 18, fontWeight: FontWeight.bold),),)

//                    : Container(),

                : Container(
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
                                                  8),
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
                    !(model.checkSeller || model.checkAgent) ?
                    'You can bargain if you want to buy more than ${model.itemDetails.bargaintrgqty} ${model.itemDetails.unit.mass}'
                        :
                    'Minimum bargain quantity ${model.itemDetails.bargaintrgqty} ${model.itemDetails.unit.mass}',
                    style: TextStyle(color: Colors.blueGrey),),)
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
//                            Padding(
//                              padding: const EdgeInsets.only(bottom: 10.0),
//                              child: Text(
//                                'Details',
//                                style: Theme
//                                    .of(context)
//                                    .textTheme
//                                    .subhead
//                                    .copyWith(
//                                    fontSize: 20.0,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.black87),
//                              ),
//                            ),
                          ],
                        ))),
                detailWidget(model.itemDetails)

              ])),),
          model.bargainDetail != null ? Padding(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Container(
              alignment: Alignment.center,
              child: OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.amber.shade500),
                  child: const Text('View Active Bargain'),
                  textColor: Colors.amber.shade500,
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BargainView(bargainDetail: model.bargainDetail,)
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
              model.itemDetails.bargaintrgqty <= curretnQty && !model.user.isAgent ? Row(
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
                      LengthLimitingTextInputFormatter(8),
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
                        if (buyerQuoteFormKey.currentState.validate())
                        {
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

  detailWidget(Item item) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Manufacturer: " + item.manufacturer.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Item: " + item.itemname.name,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ),
          Text("Category: " + item.category.name,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Text("Origin: " + item.origin,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Text("Grade: " + item.grade,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Text("Brokerage Applicable: " + (item.brokerage ? 'Yes' : 'No'),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Text("Listed By: " + _getListedByDtl(item),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Text((item.showSeller ? 'Seller: ' + item.seller.name : ''),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
//          Text("List Price: " + "Rs. " + item.price.toString() + "/" +
//              item.unit.mass,
//              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  _getListedByDtl(Item item) {
    String listedText;
    if (item.showAddedByName && (item.addedBy != null)){
      listedText = item.addedBy.name;
    } else if (item.addedBy == null) {
      listedText = 'Admin';
    }
    else {
      if (item.addedBy.isAgent) {
        listedText = 'Broker';
      } else if (item.addedBy.isAdmin) {
        listedText  = 'Admin';
      } else {
        listedText = 'Seller';
      }
    }
    return listedText;
  }

}
