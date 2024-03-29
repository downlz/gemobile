import 'package:flutter/material.dart';
import 'package:graineasy/Cart_Screen.dart';
import 'package:graineasy/helpers/common/sharing.dart';
import 'package:graineasy/helpers/common/links.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_phone_number_screeen.dart';

class Help_Screen extends StatefulWidget {
  final String toolbarname;

  Help_Screen({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Help(toolbarname);
}

class Help extends State<Help_Screen> {
  List list = ['12', '11'];

  bool switchValue = false;

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  Help(this.toolbarname);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
    theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

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
        body: Container(
          child: Column(
            children: <Widget>[

              new Container(
                height: 50.0,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: new Row(
                  children: <Widget>[
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signup_screen()));*/
                      },
                      child: new Text(
                        'Contact Us',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Card(
                    elevation: 4,
                    child: Container(
                      //  padding: EdgeInsets.only(left: 10.0,top: 15.0,bottom: 5.0,right: 5.0),

                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.mail, color: Colors.black54),
                                    Container(
                                      margin: EdgeInsets.only(left: 5.0),
                                    ),
                                    Text(
                                      'Email US',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  launchCustomerEmail();
                                },
                              )),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.info,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                      ),
                                      Text(
                                        'About US',
                                        style: TextStyle(
                                            fontSize: 17.0, color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    showDemoDialog<DialogDemoAction>(
                                        context: context,
                                        child: AlertDialog(
                                            title: const Text('About Us'),
                                            content: Text(
                                                "A B2B Marketplace for agricultural commodities offering financial services. © 2020 Funfact eMarketplace Pvt Ltd. All rights reserved. Reach us at trade@graineasy.com",
                                                style: dialogTextStyle),
                                            actions: <Widget>[
                                              FlatButton(
                                                  child: const Text('Close'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                              /* FlatButton(
                                              child: const Text('AGREE'),
                                              onPressed: () {
                                                Navigator.pop(context,
                                                    DialogDemoAction.agree);
                                              })*/
                                            ]));
                                  })),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.feedback,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                      ),
                                      Text(
                                        'Send Feedback',
                                        style: TextStyle(
                                            fontSize: 17.0, color: Colors.black87),
                                      ),

                                    ],
                                  ),
                                  onTap: () {
                                      launchFeedbackEmail();

//                                    showDemoDialog<DialogDemoAction>(
//                                        context: context,
//                                        child: AlertDialog(
//                                            title: const Text('Send Feedback'),
//                                            content: Text(
//                                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                                                style: dialogTextStyle),
//                                            actions: <Widget>[
//                                              FlatButton(
//                                                  child: const Text('DISAGREE'),
//                                                  onPressed: () {
//                                                    Navigator.pop(context,
//                                                        DialogDemoAction.disagree);
//                                                  }),
//                                              /* FlatButton(
//                                              child: const Text('AGREE'),
//                                              onPressed: () {
//                                                Navigator.pop(context,
//                                                    DialogDemoAction.agree);
//                                              })*/
//                                            ]));
                                  })),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.security,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                      ),
                                      Text(
                                        'Terms Of Use',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black87),
                                      ),

                                    ],
                                  ),
                                  onTap: () {
                                    launchTermsOfServiceURL();
                                  }
                              )),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.call, color: Colors.black54),
                                    Container(
                                      margin: EdgeInsets.only(left: 5.0),
                                    ),
                                    Text(
                                      'Phone',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddPhoneNumber()));
                                },
                              )),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/whatsapp.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Live Support',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Palette.assetColor,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                                onTap: () async {
//                      launch("tel://+91 8297 855 195");

                                  var phone = "+91 8297 855 195";
                                  var whatsAppUrl = "whatsapp://send?phone=$phone";
                                  await canLaunch(whatsAppUrl)
                                      ? launch(whatsAppUrl)
                                      : print(
                                      "Unable to launch Whatsapp as no such application is installed.");
                                },
                              )
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ));
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        /*_scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('You selected: $value')
        ));*/
      }
    });
  }

  _verticalD() => Container(
    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
  );

  _verticalDivider() => Container(
    padding: EdgeInsets.all(2.0),
  );

  Widget _status(status) {
    if (status == 'Cabcel Order') {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 18.0,
            color: Colors.red,
          ),
          onPressed: () {
            // Perform some action
          });
    } else {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.green),
          ),
          icon: const Icon(
            Icons.check_circle,
            size: 18.0,
            color: Colors.green,
          ),
          onPressed: () {
            // Perform some action
          });
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
}


