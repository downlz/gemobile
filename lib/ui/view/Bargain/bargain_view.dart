import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/bargain.dart';
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

  BargainView(this.bargainDetail);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<BargainView> with CommonAppBar {
  TextEditingController buyerQuoteController = new TextEditingController();
  final buyerQuoteFormKey = GlobalKey<FormState>();
  bool isBuyerQuote = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BargainViewModel>(builder: (context, model, child) {
      model.init(widget.bargainDetail);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Bargain'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(BargainViewModel model) {
    return Stack(
      children: <Widget>[_getBaseContainer(model), getProgressBar(model.state)],
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
        Expanded(
            child:
            getBargainDetailWidget()
        ),

        widget.bargainDetail.bargainstatus != 'paused'
            ? new Column(children: <Widget>[ !model.isBargainOn
            ? Text(
          'Accept or Reject The Quote.',
          style: TextStyle(fontSize: 17),
        )
            : (model.user.isBuyer && isBuyerQuote) ||
            (model.user.isSeller && !isBuyerQuote)
            ? Row(
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
                    child: const Text('Initiate Bargain'),
                    textColor: Colors.amber.shade500,
                    onPressed: () async {
                      if (buyerQuoteFormKey.currentState.validate()) {
                        model.counterBtnClick(
                            buyerQuoteController.text);
                      }
                    },
                    shape: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
              ),
            ),
          ],
        )
            : Text(
          model.user.isBuyer && !isBuyerQuote
              ? 'Waiting For Seller Response'
              : 'Waiting For Buyer Quote',
          style: TextStyle(fontSize: 17),
        ),
          Divider(
            color: Colors.black45,
          ),
          Row(
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
                                onPressed: () {
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
          ),
        ],)
            : Container(
          alignment: Alignment.center,
          child: checkBargainPause(),
        ),

      ],
    );
  }

  getBargainDetailWidget() {
    return ListView(
      children: <Widget>[
        buyerQuote(widget.bargainDetail.firstquote),
        sellerQuote(widget.bargainDetail.firstquote),
        buyerQuote(widget.bargainDetail.secondquote),
        sellerQuote(widget.bargainDetail.secondquote),
        buyerQuote(widget.bargainDetail.thirdquote),
        sellerQuote(widget.bargainDetail.thirdquote),
      ],
    );
  }

  sellerQuote(pricerequestSchema quote) {
    if (quote != null && quote.sellerquote != null && quote.sellerquote > 0) {
      isBuyerQuote = true;
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
          width: 120,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                quote.sellerquote.toString(),
                style: TextStyle(
                    fontSize: 25, color: Colors.deepOrange),
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                'By Seller',
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

  buyerQuote(pricerequestSchema quote) {
    if (quote != null && quote.buyerquote != null && quote.buyerquote > 0) {
      isBuyerQuote = false;
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
          width: 120,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                quote.buyerquote.toString(),
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                'By Buyer',
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

    return new Padding(padding: EdgeInsets.all(10), child: Text(
      'Bargain has been paused till $formattedDate',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),);
  }
}
