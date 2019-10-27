import 'dart:convert';
import 'package:graineasy/Cart_Screen.dart';
import 'package:graineasy/item_details.dart';
import 'package:graineasy/services/login.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/utils/loader.dart';
import 'package:connectivity/connectivity.dart';
import 'package:localstorage/localstorage.dart';
import 'package:graineasy/helpers/getToken.dart';
import 'package:graineasy/logind_signup.dart';
import 'package:graineasy/helpers/showDialogSingleButton.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
final LocalStorage storage = new LocalStorage('GEUser');

class LoginPage extends StatefulWidget {
  final String toolbarname;

  LoginPage({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => login_dtl(toolbarname);
}

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final String cancelOder;

  Item({this.name,
        this.deliveryTime,
        this.oderId,
        this.oderAmount,
        this.paymentType,
        this.address,
        this.cancelOder});

  factory Item.fromJson(Map<String, dynamic> json) {
    return new Item(
      name: json['sampleNo'],
      deliveryTime: json['origin'],
        oderId: json['grainCount'],
        oderAmount: json['grainCount'],
        paymentType: json['grainCount'],
    address: json['origin'],
    cancelOder: json['grade']
    );
  }

}

class login_dtl extends State<LoginPage> {
  List<Item> itemList = List();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _onView();
  }

//  @override
//  void initState() {
//    // here first we are checking network connection
//    isConnected().then((internet) {
//      if (internet) {
//        // set state while we fetch data from API
//        setState(() {
//          // calling API to show the data
//          // you can also do it with any button click.
//              _onView();
//        });
//      } else {
//        /*Display dialog with no internet connection message*/
//      }
//    });
//    super.initState();
//  }

  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;
//  List<Item> itemList = <Item>[
//    Item(
//        name: 'Jhone Miller',
//        deliveryTime: '26-5-2106',
//        oderId: '#CN23656',
//        oderAmount: '\₹ 650',
//        paymentType: 'online',
//        address: '1338 Karen Lane,Louisville,Kentucky',
//        cancelOder: 'Cancel Order'),
//    Item(
//        name: 'Gautam Dass',
//        deliveryTime: '10-8-2106',
//        oderId: '#CN33568',
//        oderAmount: '\₹ 900',
//        paymentType: 'COD',
//        address: '319 Alexander Drive,Ponder,Texas',
//        cancelOder: 'View Receipt'),
//    Item(
//        name: 'Jhone Hill',
//        deliveryTime: '23-3-2107',
//        oderId: '#CN75695',
//        oderAmount: '\₹ 250',
//        paymentType: 'online',
//        address: '92 Jarvis Street,Buffalo,New York',
//        cancelOder: 'View Receipt'),
//    Item(
//        name: 'Miller Root',
//        deliveryTime: '10-5-2107',
//        oderId: '#CN45238',
//        oderAmount: '\₹ 500',
//        paymentType: 'Bhim/upi',
//        address: '103 Romrog Way,Grand Island,Nebraska',
//        cancelOder: 'Cancel Order'),
//    Item(
//        name: 'Lag Gilli',
//        deliveryTime: '26-10-2107',
//        oderId: '#CN69532',
//        oderAmount: '\₹ 1120',
//        paymentType: 'online',
//        address: '8 Clarksburg Park,Marble Canyon,Arizona',
//        cancelOder: 'View Receipt'),
//  ];

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  login_dtl(this.toolbarname);

