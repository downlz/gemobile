import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/ui/view/item_details/details_view.dart';
import 'package:graineasy/ui/view/group-buy/gbitem_details/gbdetails_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'groupbuy_view_model.dart';


class GroupbuyView extends StatefulWidget {
//  final ItemName itemName;
//  GroupbuyView();

  @override
  _GroupbuyViewState createState() => _GroupbuyViewState();
}

class _GroupbuyViewState extends State<GroupbuyView> with CommonAppBar {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<GroupbuyViewModel>(builder: (context, model, child) {
      model.init();
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Test GB'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(GroupbuyViewModel model) {
    return Stack(
      children: <Widget>[_getBaseContainer(model), getProgressBar(model.state)],
    );
  }

  void showMessage(GroupbuyViewModel model) {
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

  _getBaseContainer(GroupbuyViewModel model) {
    return
      model.gbitems!=null?
      getCategoryWidget(model):Container();
  }

  getCategoryWidget(GroupbuyViewModel model) {
    return

      model.gbitems.length <= 0
        ? WidgetUtils.showMessageAtCenterOfTheScreen('No items found')
        : SingleChildScrollView(
            child: new GridView.builder(
                itemCount: model.gbitems.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(5.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                      onTap: () {
//                        Navigator.push(context, MaterialPageRoute(
//                            builder: (context) =>
//                                GBDetailsView(gbitems: model.gbitems[index],)));
                      },
                      child: new Card(
                        elevation: 3.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: WidgetUtils.getCategoryImage(
                                    model.gbitems[index].item.image)),
                            Container(
                              color: Colors.black38,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2, right: 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      model.gbitems[index].item.bargainenabled == true
                                          ? Container(
                                        alignment: Alignment.topLeft,
                                        child: Text('Bargain Enabled',
                                          style: TextStyle(color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),),
                                      )
                                          : Container(
                                          alignment: Alignment.topLeft),
                                      Container(
                                        alignment: Alignment.topRight
                                        , child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: InkWell(child: Image.asset(
                                              'images/whatsapp.png', width: 30,
                                              height: 25,),
                                              onTap: () {
                                                _launchWhatsApp(
                                                    model.gbitems[index]);
                                              },),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3, bottom: 3),
                                            child: InkWell(child: Image.asset(
                                              'images/mail.png', width: 25,
                                              height: 25,),
                                              onTap: () {
                                                _launchEmail(
                                                    model.gbitems[index]);
                                              },),
                                          )
                                        ],
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10.0),
                                  padding: EdgeInsets.only(
                                      left: 3.0, bottom: 3.0),
                                  alignment: Alignment.bottomLeft,


                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(model.gbitems[index].item.name,
                                        style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                                      Text(model.gbitems[index].item.manufacturer.name,
                                          style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w500)),
                                      Text("Origin: " + model.gbitems[index].item.origin,
                                          style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.w500)),
                                    ],
                                  ),

                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                }),
          );
  }


  Future _launchEmail(Groupbuy item) async {
    launch('mailto:?subject=${"ItemName: " +                                  // Modified to remove email to trade@graineasy.com
        item.item.name}&body=${item.item.name + "/" + item.item.category.name + "\n" +
        item.item.image}');
  }

  Future _launchWhatsApp(Groupbuy item) async {
    FlutterShareMe().shareToWhatsApp(
        msg: item.item.name + "/" + item.item.category.name + "\n" + item.item.image);
  }
}
