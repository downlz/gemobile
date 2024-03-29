import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:graineasy/helpers/common/sharing.dart';
import 'package:graineasy/helpers/common/container.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/MostOrderedItem.dart';
import 'package:graineasy/model/bannerItem.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/view/BargainDetail/bargain_history_view.dart';
import 'package:graineasy/ui/view/account/account_view.dart';
import 'package:graineasy/ui/view/category/category_view.dart';
import 'package:graineasy/ui/view/group-buy/groupbuy_view.dart';
import 'package:graineasy/ui/view/item_details/details_view.dart';
import 'package:graineasy/ui/view/manage_order/manage_order/manage_order_view.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view.dart';
import 'package:graineasy/ui/view/credit/credit_request/credit_request_view.dart';
import 'package:graineasy/ui/view/credit/credit_products/credit_products_view.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/ui/view/search/search_item_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graineasy/model/Item.dart';


import '../../../help_screen.dart';
import 'home_view_model.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with CommonAppBar, SingleTickerProviderStateMixin {
  TabController tabController;
  int tabIndex = 0;



  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    tabController.addListener(toggleTab);
  }


  void toggleTab() {
    setState(() {
      tabIndex = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.search, color: Palette.assetColor,),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchItemView()));
              },
            ),
            // action butto
          ],
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
    return Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(child: getBanner(model.bannerList),
            height: 125,
            width: MediaQuery
                .of(context)
                .size
                .width - 20,
          ),
        ),

        Expanded(child: Container(

          child: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                Container(
                  child:
                  TabBar(tabs: [
                    Tab(child: Text('All')),
                    Tab(child: Text('New')),
//                    Tab(child: Text('Group Buy')),
                    Tab(child: Text('Near Me')),
                  ],
//                    isScrollable: true,
                    controller: tabController,
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    getCategoryWidget(model),
                    model.recentItem != null
                        ? getRecentlyAddedData(model)
                        : Container(),
//                    model.mostOrder != null ? getMostOrderData(model) : Center(
//                      child: Text('No items found'),
//                    ),
                    model.itemsNear != null ? getItemsNearMe(model) :
//                    Text(
//                        'No items found'),
                    Container(
                      child: Center(
                        child: Text(
                          'No items found',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                    controller: tabController,
                  ),

                ),
              ],
            ),
          ),
        ),)

      ],
    );
//    return getCategoryWidget(model);
  }

  getCategoryWidget(HomeViewModel model) {
    return new GridView.builder(
        itemCount: model.items.length,
//        physics: NeverScrollableScrollPhysics(),
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
                      ],
                    ),

                  ],
                ),

              )

          );
        });
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
                    style: TextStyle(color: Colors.white, fontSize: 16),),
//                  Text(model.user == null ? ' ' : model.user.email,
//                    style: TextStyle(color: Colors.white, fontSize: 16),)
                ],
              ),

              color: Palette.assetColor,
            ),
            onTap: () async {
              User user = await UserPreferences.getUser();
              Navigator.pop(context);
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
                    Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => OrderHistoryView()));
                  }) : Container(),
              if(model.user != null)
                (model.user.isSeller || model.user.isAdmin) ?
              new ListTile(
                  leading: Icon(Icons.credit_card, color: Palette.assetColor),
                  title: new Text("Manage Orders", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),

                  onTap: () async {
                    Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ManageOrderView()));
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Payment_Screen()));

                  }) : Container(),

              new ListTile(
//                // Image.asset('images/bargain.png'),
                  leading: Icon(
                      Icons.people, color: Palette.assetColor),
                  title: new Text("Group Buy", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),

                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            GroupbuyView()));
                  }),

             !model.agentCheck ?
             new ListTile(
//                // Image.asset('images/bargain.png'),
                  leading: Icon(
                      Icons.monetization_on, color: Palette.assetColor),
                  title: new Text("Bargain History", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),

                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            BargainHistoryView()));
                  })
                 : Container(),
              !model.agentCheck ?
              new ListTile(
//                // Image.asset('images/bargain.png'),
                  leading: Icon(
                      Icons.credit_card, color: Palette.assetColor),
                  title: new Text("Credit Request", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
//                            AddUpdateCreditRqst()));
                    CreditProductsView()));
                  })
                  : Container(),
