import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/view/category/category_view.dart';
import 'package:graineasy/ui/view/forgot_password/forgot_password_view.dart';
import 'package:graineasy/ui/view/login/login_view.dart';
import 'package:graineasy/ui/view/registration/registration_view.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:graineasy/utils/ui_helper.dart';
import 'package:graineasy/ui/validation/validation.dart';


import '../../../Account_screen.dart';
import '../../../help_screen.dart';
import '../../../item_screen.dart';
import '../../../login_page.dart';
import '../../../orderhistory_screen.dart';
import '../../../setting_screen.dart';
import 'home_view_model.dart';

const URL = "https://graineasy.com";


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with CommonAppBar {
  User user;
  @override
  Future initState()  {
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
          title: Text('Grain Easy'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }



  Widget _getBody(HomeViewModel model) {
    return Stack(
      children: <Widget>[
        _getBaseContainer(model),
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

  _getBaseContainer(HomeViewModel model)
  {

    return getCategoryWidget(model);
  }

  getCategoryWidget(HomeViewModel model) {
    return SingleChildScrollView(child:   new GridView.builder(
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
//                              child: Image.network(
//                              model.items[index].image,
//
//                              ),),

                            child: WidgetUtils.getCategoryImage(model.items[index].image)),
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

  getDrawerWidget()
   {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new Card(
            child: UserAccountsDrawerHeader(
              accountName: new Text("Naomi A. Schultz"),
              accountEmail: new Text("NaomiASchultz@armyspy.com"),
              onDetailsPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Account_Screen()));
              },
              decoration: new BoxDecoration(
                backgroundBlendMode: BlendMode.difference,
                color: Colors.white30,

                /* image: new DecorationImage(
               //   image: new ExactAssetImage('assets/images/lake.jpeg'),
                  fit: BoxFit.cover,
                ),*/
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.fakenamegenerator.com/images/sil-female.png")),
            ),
          ),
          new Card(
            elevation: 4.0,
            child: new Column(
              children: <Widget>[

                new ListTile(
                    leading: Icon(Icons.history),
                    title: new Text("Order History "),


                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Oder_History(toolbarname: ' Order History',)));

                    }),
                new ListTile(
                    leading: Icon(Icons.history),
                    title: new Text("User Login Test"),


                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage(toolbarname: ' User Login Test',)));

                    }),
              ],
            ),
          ),
          // Custom container created to test app
//            new Card(
//              elevation: 4.0,
//              child: new Column(
//                children: <Widget>[
//                  new ListTile(
//                      leading: Icon(Icons.favorite),
//                      title: new Text(name),
//                      onTap: () {
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: name,)));
//                      }),
//                  new Divider(),
//                  new ListTile(
//                      leading: Icon(Icons.history),
//                      title: new Text("User Login Test"),
//
//
//                      onTap: () {
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage(toolbarname: ' User Login Test',)));
//
//                      }),
//                ],
//              ),
//            ),
          new Card(
            elevation: 4.0,
            child: new Column(
              children: <Widget>[
                new ListTile(
                    leading: Icon(Icons.settings),
                    title: new Text("Settings"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting_Screen(toolbarname: 'Setting',)));
                    }),
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.help),
                    title: new Text("Help"),
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Screen(toolbarname: 'Help',)));

                    }),
              ],
            ),
          ),
          new Card(
            elevation: 4.0,
            child: new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text(
                  "Logout",
                  style:
                  new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, Screen.Login.toString(), (Route<dynamic> route) => false);

                }),
          )
        ],
      ),
    );
  }
}
