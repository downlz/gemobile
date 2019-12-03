import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/view/BargainDetail/bargain_history_view.dart';
import 'package:graineasy/ui/view/account/account_view.dart';
import 'package:graineasy/ui/view/category/category_view.dart';
import 'package:graineasy/ui/view/manage_order/manage_order/manage_order_view.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../help_screen.dart';
import '../../../setting_screen.dart';
import 'home_view_model.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with CommonAppBar {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.isTablet(MediaQuery.of(context), context);
    return BaseView<HomeViewModel>(builder: (context, model, child) {
      model.init();
      return new Scaffold(
        drawer: getDrawerWidget(model),
        appBar: new AppBar(
          title: Text('Graineasy'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(HomeViewModel model) {
    return Stack(
      children: <Widget>[
        model.items != null ? _getBaseContainer(model) : Container(),
//        _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(HomeViewModel model) {
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

  _getBaseContainer(HomeViewModel model) {
    return model.items != null ? getCategoryWidget(model) : Container();
//    return getCategoryWidget(model);
  }

  getCategoryWidget(HomeViewModel model) {
    return SingleChildScrollView(child:
    new GridView.builder(
        itemCount: model.items.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5.0),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));

                Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryView(model.items[index])));
              },

              child:  new Card(
                elevation: 3.0,
                child:  Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: model.items[index].image != null ? WidgetUtils
                            .getCategoryImage(model.items[index].image) : Icon(
                            Icons.refresh)),
                    Container(
                      color: Colors.black38,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end
                      , children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(left: 10.0),
                          padding: EdgeInsets.only(
                              left: 3.0, bottom: 3.0),
                          alignment: Alignment.bottomLeft,
                          child: new Text(
                            model.items[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold),

                          ),
                        ),
//                        Container(
//                          alignment: Alignment.bottomRight
//                          ,child: Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            crossAxisAlignment: CrossAxisAlignment.end
//                            ,children: <Widget>[
//
//                          Padding(
//                            padding: const EdgeInsets.only(bottom: 3),
//                            child: InkWell(child: Image.asset('images/whatsapp.png',width: 30,height: 25,),
//                            onTap: (){
//                          _launchWhatsApp(model.items[index]);
//                            },),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(left: 3,right: 1,bottom: 3),
//                            child: InkWell(child: Image.asset('images/mail.png',width: 25,height: 25,),
//                            onTap: (){
//                              _launchEmail(model.items[index]);
//
//                            },),
//                          )
//                          ],
//                          ),
//                        ),
                      ],
                    ),


                    /*Positioned(
                                    child: FittedBox(

                                     fit: BoxFit.fill,
                                      alignment: Alignment.centerLeft,
                                      child: Text(photos[index].title,
                                        style: TextStyle(color: Colors.black87,fontSize: 15.0),
                                      ),

                                  )
                                  )*/
                  ],
                ),

              )

          );
        }),
    );
  }

  getDrawerWidget(HomeViewModel model) {
//    userDetail();

    return new Drawer(
      child: new ListView(
        children: <Widget>[
          GestureDetector(
            child: new Container(height: AppResponsive.getSizeOfHeight(270),
              padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(backgroundImage: AssetImage('images/user.png'),
                    radius: 35,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(model.user == null ? ' ' : model.user.name,
                      style: TextStyle(color: Colors.white, fontSize: 16),),),
                  Text(model.user == null ? ' ' : model.user.phone,
                    style: TextStyle(color: Colors.white, fontSize: 16),)
                ],
              ),

//            UserAccountsDrawerHeader(
//              accountName: new Text('Admin Account'),
//              accountEmail: new Text('+911111111111'),
//              onDetailsPressed: () {
//
//              },
//              decoration: new BoxDecoration(
//               color: Palette.assetColor,
//                /* image: new DecorationImage(
//               //   image: new ExactAssetImage('assets/images/lake.jpeg'),
//                  fit: BoxFit.cover,
//                ),*/
//              ),
//              currentAccountPicture: CircleAvatar(
//                  backgroundImage: NetworkImage(
//                      "https://www.fakenamegenerator.com/images/sil-female.png")),
//            ),

              color: Palette.assetColor,
            ),
            onTap: () async {
              User user = await UserPreferences.getUser();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountVIew(user)));
            },
          ),
          new Column(
            children: <Widget>[
              if(model.user != null)
                !model.user.isSeller ?
              new ListTile(
                  leading: Icon(Icons.history, color: Palette.assetColor,),
                  title: new Text("Order History",
                    style: TextStyle(color: Palette.assetColor, fontSize: 15),),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => OrderHistoryView()));
                  }) : Container(),
              if(model.user != null)
                model.user.isSeller || model.user.isAdmin ?
              new ListTile(
                  leading: Icon(Icons.credit_card, color: Palette.assetColor),
                  title: new Text("Manage Order", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ManageOrderView()));
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Payment_Screen()));

                  }) : Container(),

              new ListTile(
//                // Image.asset('images/bargain.png'),
                  leading: Icon(
                      Icons.monetization_on, color: Palette.assetColor),
                  title: new Text("Bargain History", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            BargainHistoryView()));
                  }),
              new ListTile(
                  leading: Icon(Icons.settings, color: Palette.assetColor),
                  title: new Text("Settings", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            Setting_Screen(toolbarname: 'Setting',)));
                  }),

//              new ListTile(
//                  leading: Icon(Icons.credit_card, color: Palette.assetColor),
//                  title: new Text("push Notification", style: TextStyle(
//                      color: Palette.assetColor, fontSize: 15)),
//                  trailing: Icon(
//                    Icons.arrow_forward, color: Palette.assetColor,),
//                  onTap: () async {
//                    User user = await UserPreferences.getUser();
//
//                    API.getUserDetailForPushNotification('TEST', 'TESTING', user.id);
//                    Future<void> _handleNotification (Map<dynamic, dynamic> message, bool dialog) async {
//                      var data = message['data'] ?? message;
//                      String expectedAttribute = data['expectedAttribute'];
//                    }
//                  }),

              new ListTile(
                  leading: Icon(Icons.help, color: Palette.assetColor),
                  title: new Text("Help", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            Help_Screen(toolbarname: 'Help',)));
                  }),

              Container(
                margin: EdgeInsets.only(
                    top: AppResponsive.getSizeOfHeight(300)),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.power_settings_new,
                        textDirection: TextDirection.ltr,
                        color: Colors.redAccent,),
                      new Text(
                        "Logout",
                        style:
                        new TextStyle(color: Colors.redAccent, fontSize: 18.0),
                      ),
                    ],
                  ),
                  onTap:
                      () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          content: new Text('Are you sure want to Logout'),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Yes"),
                              onPressed: () {
                                UserPreferences.logOut();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Screen.Login.toString(), (
                                    Route<dynamic> route) => false);
                              },
                            ),
                            new FlatButton(
                              child: new Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Version Name:1.0',
                    style: TextStyle(color: Palette.assetColor)),
              )

            ],
          ),


        ],
      ), elevation: 4.0,
    );
  }

  Future _launchEmail(ItemName item) async {
    launch('mailto:trade@graineasy.com?subject=${"ItemName: " +
        item.name}&body=${"ItemImage: " + item.image}');
  }

  Future _launchWhatsApp(ItemName item) async {
    FlutterShareMe()
        .shareToWhatsApp(msg: item.name, base64ImageUrl: item.name);
  }

}
