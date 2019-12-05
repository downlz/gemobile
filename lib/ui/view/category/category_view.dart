import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/ui/view/item_details/details_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'category_view_model.dart';


class CategoryView extends StatefulWidget {
  final ItemName itemName;
  CategoryView(this.itemName);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> with CommonAppBar {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryViewModel>(builder: (context, model, child) {
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

  Widget _getBody(CategoryViewModel model) {
    return Stack(
      children: <Widget>[_getBaseContainer(model), getProgressBar(model.state)],
    );
  }

  void showMessage(CategoryViewModel model) {
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

  _getBaseContainer(CategoryViewModel model) {
    return
      model.items!=null?
      getCategoryWidget(model):Container();
  }

  getCategoryWidget(CategoryViewModel model) {
    return

      model.items.length <= 0
        ? WidgetUtils.showMessageAtCenterOfTheScreen('No items found')
        : SingleChildScrollView(
            child: new GridView.builder(
                itemCount: model.items.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(5.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                DetailsView(item: model.items[index],)));
                      },
                      child: new Card(
                        elevation: 3.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: WidgetUtils.getCategoryImage(
                                    model.items[index].image)),
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
                                      model.items[index].bargainenabled == true
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
                                                    model.items[index]);
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
                                                    model.items[index]);
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
                                      Text(model.items[index].name,
                                        style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                                      Text(model.items[index].manufacturer.name,
                                          style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w500)),
                                      Text("Origin: " + model.items[index].origin,
                                          style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.w500)),
                                    ],
                                  ),


// Commented by Shahnawaz
//                                  child: new Text(
//                                    model.items[index].name + ' ' + model.items[index].origin,
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                        fontSize: 20.0,
//                                        color: Colors.white,
//                                        fontWeight: FontWeight.bold),
//                                  ),



                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                }),
          );
  }


  Future _launchEmail(Item item) async {
    launch('mailto:?subject=${"ItemName: " +                                  // Modified to remove email to trade@graineasy.com
        item.name}&body=${item.name + "/" + item.category.name + "\n" +
        item.image}');
  }

  Future _launchWhatsApp(Item item) async {
    FlutterShareMe().shareToWhatsApp(
        msg: item.name + "/" + item.category.name + "\n" + item.image);
  }
}
