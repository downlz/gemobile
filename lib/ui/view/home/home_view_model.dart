import 'dart:convert';
import 'package:package_info/package_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/helpers/functions/common.dart';

import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/MostOrderedItem.dart';
import 'package:graineasy/model/bannerItem.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/ui/view/item_details/details_view.dart';
import 'package:graineasy/ui/view/manage_order_detail/manage_order_detail_view.dart';
import 'package:graineasy/ui/view/order_detail/order_detail_view.dart';
import 'package:graineasy/ui/view/BargainDetail/bargain_history_view.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view.dart';


class HomeViewModel extends BaseModel
{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(
      debugLabel: "Main Navigator");

  List<ItemName> items;
  List<Item> recentItem;
  List<MostOrderedItem> mostOrder;
  List<BannerItem> bannerList = [];
  Bargain bargainDetail;

  List<Item> itemsNear;
  User user;
  bool agentCheck = false;
  bool isFirstTime = true;
  String deviceplatform;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  String id;
  String version;


  void receivePushNotification() {
    firebaseMessaging.getToken().then((token) {
      print('FirebaseToken=======>${token}');
    });


    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message ${json.encode(message['data']['title'])}');
//        var type = message['data']['type'];       // Storing as old reference
//        id = message['data']['id'];
//
//        print("Message-------------${id + type}");
        redirectScreenOnLoad(message);
      },

      onResume: (Map<String, dynamic> message) async {
        firebaseMessaging.onTokenRefresh;
        print('on resume $message');
        redirectScreenOnLoad(message);

      },

      onLaunch: (Map<String, dynamic> message) async {
        firebaseMessaging.onTokenRefresh;
//        await API.updateUserApiToGetFCMKey();
        print('on launch $message');
        redirectScreenOnLoad(message);
      },
    );
  }

  getItemName() async
  {
    setState(ViewState.Busy);
    items = await API.getItemName();
    getRecentlyAddedItem();
  }

  userDetail() async {
    user = await UserPreferences.getUser();
    agentCheck = user.isAgent;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  init() {
    if(isFirstTime) {
      isFirstTime = false;
      userDetail();
      getItemName();
      receivePushNotification();

      if (bannerList != null && bannerList.length > 0) {
        bannerList.clear();
      }
      getBannerItem();
    }
//    WidgetsBinding.instance.addPostFrameCallback((_) => setState((ViewState.Idle)));
  }

  getRecentlyAddedItem() async {
    recentItem = await API.getRecentlyAddedItem();
    getMostOrdered();
    getItemsNearMe();
  }

  getMostOrdered() async {
    mostOrder = await API.getMostOrder();
//    mostOrder = await API.getGBListings();
    setState(ViewState.Idle);
  }

  getItemsNearMe() async {
    itemsNear = await API.getItemsNear();
    setState(ViewState.Idle);
  }

  getBannerItem() async {
    bannerList = await API.getBanners();
    notifyListeners();
  }

  redirectScreenOnLoad(var message) async {

    var type = message['data']['type'];
    id = message['data']['id'];
    String idc = slice(id,1,-1);
    print(id);
    if (message['data'] != null && message['data']['type'] != null) {
      switch (type) {
        case "OrderDetail":
          return showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  content: ListTile(
                    title: Text(message['data']['title']),
                    subtitle: Text(message['data']['body']),
                  ),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Text('View'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetailView(id: id,)));
                            }
                        ),
                        FlatButton(
                            child: Text('Cancel'),
                            onPressed: () =>
                                Navigator.pop(context)
                        ),
                      ],
                    ),

                  ],
                  elevation: 2,
                ),
          );
          break;
        case "ProductDetail":
          return showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  content: ListTile(
                    title: Text(message['data']['title']),
                    subtitle: Text(message['data']['body']),
                  ),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Text('View'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsView(id: id,)));
                            }
                        ),
                        FlatButton(
                            child: Text('Cancel'),
                            onPressed: () =>
                                Navigator.pop(context)
                        ),
                      ],
                    ),
                  ],
                  elevation: 2,
                ),
          );
          break;
        case "ManageOrder":
          return showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  content: ListTile(
                    title: Text(message['data']['title']),
                    subtitle: Text(message['data']['body']),
                  ),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Text('View'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      ManageOrderDetailView(id: id,)));
                            }
                        ),
                        FlatButton(
                            child: Text('Cancel'),
                            onPressed: () =>
                                Navigator.pop(context)
                        ),
                      ],
                    ),

                  ],
                  elevation: 2,
                ),
          );
          break;
        case "BargainDetail":
          return showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  content: ListTile(
                    title: Text(message['data']['title']),
                    subtitle: Text(message['data']['body']),
                  ),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Text('View'),
                            onPressed: () {
                              prefix0.Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                          BargainView(id: id,))); // Using idc as firebase is sending id in quotes. The quotes are removed
//                                  BargainHistoryView()));
                            }
                        ),
                        FlatButton(
                            child: Text('Cancel'),
                            onPressed: () =>
                                Navigator.pop(context)
                        ),
                      ],
                    ),

                  ],
                  elevation: 2,
                ),
          );
        case "BargainHistory":
          return showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  content: ListTile(
                    title: Text(message['data']['title']),
                    subtitle: Text(message['data']['body']),
                  ),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Text('View'),
                            onPressed: () {
                              prefix0.Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      BargainHistoryView()));
                            }
                        ),
                        FlatButton(
                            child: Text('Cancel'),
                            onPressed: () =>
                                Navigator.pop(context)
                        ),
                      ],
                    ),

                  ],
                  elevation: 2,
                ),
          );
          break;
        default:
          break;
      }
    }
  }

}