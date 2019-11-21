import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view_model.dart';
import 'package:graineasy/ui/view/home/home_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';

class BargainView extends StatefulWidget {
  Bargain bargainDetail;
  Item itemDetails;

  BargainView(this.bargainDetail, this.itemDetails);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<BargainView> with CommonAppBar {
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
          child: widget.bargainDetail.bargainstatus != 'paused'
              ? SingleChildScrollView(child: Column(
            children: <Widget>[
              getBargainDetailWidget(),
            ],
          ))
              :
          Container(
            alignment: Alignment.center,
            child: checkBargainPause(),
          ),
        ),
        Column(
          children: <Widget>[
            widget.bargainDetail.firstquote.buyerquote != null &&
                widget.bargainDetail.firstquote.sellerquote != 0.0 ?
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: RaisedButton(
                color: Palette.loginBgColor,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Counter',
                  style: AppTextStyle.commonTextStyle(
                      Palette.whiteTextColor,
                      AppResponsive.getFontSizeOf(30),
                      FontWeight.bold,
                      FontStyle.normal),
                ),
                onPressed: () {
                  model.counterBtnClick(widget.bargainDetail);
                },
              ),
            ) : Text(
              'Waiting For Seller Response', style: TextStyle(fontSize: 17),),


            Divider(color: Colors.black45,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                new FlatButton(onPressed: () {
                                  model.acceptBtnClick(widget.bargainDetail);
                                }, child: Text('Yes')),
                                new FlatButton(onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeView()
                                      ));
                                }, child: Text('No'))
                              ],
                            );
                          }
                      );
                    }
                ),

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
                            content: new Text(
                                'Are you sure want to reject this quote?'),
                            actions: <Widget>[
                              new FlatButton(onPressed: () {
                                model.rejectBtnClick(widget.bargainDetail);
                              }, child: Text('Yes')),
                              new FlatButton(onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeView()
                                    ));
                              }, child: Text('No'))
                            ],
                          );
                        }
                    );
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


//                      model.pauseBtnClick(widget.bargainDetail);
//                      return API.alertMessage('Are you sure want to pause this quote?',context);
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: new Text(
                                  'Are you sure want to pause this quote?'),
                              actions: <Widget>[
                                new FlatButton(onPressed: () {
                                  model.pauseBtnClick(widget.bargainDetail);
                                }, child: Text('Yes')),
                                new FlatButton(onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeView()
                                      ));
                                }, child: Text('No'))
                              ],
                            );
                          }
                      );
                    }
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  getBargainDetailWidget() {
    return Column(
      children: <Widget>[
        buyerFirstBargainQuote(widget.bargainDetail.firstquote),
        sellerFirstBargainQuote(widget.bargainDetail.firstquote),
        buyerSecondBargainQuote(widget.bargainDetail.secondquote),
        sellerSecondBargainQuote(widget.bargainDetail.secondquote),
        buyerThirdBargainQuote(widget.bargainDetail.thirdquote),
        sellerThirdBargainQuote(widget.bargainDetail.thirdquote),
      ],
    );
  }


  sellerFirstBargainQuote(pricerequestSchema firstquote) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      alignment: Alignment.centerRight,
      child: firstquote.sellerquote != 0.0 ?
      Card(
        elevation: 4,
        child: Container(
          width: 100,
          height: 80,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 3, bottom: 2),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(firstquote.sellerquote.toString(), style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepOrange
              ),),
              Text('By Seller', textAlign: TextAlign.end,
                style: TextStyle(fontSize: 13,
                    color: Colors.deepOrange),)
            ],
          ),
        ),
      ) : Container(),
    );
  }

  buyerFirstBargainQuote(pricerequestSchema firstquote) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      alignment: Alignment.centerLeft,
      child: firstquote != null ?
      Card(
        elevation: 4,
        child: Container(
          width: 100,
          height: 80,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 3, bottom: 2),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(firstquote.buyerquote.toString(), style: TextStyle(
                  fontSize: 30,
                  color: Colors.black
              ),),
              Text('By Buyer', textAlign: TextAlign.end,
                style: TextStyle(fontSize: 13,
                    color: Colors.black54),)
            ],
          ),
        ),
      ) : Container(),
    );
  }

  sellerSecondBargainQuote(pricerequestSchema secondquote) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      alignment: Alignment.centerRight,
      child: secondquote != null ?
      Card(
        elevation: 4,
        child: Container(
          width: 100,
          height: 80,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 3, bottom: 2),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(secondquote.sellerquote.toString(), style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepOrange
              ),),
              Text('By Seller', textAlign: TextAlign.end,
                style: TextStyle(fontSize: 13,
                    color: Colors.deepOrange),)
            ],
          ),
        ),
      ) : Container(),
    );
  }

  buyerSecondBargainQuote(pricerequestSchema secondquote) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: secondquote != null ?
      Card(
        elevation: 4,
        child: Container(
          width: 100,
          height: 80,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 3, bottom: 2),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(secondquote.buyerquote.toString(), style: TextStyle(
                  fontSize: 30,
                  color: Colors.black
              ),),
              Text('By Buyer', textAlign: TextAlign.end,
                style: TextStyle(fontSize: 13,
                    color: Colors.black54),)
            ],
          ),
        ),
      ) : Container(),
    );
  }

  sellerThirdBargainQuote(pricerequestSchema thirdquote) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      alignment: Alignment.centerRight,
      child: thirdquote != null ?
      Card(
        elevation: 4,
        child: Container(
          width: 100,
          height: 80,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 3, bottom: 2),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(thirdquote.sellerquote.toString(), style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepOrange
              ),),
              Text('By Seller', textAlign: TextAlign.end,
                style: TextStyle(fontSize: 13,
                    color: Colors.deepOrange),)
            ],
          ),
        ),
      ) : Container(),
    );
  }

  buyerThirdBargainQuote(pricerequestSchema thirdquote) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: thirdquote != null ?
      Card(
        elevation: 4,
        child: Container(
          width: 100,
          height: 80,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 3, bottom: 2),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(thirdquote.buyerquote.toString(), style: TextStyle(
                  fontSize: 30,
                  color: Colors.black
              ),),
              Text('By Buyer', textAlign: TextAlign.end,
                style: TextStyle(fontSize: 13,
                    color: Colors.black54),)
            ],
          ),
        ),
      ) : Container(),
    );
  }

  checkBargainPause() {
    DateTime lastDate = widget.bargainDetail.lastupdated;
    lastDate.timeZoneName;
    var pauseHour = lastDate.hour + 6;
    String timeZone = lastDate.timeZoneName;
    return Text(
      'Bargain has been paused till ${pauseHour} ${timeZone}', style: TextStyle(
        color: Colors.black,
        fontSize: 20
    ),);
  }
}


