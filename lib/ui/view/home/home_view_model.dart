import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/bannerItem.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:graineasy/model/MostOrderedItem.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view.dart';
import 'package:graineasy/ui/view/item_details/details_view.dart';
import 'package:graineasy/ui/view/manage_order_detail/manage_order_detail_view.dart';
import 'package:graineasy/ui/view/order_detail/order_detail_view.dart';

class HomeViewModel extends BaseModel
{
  List<ItemName> items;
  List<Item> recentItem;
//  List<MostOrderItem> mostOrder;
    List<MostOrderedItem> mostOrder;
  List<BannerItem> bannerList = [];

//  List<Groupbuy> mostOrder;
//  List<Item> mostOrder;
  List<Item> itemsNear;
  User user;
  bool isFirstTime = true;
  String deviceplatform;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
//  String type;
  var id;


  void receivePushNotification() {
    String payload;
    firebaseMessaging.getToken().then((token) {
      print('FirebaseToken=======>${token}');
    });

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message ${json.encode(message['notification']['title'])}');
        print('push notification');
        print(
            'notification message data=======================>${message['data']}');


//        if(message['data']!=null) {
//           type = message['data']['type'];
//          id GBDetailsView= message['data']['id'];
//          print('typeId=======>${"type----" + type + "id-----" + id}');
//        }
//        else
//          {
//            print('message not show');
//          }


        var type = message['data']['type'];
        id = message['data']['id'];

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
                                  prefix0.Navigator.pop(context);
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
//        return showDialog(
//          context: context,
//          builder: (context) =>
//              AlertDialog(
//                content: ListTile(
//                  title: Text(message['notification']['title']),
//                  subtitle: Text(message['notification']['body']),
//                ),
//                actions: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      FlatButton(
//                          child: Text('View'),
//                          onPressed: () =>
//                              Navigator.push(context, MaterialPageRoute(
//                                  builder: (context) => OrderHistoryView()))
//                      ),
//                      FlatButton(
//                          child: Text('Cancel'),
//                          onPressed: () =>
//                              Navigator.pop(context)
//                      ),
//                    ],
//                  ),
//
//                ],
//                elevation: 2,
//              ),
//        );
      },

      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        var notification = message['data'];
        print('resume message data========>' + notification);
        return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Resume'),
                      onPressed: () =>
                          Navigator.pop(context)
                  ),

                ],
                elevation: 2,
              ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        var notification = message['data'];
        print('launch message data========>' + notification);
        return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Launch'),
                      onPressed: () =>
                          Navigator.pop(context)
                  ),
                ],
                elevation: 2,
              ),
        );
      },
    );
  }

  getItemName() async
  {
    setState(ViewState.Busy);
    items = await API.getItemName();
    getRecentlyAddedItem();
  }

  Future userDetail() async {
    user = await UserPreferences.getUser();
  }

  void init() {
    if(isFirstTime) {
      userDetail();
      getItemName();
      receivePushNotification();
      isFirstTime = false;

      if (bannerList != null && bannerList.length > 0) {
        bannerList.clear();
      }
      getBannerItem();
    }
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