//              new ListTile(
//                  leading: Icon(Icons.settings, color: Palette.assetColor),
//                  title: new Text("Settings", style: TextStyle(
//                      color: Palette.assetColor, fontSize: 15)),
//                  trailing: Icon(
//                    Icons.arrow_forward, color: Palette.assetColor,),
//
//                  onTap: () {
//                    Navigator.push(context, MaterialPageRoute(
//                        builder: (context) =>
//                            Setting_Screen(toolbarname: 'Setting',)));
//                  }),

              new ListTile(
                  leading: Icon(Icons.help, color: Palette.assetColor),
                  title: new Text("Help", style: TextStyle(
                      color: Palette.assetColor, fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward, color: Palette.assetColor,),
                  onTap: () {
                    Navigator.pop(context);

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
                              child: new Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            new FlatButton(
                              child: new Text("Yes"),
                              onPressed: () {
                                UserPreferences.logOut();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Screen.Login.toString(), (
                                    Route<dynamic> route) => false);
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
                child: Text('Version:'+ model.version,
                    style: TextStyle(color: Palette.assetColor)),
              )

            ],
          ),
        ],
      ), elevation: 4.0,
    );
  }

  getBanner(List<BannerItem> bannerList) {
    return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            bannerList[index].imageUrl,
            fit: BoxFit.cover, width: double.infinity,);
        },
        itemCount: bannerList.length,
        pagination: new SwiperPagination(
            builder: new DotSwiperPaginationBuilder(
                color: Colors.grey, activeColor: Colors.blue)),
        loop: false,
        autoplay: true,
        autoplayDelay: 2000
    );
  }

  getRecentlyAddedData(HomeViewModel model) {
    return new GridView.builder(
        itemCount: model.recentItem.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        DetailsView(item: model.recentItem[index],)));
              },

              child: new Card(
                elevation: 3.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: model.recentItem[index].image != null
                            ? WidgetUtils
                            .getCategoryImage(model.recentItem[index].image)
                            : Icon(
                            Icons.refresh)),
                    Container(
                      color: Colors.black38,
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              model.recentItem[index].bargainenabled == true
                                  ? getBargainContainer()
//                              Container(
//                                alignment: Alignment.topLeft,
//                                child: Text('Bargain Enabled',
//                                  style: TextStyle(color: Colors.white,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 12),),
//                              )
                                  : Container(alignment: Alignment.topLeft),
                              Container(
                                alignment: Alignment.topRight
                                , child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: InkWell(child: Image.asset(
                                      'images/whatsapp.png', width: 30,
                                      height: 25,),
                                      onTap: () {
                                        launchWhatsApp(model.recentItem[index]);
                                      },),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, bottom: 3),
                                    child: InkWell(child: Image.asset(
                                      'images/mail.png', width: 25,
                                      height: 25,),
                                      onTap: () {
                                        launchEmail(model.recentItem[index]);
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

                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(model.recentItem[index].name,
                                style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                              Text(model.recentItem[index].manufacturer.name,
                                  style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w500)),
                              Text("Origin: " + model.recentItem[index].origin,
                                  style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.w500)),
                              Text("By: " +
                                  _getListedByDtl(model.recentItem[index])
                                  ,
                                  style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.w500)),
                            ],
                          )
//                          new Text(
//                            model.recentItem[index].name,
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                fontSize: 20.0,
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold),
//                          ),
                        ),
                      ],
                    )
//                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end
//                      , children: <Widget>[
//                        Container(
//                          //margin: EdgeInsets.only(left: 10.0),
//                          padding: EdgeInsets.only(
//                              left: 3.0, bottom: 3.0),
//                          alignment: Alignment.bottomLeft,
//                          child: new Text(
//                            model.recentItem[index].name,
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                fontSize: 20.0,
//                                color: Colors.white,
//                                fontWeight:
//                                FontWeight.bold),
//
//                          ),
//                        ),
//                        Container(
//                          alignment: Alignment.bottomRight
//                          , child: Row(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          crossAxisAlignment: CrossAxisAlignment.end
//                          , children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(bottom: 3),
//                            child: InkWell(child: Image.asset(
//                              'images/whatsapp.png', width: 30,
//                              height: 25,),
//                              onTap: () {
//                                launchWhatsAppMostOrder(model.mostOrder[index]);
//                              },),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(
//                                left: 3, right: 1, bottom: 3),
//                            child: InkWell(child: Image.asset(
//                              'images/mail.png', width: 25,
//                              height: 25,),
//                              onTap: () {
//                                launchEmailMostOrder(model.mostOrder[index]);
//                              },),
//                          )
//                        ],
//                        ),
//                        )
//                      ],
//                    ),
                  ],
                ),

              ),

          );
        });
  }

