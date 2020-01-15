import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/model/creditrequest.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/credit/credit_request/credit_request_view_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/utils/ui_helper.dart';
import 'package:intl/intl.dart';

class AddUpdateCreditRqst extends StatefulWidget {
  CreditRequest creditrequest;

  AddUpdateCreditRqst({this.creditrequest});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<AddUpdateCreditRqst>
    with CommonAppBar {
  ShapeBorder shape;
  final addCreditRequestScaffoldKey = GlobalKey<ScaffoldState>();
  final addCreditRequestFormKey = GlobalKey<FormState>();
  var partyNameFocus = new FocusNode();

  var phoneFocus = new FocusNode();
  var turnoverFocus = new FocusNode();
  var tradeItemsFocus = new FocusNode();
  var lastThreeTurnoverFocus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return BaseView<AddUpdateCreditRqstViewModel>(
        builder: (context, model, child) {
      model.init();
      showMessage(model);
      return new Scaffold(
        appBar: new AppBar(
          title: Text(!model.isUpdateCreditRqst
              ? 'Credit Request'
              : "Credit Request Status"),
          backgroundColor: Colors.white,
        ),
        key: addCreditRequestScaffoldKey,
        backgroundColor: Palette.loginBgColor,
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(AddUpdateCreditRqstViewModel model) {
    return Stack(
      children: <Widget>[
        model.isFirstTime ? Container() : _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(AddUpdateCreditRqstViewModel model) {
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

  _getBaseContainer(AddUpdateCreditRqstViewModel model) {
    return new SingleChildScrollView(
      child: model.isUpdateCreditRqst
          ? requestStatusWidget(model)
          : creditRequestWidget(model),
    );
  }

  creditRequestWidget(AddUpdateCreditRqstViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: new Column(
        children: <Widget>[
          Form(
              key: addCreditRequestFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                            controller: model.turnoverController,
                            focusNode: turnoverFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validation.validateTurnover(value);
                            },
                            decoration: AppWidget.whiteTextField(
                                'Current Year Turnover')),
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                            controller: model.lastThreeTurnoverController,
                            focusNode: lastThreeTurnoverFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.text,
                            validator: (value) {
//                              return Validation.validateAddress(value);
                            },
                            decoration: AppWidget.whiteTextField(
                                'Last 3 Yrs Av. Turnover (Optional)')),
                        UIHelper.verticalSpaceSmall,
                        TextFormField(
                            controller: model.tradeItemsController,
                            focusNode: tradeItemsFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return Validation.validateTradeItems(value);
                            },
                            decoration:
                                AppWidget.whiteTextField('Trade Items (Ex- Rice,Sugar,Wheat)')),
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                            controller: model.phoneNumberController,
                            focusNode: phoneFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return Validation.validateCRMobile(value);
                            },
                            decoration:
                                AppWidget.whiteTextField('Phone Number')),
                        UIHelper.verticalSpaceMedium,
                        RaisedButton(
                          color: Palette.whiteTextColor,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            !model.isUpdateCreditRqst
                                ? 'Submit'
                                : 'Update Request',
                            style: AppTextStyle.commonTextStyle(
                                Palette.loginBgColor,
                                AppResponsive.getFontSizeOf(30),
                                FontWeight.bold,
                                FontStyle.normal),
                          ),
                          onPressed: () {
                            if (addCreditRequestFormKey.currentState
                                .validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              model.addUpdateCreditRqst(widget.creditrequest);
                            }
                          },
                        ),
                        UIHelper.verticalSpaceMedium,
                      ]),
                ),
              ))
        ],
      ),
    );
  }

  requestStatusWidget(AddUpdateCreditRqstViewModel model) {
    return Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
//        child: GestureDetector(
//            onTap: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => OrderDetailView(
//                            orderList: model.orderList[ind],
//                          )));
//            },
            child: Card(
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // three line description
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Thank you for showing interest in credit services offered by graineasy.',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal,
                            color: Colors.black87,
//                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      Container(
                        margin: EdgeInsets.only(top: 3.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Request Date: ' + DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.parse(model.creditrequestlist[0].requestedOn.toString())),
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.amber.shade500,
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          rowWidget('Trade Items',model.creditrequestlist[0].tradeItems),
//                          rowWidget('Order Amount',
//                              "" + 'Dev'),
//                          rowWidget(
//                              'Order Type', 'test'),
                        ],
                      ),
                      UIHelper.verticalSpaceMedium,
                      model.creditrequestlist[0].tradeItems == null
                          ? Container()
                          :

                      Container(
                        margin: EdgeInsets.only(top: 3.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          (model.statusdesc.description == null) ? 'NA' : 'Status: ' + model.statusdesc.description,
                          style:
                          TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),

//                      Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                Icon(
//                                  Icons.timelapse,
//                                  size: 30.0,
//                                  color: Colors.amber.shade500,
//                                ),
//                                Text(
//                                    (model.statusdesc.description == null) ? 'NA' : model.statusdesc.description,
//                                    style: TextStyle(
//                                        fontSize: 16.0, color: Colors.black54)),
//                              ],
//                            ),
                      Divider(
                        height: 10.0,
                        color: Colors.amber.shade500,
                      ),
                      _status(model.creditrequestlist[0].status),
                      (model.creditrequestlist[0].status != 'cancelled' &&
                          model.creditrequestlist[0].status != 'rejected' &&
                          model.creditrequestlist[0].status != 'withdrawn') ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RaisedButton(
                          color: Palette.loginBgColor,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Withdraw Request',
                            style: AppTextStyle.commonTextStyle(
                                Palette.whiteTextColor,
                                AppResponsive.getFontSizeOf(30),
                                FontWeight.bold,
                                FontStyle.normal),
                          ),
                          onPressed: () {
                            model.updateStatus(model.creditrequestlist[0].id);
                          },
                        ),
                      ): Container(),
                    ],
                  ),
                )));
  }


  Widget _status(status) {
    if (status == 'cancelled' || status == 'rejected'  ) {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.red,fontSize: 18.0),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 30.0,
            color: Colors.red,
          ),
          onPressed: () {
            // Perform some action
          });
    } else if (status == 'withdrawn' ) {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.grey,fontSize: 18.0),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 30.0,
            color: Colors.grey,
          ),
          onPressed: () {
            // Perform some action
          });
    } else {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.green,fontSize: 18.0),
          ),
          icon: const Icon(
            Icons.timelapse,
            size: 30.0,
            color: Colors.amber,
          ),
          onPressed: () {
            // Perform some action
          });
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
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
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
