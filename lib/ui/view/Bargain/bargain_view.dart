import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/utils/ui_helper.dart';
import 'package:intl/intl.dart';

class BargainView extends StatefulWidget {
  Bargain bargainDetail;
  String id;

  BargainView({this.bargainDetail, this.id});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<BargainView> with CommonAppBar {
  TextEditingController buyerQuoteController = new TextEditingController();
  final buyerQuoteFormKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BargainViewModel>(builder: (context, model, child) {
      model.init(widget.bargainDetail, widget.id);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Bargain Request' + " " + '${model.bargainDetail.bargainstatus[0].toUpperCase()}${model.bargainDetail.bargainstatus.substring(1)}'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(BargainViewModel model) {
    return Stack(
      children: <Widget>[
        model.bargainDetail != null ? _getBaseContainer(model) : Container(),
        getProgressBar(model.state)],
    );
  }

  void showMessage(BargainViewModel model) {
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

  _getBaseContainer(BargainViewModel model) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1.0),
                        ), color: Colors.white
                    ),
//                    child: Center(
//                      child: Text(
//                        model.bargainDetail.item.bargainenabled == true
//                            ? 'Bargain enabled'
//                            : '',
//                        style: TextStyle(
//                            fontSize: 18, fontWeight: FontWeight.w400),),
//                    ),
                  ),
                  Text(model.bargainDetail.item.itemname.name + ' | ' +
                      model.bargainDetail.item.category.name + ' | ' + model.bargainDetail.item.sampleNo,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
//                  Text("Sample Number: " + model.bargainDetail.item.sampleNo,
//                    style: TextStyle(
//                        fontSize: 18, fontWeight: FontWeight.w400),),
                  Text("Origin: " + model.bargainDetail.item.origin,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400)),
                  Text("Manufacturer: " +
                      model.bargainDetail.item.manufacturer.name,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400)),
                  Text("List Price: " +
                      model.bargainDetail.item.price.toString() + "/" +
                      model.bargainDetail.item.unit.mass, style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400)),
                  Text("Requested Qty: " +
                      model.bargainDetail.quantity.toString() + " " +model.bargainDetail.item.unit.mass, style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400)),
                  Text('Lapse Time: ${model.lapseTime}'
                  , style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400))
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child:
            getBargainDetailWidget(model)
        ),

    model.bargainDetail.bargainstatus != 'paused'
    && model.bargainDetail.bargainstatus != 'accepted'
        && model.bargainDetail.bargainstatus != 'expired'
    ? new Column(children: <Widget>[ !model.isBargainOn
            ? Text(
          model.user.isBuyer
              ? 'Accept or Reject the Seller quote'
              : 'Buyer will Accept or Reject The Quote.',
          style: TextStyle(fontSize: 17),
        )
            : (model.user.isBuyer && model.isBuyerQuote) ||
            (model.user.isSeller && !model.isBuyerQuote)
            ? Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Form(
                    key: buyerQuoteFormKey,
                    child: TextFormField(
                      controller: buyerQuoteController,
                      validator: (value) {
                        return value.isEmpty ? 'Quote required' : null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      textAlign: TextAlign.center,
                      style: AppWidget.darkTextFieldTextStyle(),
                      keyboardType: TextInputType.number,
                      decoration:
                      AppWidget.darkTextField('Add Best Quote'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 10, top: 10, bottom: 10, right: 10),
                  child: Container(
                    alignment: Alignment.center,
                    child: OutlineButton(
                        borderSide:
                        BorderSide(color: Colors.amber.shade500),
                        child: const Text('Bargain'),
                        textColor: Colors.amber.shade500,
                        onPressed: () {
                          if (buyerQuoteFormKey.currentState.validate()) {
                            model.counterBtnClick(
                                buyerQuoteController.text, 'countered');
                          }
                        },
                        shape: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                  ),
                ),
              ],
            ),
            acceptRejectWidget(model),
          ],
        )
            : Padding(
            padding: EdgeInsets.all(10),
            child: model.bargainDetail.bargainstatus != 'expired'
                && model.bargainDetail.bargainstatus != 'rejected'
                && model.bargainDetail.bargainstatus != 'accepted'  ? Text(
              model.user.isBuyer && !model.isBuyerQuote
                  ? 'Waiting For Seller Response'
                  : 'Waiting For Buyer Quote',
              style: TextStyle(fontSize: 17),
            ) : Container()),
          !model.isBargainOn && model.user.isBuyer
              ? acceptRejectWidget(model)
              : Container()
        ],)
            : Container(
          alignment: Alignment.center,
          child: checkBargainPause(),
        ),

      ],
    );
  }

  getBargainDetailWidget(BargainViewModel model) {
    return ListView(
      children: <Widget>[
        buyerQuote(model.bargainDetail.firstquote, model),
        sellerQuote(model.bargainDetail.firstquote, model),
        buyerQuote(model.bargainDetail.secondquote, model),
        sellerQuote(model.bargainDetail.secondquote, model),
        buyerQuote(model.bargainDetail.thirdquote, model),
        sellerQuote(model.bargainDetail.thirdquote, model),
      ],

    );
  }

  sellerQuote(pricerequestSchema quote, BargainViewModel model) {
    if (quote != null && quote.sellerquote != null && quote.sellerquote > 0) {
      model.isBuyerQuote = true;
    }

    return quote == null || quote.sellerquote == null || quote.sellerquote <= 0
        ? Container()
        : Container(
      padding: EdgeInsets.only(right: 10, top: 5),
      alignment: Alignment.centerRight,
      child: quote != null
          ? Card(
        elevation: 3,
        child: Container(
          width: 160,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[Text(
                quote.sellerquote.toString(),
                style: TextStyle(
                    fontSize: 25, color: Colors.deepOrange),
              ), Text(
                "/" +
                    model.bargainDetail.item.unit.mass,
                style: TextStyle(
                    fontSize: 15, color: Colors.deepOrangeAccent),
              ),
              ],),
              UIHelper.verticalSpaceSmall,
              Text(
//                'By Seller',
                model.user.isSeller ? 'Your quote' : 'By Seller',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 13, color: Colors.deepOrange),
              )
            ],
          ),
        ),
      )
          : Container(),
    );
  }

  buyerQuote(pricerequestSchema quote, BargainViewModel model) {
    if (quote != null && quote.buyerquote != null && quote.buyerquote > 0) {
      model.isBuyerQuote = false;
    }

    return quote == null
        ? Container()
        : Container(
      padding: EdgeInsets.only(left: 10, top: 5),
      alignment: Alignment.centerLeft,
      child: quote != null
          ? Card(
        elevation: 3,
        child: Container(
          width: 150,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[Text(
                quote.buyerquote.toString(),
                style: TextStyle(
                    fontSize: 25, color: Colors.black),
              ), Text(
                "/" +
                    model.bargainDetail.item.unit.mass,
                style: TextStyle(
                    fontSize: 15, color: Colors.grey),
              ),
              ],),
//              Text(
//                quote.buyerquote.toString() + "/" +
//                    model.bargainDetail.item.unit.mass,
//                style: TextStyle(fontSize: 25, color: Colors.black),
//              ),
              UIHelper.verticalSpaceSmall,
              Text(
//                'By Buyer',
                model.user.isBuyer ? 'Your quote' : 'By Buyer',
                textAlign: TextAlign.end,
                style:
                TextStyle(fontSize: 13, color: Colors.black54),
              )
            ],
          ),
        ),
      )
          : Container(),
    );
  }

  checkBargainPause() {
    DateTime updatedDate = widget.bargainDetail.lastupdated;
    int mlsDate = updatedDate.millisecondsSinceEpoch + 21600000;
    DateTime fromNew = new DateTime.fromMicrosecondsSinceEpoch(mlsDate);
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(fromNew);
    String bargainStat = widget.bargainDetail.bargainstatus;
    String bodyText;
    if (bargainStat == 'accepted') {
      bodyText = 'The bargain request was processed successfully';
    } else if (bargainStat == 'expired') {
      bodyText = 'The bargain request has expired';
    } else if (bargainStat == 'paused') {
      bodyText = 'Bargain has been paused till $formattedDate';
    } else {
      bodyText = 'The bargain status is unknown.Contact trade@graineasy.com';
    }
    return new Padding(padding: EdgeInsets.all(10), child: Text(
//      'Bargain has been paused till $formattedDate',
      bodyText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),);
  }

  void counterBargain() async{
//    Map<dynamic,dynamic> data;
//    data = {'phone': '1111111111','password':'addapass'};
////     print(data);
//
//    var response=await LoginService.userLogin(data);
//    //print(val);
//    if(response.statusCode==200){
//      print(response.body);
//      var decodeResponse=jsonDecode(response.body);
//      storage.setItem('GEUser', decodeResponse);
//    }
//    else{
//      print(response.body);
//      print("Login ERROR");
//    }
  }

  acceptRejectWidget(BargainViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
            color: Palette.loginBgColor,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Accept',
              style: AppTextStyle.commonTextStyle(
                  Palette.whiteTextColor,
                  AppResponsive.getFontSizeOf(30),
                  FontWeight.bold,
                  FontStyle.normal),
            ),
            onPressed: () {
              print('accept');
//                      return API.alertMessage('Are you sure want to accept with this price?',context);
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: new Text(
                          'Are you sure want to accept with this price?'),
                      actions: <Widget>[
                        new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              model.acceptReject('accepted');
                            },
                            child: Text('Yes')),
                        new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'))
                      ],
                    );
                  });
            }),
        RaisedButton(
          color: Palette.loginBgColor,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Reject',
            style: AppTextStyle.commonTextStyle(
                Palette.whiteTextColor,
                AppResponsive.getFontSizeOf(30),
                FontWeight.bold,
                FontStyle.normal),
          ),
          onPressed: () {
            print('reject');
//                    return API.alertMessage('Are you sure want to reject this quote?',context);
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content:
                    new Text('Are you sure want to reject this quote?'),
                    actions: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            model.acceptReject('rejected');
                          },
                          child: Text('Yes')),
                      new FlatButton(

                          onPressed: () async {
                            User user = await UserPreferences.getUser();

                            API.getUserDetailForPushNotification(
                                'title', 'body', user.id);
                            Navigator.of(context).pop();
                          },
                          child: Text('No'))
                    ],
                  );
                });
          },
        ),
        RaisedButton(
            color: Palette.loginBgColor,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Pause',
              style: AppTextStyle.commonTextStyle(
                  Palette.whiteTextColor,
                  AppResponsive.getFontSizeOf(30),
                  FontWeight.bold,
                  FontStyle.normal),
            ),
            onPressed: () {
              print('pause');
//                      model.pauseBtnClick(widget.bargainDetail);
//                      return API.alertMessage('Are you sure want to pause this quote?',context);
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: new Text(
                          'Are you sure want to pause this quote?'),
                      actions: <Widget>[
                        new FlatButton(
                            onPressed: () {
                              model.pauseBtnClick(widget.bargainDetail);
                            },
                            child: Text('Yes')),
                        new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'))
                      ],
                    );
                  });
            })
      ],
    );
  }


}