//  getMostOrderData(HomeViewModel model) {
//    return new GridView.builder(
//        itemCount: model.mostOrder.length,
//        shrinkWrap: true,
////        physics: NeverScrollableScrollPhysics(),
//        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 2),
//        itemBuilder: (BuildContext context, int index) {
//          return new GestureDetector(
//              onTap: () {
//                Navigator.push(context, MaterialPageRoute(
//                    builder: (context) =>
////                        DetailsView(item: model.recentItem[index],)));
////                GBDetailsView()));
//                GBDetailsView(gbitem: model.mostOrder[index],)));
//              },
//
//              child: new Card(
//                elevation: 3.0,
//                child: Stack(
//                  children: <Widget>[
//                    Positioned.fill(
//                        child: model.mostOrder[index].item.image != null
//                            ? WidgetUtils
//                            .getCategoryImage(model.mostOrder[index].item.image)
//                            : Icon(
//                            Icons.refresh)),
//                    Container(
//                      color: Colors.black38,
//                    ),
//                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.only(left: 2, right: 1),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
////                              model.mostOrder[index].item.bargainenabled == true
////                                  ? Container(
////                                alignment: Alignment.topLeft,
////                                child: Text('Bargain Enabled',
////                                  style: TextStyle(color: Colors.white,
////                                      fontWeight: FontWeight.bold,
////                                      fontSize: 12),),
////                              )
////                                  : Container(alignment: Alignment.topLeft),
//                              Container(
//                                alignment: Alignment.topRight
//                                , child: Row(
//                                mainAxisAlignment: MainAxisAlignment.end,
//                                crossAxisAlignment: CrossAxisAlignment.end,
//                                children: <Widget>[
//                                  Padding(
//                                    padding: const EdgeInsets.only(bottom: 3),
//                                    child: InkWell(child: Image.asset(
//                                      'images/whatsapp.png', width: 30,
//                                      height: 25,),
//                                      onTap: () {
////                                        launchWhatsApp(model.mostOrder[index]);
//                                      },),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.only(
//                                        left: 3, bottom: 3),
//                                    child: InkWell(child: Image.asset(
//                                      'images/mail.png', width: 25,
//                                      height: 25,),
//                                      onTap: () {
//                                        launchEmailMostOrder(model.mostOrder[index]);
//                                      },),
//                                  )
//                                ],
//                              ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Container(
//                          //margin: EdgeInsets.only(left: 10.0),
//                          padding: EdgeInsets.only(
//                              left: 3.0, bottom: 3.0),
//                          alignment: Alignment.bottomLeft,
//
//                          child: new Text(
//                            model.mostOrder[index].item.name,
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                fontSize: 20.0,
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold),
//                          ),
//                        ),
//                      ],
//                    )
////                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      crossAxisAlignment: CrossAxisAlignment.end
////                      , children: <Widget>[
////                        Container(
////                          //margin: EdgeInsets.only(left: 10.0),
////                          padding: EdgeInsets.only(
////                              left: 3.0, bottom: 3.0),
////                          alignment: Alignment.bottomLeft,
////                          child: new Text(
////                            model.recentItem[index].name,
////                            textAlign: TextAlign.center,
////                            style: TextStyle(
////                                fontSize: 20.0,
////                                color: Colors.white,
////                                fontWeight:
////                                FontWeight.bold),
////
////                          ),
////                        ),
////                        Container(
////                          alignment: Alignment.bottomRight
////                          , child: Row(
////                          mainAxisAlignment: MainAxisAlignment.end,
////                          crossAxisAlignment: CrossAxisAlignment.end
////                          , children: <Widget>[
////                          Padding(
////                            padding: const EdgeInsets.only(bottom: 3),
////                            child: InkWell(child: Image.asset(
////                              'images/whatsapp.png', width: 30,
////                              height: 25,),
////                              onTap: () {
////                                launchWhatsAppMostOrder(model.mostOrder[index]);
////                              },),
////                          ),
////                          Padding(
////                            padding: const EdgeInsets.only(
////                                left: 3, right: 1, bottom: 3),
////                            child: InkWell(child: Image.asset(
////                              'images/mail.png', width: 25,
////                              height: 25,),
////                              onTap: () {
////                                launchEmailMostOrder(model.mostOrder[index]);
////                              },),
////                          )
////                        ],
////                        ),
////                        )
////                      ],
////                    ),
//                  ],
//                ),
//
//              )
//
//          );
//        });
//  }
//
///*Shahnawaz-> Disabling section as its not required to create a separate model for most ordered */
//// nearby,mostordered and recent items will always return response which is based on item model
////  getMostOrderData(HomeViewModel model) {
////    return new GridView.builder(
////        itemCount: model.mostOrder.length,
//////        shrinkWrap: true,
////        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
////            crossAxisCount: 2),
////        itemBuilder: (BuildContext context, int index) {
////          return new GestureDetector(
////              onTap: () {
//////                Navigator.push(context, MaterialPageRoute(
//////                    builder: (context) =>
//////                        DetailsView(item: model.mostOrder[index],)));
////              },
////
////              child: new Card(
////                elevation: 3.0,
////                child: Stack(
////                  children: <Widget>[
////                    Positioned.fill(
////                        child: model.mostOrder[index].image != null
////                            ? WidgetUtils
////                            .getCategoryImage(model.mostOrder[index].image)
////                            : Icon(
////                            Icons.refresh)),
////                    Container(
////                      color: Colors.black38,
////                    ),
////                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      children: <Widget>[
////                        Padding(
////                          padding: const EdgeInsets.only(left: 2, right: 1),
////                          child: Row(
////                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                            children: <Widget>[
////                              model.mostOrder[index].bargainenabled == true
////                                  ? Container(
////                                alignment: Alignment.topLeft,
////                                child: Text('Bargain Enabled',
////                                  style: TextStyle(color: Colors.white,
////                                      fontWeight: FontWeight.bold,
////                                      fontSize: 12),),
////                              )
////                                  : Container(alignment: Alignment.topLeft),
////                              Container(
////                                alignment: Alignment.topRight
////                                , child: Row(
////                                mainAxisAlignment: MainAxisAlignment.end,
////                                crossAxisAlignment: CrossAxisAlignment.end,
////                                children: <Widget>[
////                                  Padding(
////                                    padding: const EdgeInsets.only(bottom: 3),
////                                    child: InkWell(child: Image.asset(
////                                      'images/whatsapp.png', width: 30,
////                                      height: 25,),
////                                      onTap: () {
////                                        launchWhatsAppMostOrder(
////                                            model.mostOrder[index]);
////                                      },),
////                                  ),
////                                  Padding(
////                                    padding: const EdgeInsets.only(
////                                        left: 3, bottom: 3),
////                                    child: InkWell(child: Image.asset(
////                                      'images/mail.png', width: 25,
////                                      height: 25,),
////                                      onTap: () {
////                                        launchEmailMostOrder(
////                                            model.mostOrder[index]);
////                                      },),
////                                  )
////                                ],
////                              ),
////                              ),
////                            ],
////                          ),
////                        ),
////                        Container(
////                          //margin: EdgeInsets.only(left: 10.0),
////                          padding: EdgeInsets.only(
////                              left: 3.0, bottom: 3.0),
////                          alignment: Alignment.bottomLeft,
////
////                          child: new Text(
////                            model.mostOrder[index].name,
////                            textAlign: TextAlign.center,
////                            style: TextStyle(
////                                fontSize: 20.0,
////                                color: Colors.white,
////                                fontWeight: FontWeight.bold),
////                          ),
////                        ),
////                      ],
////                    ),
//////                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//////                      crossAxisAlignment: CrossAxisAlignment.end
//////                      , children: <Widget>[
//////                        Container(
//////                          padding: EdgeInsets.only(
//////                              left: 3.0, bottom: 3.0),
//////                          alignment: Alignment.bottomLeft,
//////                          child: new Text(
//////                            model.mostOrder[index].name,
//////                            textAlign: TextAlign.center,
//////                            style: TextStyle(
//////                                fontSize: 20.0,
//////                                color: Colors.white,
//////                                fontWeight:
//////                                FontWeight.bold),
//////                          ),
//////                        ),
//////                        Container(
//////                          alignment: Alignment.bottomRight
//////                          , child: Row(
//////                          mainAxisAlignment: MainAxisAlignment.end,
//////                          crossAxisAlignment: CrossAxisAlignment.end
//////                          , children: <Widget>[
//////                          Padding(
//////                            padding: const EdgeInsets.only(bottom: 3),
//////                            child: InkWell(child: Image.asset(
//////                              'images/whatsapp.png', width: 30,
//////                              height: 25,),
//////                              onTap: () {
//////                                launchWhatsAppMostOrder(model.mostOrder[index]);
//////                              },),
//////                          ),
//////                          Padding(
//////                            padding: const EdgeInsets.only(
//////                                left: 3, right: 1, bottom: 3),
//////                            child: InkWell(child: Image.asset(
//////                              'images/mail.png', width: 25,
//////                              height: 25,),
//////                              onTap: () {
//////                                launchEmailMostOrder(model.mostOrder[index]);
//////                              },),
//////                          )
//////                        ],
//////                        ),
//////                        )
//////                      ],
//////                    ),
////                  ],
////                ),
////              )
////          );
////        });
////  }

  getMostOrderData(HomeViewModel model) {
    return new GridView.builder(
        itemCount: model.mostOrder.length,
        shrinkWrap: true,
//        physics: NeverScrollableScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
//                Navigator.push(context, MaterialPageRoute(
//                    builder: (context) =>
//                        DetailsView(item: model.mostOrder[index],)));
              },

              child: new Card(
                elevation: 3.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: model.mostOrder[index].name.image != null
                            ? WidgetUtils
                            .getCategoryImage(model.mostOrder[index].name.image)
                            : Icon(
                            Icons.refresh)),
                    Container(
                      color: Colors.black38,
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              model.mostOrder[index].name.bargainenabled == true
                                  ? Container(
                                alignment: Alignment.topLeft,
                                child: Text('Bargain Enabled',
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),),
                              )
                                  : Container(alignment: Alignment.topLeft),
                              Container(
                                alignment: Alignment.topRight
                                , child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: InkWell(child: Image.asset(
                                      'images/whatsapp.png', width: 30,
                                      height: 25,),
                                      onTap: () {
                                        launchWhatsAppMostOrder(model.mostOrder[index]);
                                      },),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, bottom: 3),
                                    child: InkWell(child: Image.asset(
                                      'images/mail.png', width: 25,
                                      height: 25,),
                                      onTap: () {
                                        launchEmailMostOrder(model.mostOrder[index]);
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

                          child: new Text(
                            model.mostOrder[index].name.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

              )

          );
        });
  }

  getItemsNearMe(HomeViewModel model) {
    return new GridView.builder(
        itemCount: model.itemsNear.length,
        shrinkWrap: true,
//        physics: NeverScrollableScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        DetailsView(item: model.itemsNear[index],)));
              },

              child: new Card(
                elevation: 3.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: model.itemsNear[index].image != null
                            ? WidgetUtils
                            .getCategoryImage(model.itemsNear[index].image)
                            : Icon(
                            Icons.refresh)),
                    Container(
                      color: Colors.black38,
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              model.itemsNear[index].bargainenabled == true
                                  ? getBargainContainer()
//                              Container(
//                                alignment: Alignment.topLeft,
//                                child: Text('Bargain Enabled',
//                                  style: TextStyle(color: Colors.white,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 12),),
//                              )
                                  : Container(alignment: Alignment.topLeft),
                              Container(
                                alignment: Alignment.topRight
                                , child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: InkWell(child: Image.asset(
                                      'images/whatsapp.png', width: 30,
                                      height: 25,),
                                      onTap: () {
                                        launchWhatsApp(model.itemsNear[index]);
                                      },),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, bottom: 3),
                                    child: InkWell(child: Image.asset(
                                      'images/mail.png', width: 25,
                                      height: 25,),
                                      onTap: () {
                                        launchEmail(model.itemsNear[index]);
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

                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(model.itemsNear[index].name,
                                style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                              Text(model.itemsNear[index].manufacturer.name,
                                  style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w500)),
                              Text("Origin: " + model.itemsNear[index].origin,
                                  style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.w500)),
                              Text("By: " +
                                  _getListedByDtl(model.itemsNear[index])
                                  ,
                                  style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.w500)),
                            ],
                          )