  @override
  Widget build(BuildContext context) {

      // TODO: implement build
      IconData _backIcon() {
        switch (Theme.of(context).platform) {
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
            return Icons.arrow_back;
          case TargetPlatform.iOS:
            return Icons.arrow_back_ios;
        }
        assert(false);
        return null;
      }

      var size = MediaQuery.of(context).size;

      /*24 is for notification bar on Android*/
      final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
      final double itemWidth = size.width / 2;

      final Orientation orientation = MediaQuery.of(context).orientation;
      return new Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(_backIcon()),
              alignment: Alignment.centerLeft,
              tooltip: 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(toolbarname),
            backgroundColor: Colors.white,
          ),
// **************************************************************************************************
          body: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (BuildContext cont, int ind) {
                return SafeArea(
                    child: Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                          color:Colors.black12,
                          child: Card(
                              elevation: 4.0,
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: GestureDetector(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          // three line description
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              itemList[ind].name,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(top: 3.0),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'To Deliver On :' +
                                                  itemList[ind].deliveryTime,
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.black54),
                                            ),
                                          ),
                                          Divider(
                                            height: 10.0,
                                            color: Colors.amber.shade500,
                                          ),

                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Order Id',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black54),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(top: 3.0),
                                                        child: Text(
                                                          itemList[ind].oderId,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors.black87),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Order Amount',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black54),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(top: 3.0),
                                                        child: Text(
                                                          itemList[ind].oderAmount,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors.black87),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Payment Type',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.black54),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(top: 3.0),
                                                        child: Text(
                                                          itemList[ind].paymentType,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors.black87),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          Divider(
                                            height: 10.0,
                                            color: Colors.amber.shade500,
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                Icons.location_on,
                                                size: 20.0,
                                                color: Colors.amber.shade500,
                                              ),
                                              Text(itemList[ind].address,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black54)),
                                            ],
                                          ),
                                          Divider(
                                            height: 10.0,
                                            color: Colors.amber.shade500,
                                          ),
                                          Container(
                                              child:_status(itemList[ind].cancelOder)
                                          )
                                        ],
                                      ))))),
                    ]));
              })
// **************************************************************************************************
//      )
//    ])
    );
  }

  _verticalDivider() => Container(
    padding: EdgeInsets.all(2.0),
  );

  Widget _status(status) {
    if(status == 'Cancel Order'){
      return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.red),),
          icon: const Icon(Icons.highlight_off, size: 18.0,color: Colors.red,),
          onPressed: _onSubmit
      );
    }
    else{
      return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.green),),
          icon: const Icon(Icons.check_circle, size: 18.0,color: Colors.green,),
          onPressed: _logout
//              () {
//            // Perform some action
//          }
      );
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }
  erticalD() => Container(
    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
  );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }

  void _onSubmit() async{
//    final LocalStorage storage = new LocalStorage('GEUser');
//    _loginKey.currentState.save();
    //print(_loginKey.currentState.value);
    // if(_loginKey.currentState.validate()){
//    Map<dynamic,dynamic> data=_loginKey.currentState.value;
    Map<dynamic,dynamic> data;
    data = {'phone': '1111111111','password':'addapass'};
//     print(data);

    var response=await LoginService.userLogin(data);
    //print(val);
    if(response.statusCode==200){
      print(response.body);
      var decodeResponse=jsonDecode(response.body);
      storage.setItem('GEUser', decodeResponse);
    }
    else{
      print(response.body);
      print("Login ERROR");
    }

  }

  void _onGetOrder() async{

    var token;
    await getToken().then((result) {
      token = result;
    });


    var response=await LoginService.userOrder(token);
    if(response.statusCode==200){
      print(response.body);
      var decodeResponse=jsonDecode(response.body);
    }
    else{
      print(response.body);
      showDialogSingleButton(context, "Unable to get Order Details", "Faced connectivity issue while pulling order details or authenticated failure", "OK");
    }
  }

  _onView() async {
    setState(() {
      isLoading = true;
    });
//    var itemResponse;
    var response=await LoginService.getItems();
    if(response.statusCode==200){
//      itemResponse=jsonDecode(response.body);
      itemList = (json.decode(response.body) as List)
          .map((data) => new Item.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    }
    else{
//      print(response.body);
      print("Login ERROR");
//      itemResponse = {'result':'error'};
    }

  }

  void _logout() async{
    var response=await LoginService.userLogout();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_Screen()));

    // Test to validate token got expired

    var token;
    await getToken().then((result) {
      token = result;
    });
    print('Token value is - ' +  token);
  }

  // Progress indicator widget to show loading.
  Widget loadingView() => Center(
    child: ColorLoader3()
    );

  // method defined to check internet connectivity
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
