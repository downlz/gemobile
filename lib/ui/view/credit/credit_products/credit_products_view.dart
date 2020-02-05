import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/model/creditrequest.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/credit/credit_products/credit_products_model.dart';
import 'package:graineasy/ui/view/credit/credit_request/credit_request_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/utils/ui_helper.dart';
import 'package:intl/intl.dart';

class CreditProductsView extends StatefulWidget {
  CreditRequest creditrequest;

  CreditProductsView({this.creditrequest});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<CreditProductsView>
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
    return BaseView<CreditProductModel>(
        builder: (context, model, child) {
      model.init();
      showMessage(model);
      return new Scaffold(
        appBar: new AppBar(
          title: Text(!model.isUpdateCreditRqst
              ? 'Products'
              : "Credit Request Status"),
          backgroundColor: Colors.white,
        ),
        key: addCreditRequestScaffoldKey,
        backgroundColor: Palette.loginBgColor,
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(CreditProductModel model) {
    return Stack(
      children: <Widget>[
        model.isFirstTime ? Container() : _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(CreditProductModel model) {
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

  _getBaseContainer(CreditProductModel model) {
    return new SingleChildScrollView(
      child: model.isUpdateCreditRqst
          ? requestStatusWidget(model)
          : creditProductWidget(model),
    );
  }

  creditProductWidget(CreditProductModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Container (
            padding: const EdgeInsets.all(30.0),
            color: Colors.white,
            child: new Container(
              alignment:Alignment.topLeft,
              child: new Center(

                  child: new Column(
                      children : [
                        new Padding(padding: EdgeInsets.only(top: 10.0)),
                        new Text('Products at Graineasy',
                          style: new TextStyle(color: Colors.brown, fontSize: 22.0,fontWeight: FontWeight.bold),),
                        new Padding(padding: EdgeInsets.only(top: 15.0)),
                        new Text('Warehouse Receipts Finance',
                          style: new TextStyle(color: Colors.black87, fontSize: 18.0,fontWeight: FontWeight.bold),),
                        new Padding(padding: EdgeInsets.only(top: 5.0)),
                        new Text("We know that you purchase in bulk. We also know you avail credit from the supplier. This credit is costly; generally around 2% per month (cash discount of 2%). So why use the supplier’s credit when you have better options available. We have partnered with Banks and NBFCs. If you keep the goods in our designated warehouse, we will help you avail credit at 1%-1.25% per month. Isn’t this a more cost effective way to fund your purchase? You can avail the cash discount from the supplier and fund your purchase through us. You end with a saving of 1%-0.75% per month on each purchase. This will help you compete in the market more effectively. This is available only on packing of 25 kg and above. We understand that you and your customers will face problems if the warehouse is located faraway. So we will make sure that the warehouses are located in and around your markets. You can easily get upto 2 crore sanctioned in one go.\n" +
                            "You don’t need to run to the Banks and NBFCs continuously for this. Just create a credit request with us. We will worry after that. You will get continuous updates on the status The best part is that we don’t charge anything for this. We are here for you to make your life simple and easy. So go ahead and explore simpler and cost effective ways to fund your purchase.\n" +
                            "Details:\n" +
                            "1 day disbursal\n"+
                            "Rates starting 1% per month\n"+
                            "Upto 180 days credit allowed\n',",
                          style: new TextStyle(color: Colors.black54, fontSize: 17.0),textAlign: TextAlign.justify,),

                       new Padding(padding: EdgeInsets.only(top: 15.0)),
                        new Text('Bill discounting',
                          style: new TextStyle(color: Colors.black87, fontSize: 18.0,fontWeight: FontWeight.bold),),
                        new Padding(padding: EdgeInsets.only(top: 5.0)),
                        new Text("If you supply to one of the big Modern Retail Players such as More, Metro, Reliance, D Mart, Big Bazaar etc and your money is stuck for upto 90 days, we have the perfect solution for you. We have convinced our banking partners( Bank/NBFC) to advance upto 80% of the invoice amount immediately at a nominal rate. You won’t need to do any paperwork repeatedly. Just create a credit request with us and we will take all the headache on your behalf. If the banks/nbfc agree to sanction your request, you job is done. We will process everything from there. Here are the details:\n" +
                            "You don’t need to run to the Banks and NBFCs continuously for this. Just create a credit request with us. We will worry after that. You will get continuous updates on the status The best part is that we don’t charge anything for this. We are here for you to make your life simple and easy. So go ahead and explore simpler and cost effective ways to fund your purchase.\n" +
                            "80% immediate payment\n" +
                            "1 day disbursal\n" +
                            "Rates starting 1% per month\n" +
                            "Upto 90 days receivable allowed\n",

                          style: new TextStyle(color: Colors.black54, fontSize: 17.0),textAlign: TextAlign.justify,),
                        new Padding(
                          padding: EdgeInsets.only(
                              left: 10, top: 10, bottom: 10, right: 10),
                          child: Container(
                            alignment: Alignment.center,
                            child:
                            FlatButton.icon(
                              color: Colors.indigo.shade300,
                              icon: Icon(Icons.account_balance_wallet), //`Icon` to display
                              label: Text('Raise Credit Request'),
                                shape: new OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(30.0),
                                ),//`Text` to display
                              onPressed: () {
                                AddUpdateCreditRqst();
                                //Code to execute when Floating Action Button is clicked
                                //...
                              }, )
//                            OutlineButton(
//                                borderSide: BorderSide(
//                                    color: Colors.amber.shade500),
//                                child: const Text('Raise Credit Request'),
//                                textColor: Colors.green.shade500,
//                                onPressed: () async {
//
//                                },
//                                shape: new OutlineInputBorder(
//                                  borderRadius:
//                                  BorderRadius.circular(30.0),
//                                )),
                          ),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 15.0)),
                        new Text("*Disclaimer - All information put here is for information purpose only. The rates, tenure and quantum of loan is decided by the banks and Graineasy does not play any role in loan sanction or disbursal of sanctioned amount. The borrower is requested to go through loan documents for more details once credit process is intiated through Graineasy.",

                          style: new TextStyle(color: Colors.black54, fontSize: 16.0),textAlign: TextAlign.justify,),
                      ],


                  )
              ),)
        )
    );
  }

  requestStatusWidget(CreditProductModel model) {
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