//                          new Text(
//                            model.itemsNear[index].name,
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                fontSize: 20.0,
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold),
//                          ),
                        ),
                      ],
                    )
//                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end
//                      , children: <Widget>[
//                        Container(
//                          //margin: EdgeInsets.only(left: 10.0),
//                          padding: EdgeInsets.only(
//                              left: 3.0, bottom: 3.0),
//                          alignment: Alignment.bottomLeft,
//                          child: new Text(
//                            model.recentItem[index].name,
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                fontSize: 20.0,
//                                color: Colors.white,
//                                fontWeight:
//                                FontWeight.bold),
//
//                          ),
//                        ),
//                        Container(
//                          alignment: Alignment.bottomRight
//                          , child: Row(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          crossAxisAlignment: CrossAxisAlignment.end
//                          , children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(bottom: 3),
//                            child: InkWell(child: Image.asset(
//                              'images/whatsapp.png', width: 30,
//                              height: 25,),
//                              onTap: () {
//                                launchWhatsAppMostOrder(model.mostOrder[index]);
//                              },),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(
//                                left: 3, right: 1, bottom: 3),
//                            child: InkWell(child: Image.asset(
//                              'images/mail.png', width: 25,
//                              height: 25,),
//                              onTap: () {
//                                launchEmailMostOrder(model.mostOrder[index]);
//                              },),
//                          )
//                        ],
//                        ),
//                        )
//                      ],
//                    ),
                  ],
                ),

              )

          );
        });
  }

