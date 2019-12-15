import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';

import 'gbdetails_view_model.dart';


class GBDetailsView extends StatefulWidget {
  Groupbuy gbitem;
  String id;


  GBDetailsView({this.gbitem, this.id});

  @override
  _GBDetailsViewState createState() => _GBDetailsViewState();
}

class _GBDetailsViewState extends State<GBDetailsView> with CommonAppBar {
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
    return BaseView<GBDetailsViewModel>(builder: (context, model, child) {
      model.init(widget.gbitem, widget.id);
      return new Scaffold(
        appBar: new AppBar(
          title: Text(
              widget.gbitem != null ? widget.gbitem.item.name : model.gbitemDetails != null
                  ? model.gbitemDetails.item.name
                  : ''),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(GBDetailsViewModel model) {
    return Stack(
      children: <Widget>[
        model.gbitemDetails != null ? _getBaseContainer(model) : Container(),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(GBDetailsViewModel model) {
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

  _getBaseContainer(GBDetailsViewModel model) {
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
                          model.gbitemDetails.item.image)),
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
                                model.gbitemDetails.item.name,
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
                                "\u20B9" + model.gbitemDetails.dealprice.toString() + "/" +
                                    model.gbitemDetails.unit.mass,
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
// Commented by Shahnawaz
//                model.gbitemDetails.bargainenabled && model.bargainDetail == null
//                    ? Container(
//                  margin: EdgeInsets.all(10.0),
//                  child: Text(
//                    'You can bargain if you want to buy more then ${model
//                        .gbitemDetails.bargaintrgqty}',
//                    style: TextStyle(color: Colors.red),),)
//                    : Container(),

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
//                                            validator: (value) {
//                                        return Validation.validateItemQty(
//                                            value, model.gbitemDetails.qty);
//                                              return Validation
//                                                  .validateEmptyItemQty(
//                                                  value, model.gbitemDetails);
//                                            },
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
//                                                model.calculatePrice(
//                                                    model.gbitemDetails,
//                                                    model.gbitemDetails.seller.id,
//                                                    user.id, int.parse(
//                                                    quantityController.text));
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
                model.gbitemDetails.item.bargainenabled && model.bargainDetail == null
                    ?
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    'You can bargain if you want to buy more than ${model
                        .gbitemDetails.item.bargaintrgqty}',
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
                detailWidget(model.gbitemDetails)

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
                                BargainView(bargainDetail: model.bargainDetail,)
                        ));
                  },
                  shape: new OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(30.0),
                  )),
            ),) : Container(),

        ],));
  }

  detailWidget(Groupbuy gbitem) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(gbitem.item.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Sample Number: " + gbitem.item.sampleNo,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ),
          Text("Category: " + gbitem.item.category.name,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Text("Origin: " + gbitem.item.origin,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Text("Manufacturer: " + gbitem.item.manufacturer.name,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Text("List Price: " + "Rs. " + gbitem.item.price.toString() + "/" +
              gbitem.unit.mass,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

}
