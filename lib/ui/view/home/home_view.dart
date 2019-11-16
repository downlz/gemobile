import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/view/account/account_view.dart';
import 'package:graineasy/ui/view/category/category_view.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';

import '../../../help_screen.dart';
import '../../../login_page.dart';
import '../../../setting_screen.dart';
import 'home_view_model.dart';

const URL = "https://graineasy.com";


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
        drawer: getDrawerWidget(),
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
                    Container(

                      //margin: EdgeInsets.only(left: 10.0),
                      padding: EdgeInsets.only(
                          left: 3.0, bottom: 3.0),
                      alignment: Alignment.bottomLeft,

                      child:  new Text(
                        model.items[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold),
                      ),

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

  getDrawerWidget() {
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
                    child: Text('Admin Account',
                      style: TextStyle(color: Colors.white, fontSize: 16),),),
                  Text('+911111111111',
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

              new ListTile(
                  leading: Icon(Icons.history, color: Palette.assetColor,),
                  title: new Text("Order History",
                    style: TextStyle(color: Palette.assetColor, fontSize: 15),),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => OrderHistoryView()));
                  }),
              new ListTile(
                  leading: Icon(Icons.sim_card, color: Palette.assetColor),
                  title: new Text("Order Manage", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),


                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            LoginPage(toolbarname: ' User Login Test',)));
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Payment_Screen()));

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
                    UserPreferences.logOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Screen.Login.toString(), (
                        Route<dynamic> route) => false);
                  },
                ),
              ),
              Text('Version Name:1.0',
                  style: TextStyle(color: Palette.assetColor))

            ],
          ),


        ],
      ), elevation: 4.0,
    );
  }
}