//  Future launchEmail(Item recentItem) async {
//    launch('mailto:?subject=${"Graineasy item listing: " +
//        recentItem.name}&body=${'Category:' +
//        recentItem.category.name + "\n" +
//        'List Price:' + '\u20B9'+ '${recentItem.price}' + "/" + '${recentItem.unit.mass}'+ "\n" +
//        recentItem.image}' + "\n" +
//        'For details visit ' + 'https://graineasy.com/products/'+'${recentItem.id}' );
//  }
//
//  Future launchWhatsApp(Item recentItem) async {
//    FlutterShareMe().shareToWhatsApp(
//        msg: recentItem.name + "/" + recentItem.category.name + "\n" +
//            'List Price:' + '\u20B9'+ '${recentItem.price}' + "/" + '${recentItem.unit.mass}'+ "\n" +
//            recentItem.image);
//  }

  Future launchEmailMostOrder(MostOrderedItem mostOrder) async {
    launch('mailto:?subject=${"ItemName: " +
        mostOrder.name.name}&body=${mostOrder.name.name + "/" + mostOrder.name.category.name +
        "\n" +
        mostOrder.name.image}');
  }

  Future launchWhatsAppMostOrder(MostOrderedItem mostOrder) async {
    FlutterShareMe().shareToWhatsApp(
        msg: mostOrder.name.name + "/" + mostOrder.name.category.name + "\n" +
            mostOrder.name.image);
  }

  _getListedByDtl(Item item) {
    String listedText;
    String userExists;
    userExists = item.addedBy.name ?? 'false';
    if (item.showAddedByName){
      listedText = item.addedBy.name ?? 'Broker';
    }
    else {
      if (userExists == 'false') {
        listedText = 'Broker';
      } else {
        if (item.addedBy.isSeller) {
          listedText = 'Seller';
        } else {
          listedText = 'Broker';
        }
      }
    }
    return listedText;
  }
}


