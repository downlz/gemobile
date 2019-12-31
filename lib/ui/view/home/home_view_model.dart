import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/MostOrderedItem.dart';
import 'package:graineasy/model/bannerItem.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view.dart';
import 'package:graineasy/ui/view/item_details/details_view.dart';
import 'package:graineasy/ui/view/manage_order_detail/manage_order_detail_view.dart';
import 'package:graineasy/ui/view/order_detail/order_detail_view.dart';

class HomeViewModel extends BaseModel
{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(
      debugLabel: "Main Navigator");

  List<ItemName> items;
  List<Item> recentItem;
  List<MostOrderedItem> mostOrder;
  List<BannerItem> bannerList = [];

  List<Item> itemsNear;
  User user;
  bool agentCheck = false;
  bool isFirstTime = true;
  String deviceplatform;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var id;


  Future<void> receivePushNotification() async {
    firebaseMessaging.getToken().then((token) {
      print('FirebaseToken=======>${token}');
    });

    firebaseMessaging.onTokenRefresh;
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
//        await API.updateUserApiToGetFCMKey();

        print('on message ${json.encode(message['notification']['title'])}');
        String jsonData = json.encode(message);
        var updatedJsonData = jsonData
            .replaceAll('\\', '')
            .replaceAll('"{', '{')
            .replaceAll('}"', '}')
            .replaceAll('"[', '[')
            .replaceAll(']"', ']');

        var type = message['data']['type'];
        id = message['data']['id']
            .replaceAll('"', '');

        print("updatedJsonData-------------$updatedJsonData");

        if (message['data'] != null && message['data']['type'] != null) {
          switch (type) {
            case "OrderDetail":
              return showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      content: ListTile(
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
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
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
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
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
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
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
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
                                          BargainView(id: id)));
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
      },

      onResume: (Map<String, dynamic> message) async {
        print('on message ${json.encode(message['notification']['title'])}');
        String jsonData = json.encode(message);
        var updatedJsonData = jsonData
            .replaceAll('\\', '')
            .replaceAll('"{', '{')
            .replaceAll('}"', '}')
            .replaceAll('"[', '[')
            .replaceAll(']"', ']');

        var type = message['data']['type'];
        id = message['data']['id']
            .replaceAll('"', '');

        print("updatedJsonData-------------$updatedJsonData");

        var notification = message['data'];
        await API.updateUserApiToGetFCMKey();
        print('resume message data========>' + notification);

        print('on resume ${json.encode(message['notification']['title'])}');

        print("Resume-------------${id + type}");
        if (message['data'] != null && message['data']['type'] != null) {
          switch (type) {
            case "OrderDetail":
              return showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      content: ListTile(
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
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
            default:
              break;
          }
        }
      },

      onLaunch: (Map<String, dynamic> message) async {
        firebaseMessaging.onTokenRefresh;
        await API.updateUserApiToGetFCMKey();
        print('on launch $message');
        String jsonData = json.encode(message);
        var updatedJsonData = jsonData
            .replaceAll('\\', '')
            .replaceAll('"{', '{')
            .replaceAll('}"', '}')
            .replaceAll('"[', '[')
            .replaceAll(']"', ']');

        var type = message['data']['type'];
        id = message['data']['id'].replaceAll('"', '');
        print("Launch-------------${id + type}");
        print("LaunchUpdate-------------$updatedJsonData");

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
                              child: Text('Cancel'),
                              onPressed: () =>
                                  Navigator.pop(context)
                          ),
                          FlatButton(
                              child: Text('View'),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailView(id: id,)));
                              }
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
  }

  init() {
    if (isFirstTime) {
      userDetail();
      getItemName();
      receivePushNotification();
      isFirstTime = false;

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

}
