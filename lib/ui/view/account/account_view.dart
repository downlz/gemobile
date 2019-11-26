import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/ui/view/account/add_update_address/add_update_addresses_view.dart';
import 'package:graineasy/ui/widget/AppBar.dart';

import 'account_view_model.dart';


class AccountVIew extends StatefulWidget {
  User user;

  AccountVIew(this.user);


  @override
  _AccountVIewState createState() => _AccountVIewState();
}

class _AccountVIewState extends State<AccountVIew> with CommonAppBar {
  @override
  Widget build(BuildContext context) {
    return BaseView<AccountViewModel>(builder: (context, model, child) {
      model.init(API.user.phone, API.user.id);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('My Account'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(AccountViewModel model) {
    return Stack(
      children: <Widget>[
        model.isFirstTime ? Container() : _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(AccountViewModel model) {
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

  _getBaseContainer(AccountViewModel model) {
    model.getUserDetail();
    Icon ofericon = new Icon(
      Icons.edit,
      color: Colors.black38,
    );
    Icon keyloch = new Icon(
      Icons.vpn_key,
      color: Colors.black38,
    );
    Icon clear = new Icon(
      Icons.history,
      color: Colors.black38,
    );
    Icon logout = new Icon(
      Icons.do_not_disturb_on,
      color: Colors.black38,
    );
    return new ListView(
      children: <Widget>[
        new Container(height: 150,
          alignment: Alignment.topCenter,
          child: new Card(
            elevation: 3.0,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(
                      left: 10.0, top: 20.0, right: 5.0, bottom: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        widget.user.name,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      _verticalDivider(),
                      Container(),
//                      new Text(
//                        'Admin Email',
//                        style: TextStyle(
//                            color: Colors.black45,
//                            fontSize: 13.0,
//                            fontWeight: FontWeight.bold,
//                            letterSpacing: 0.5),
//                      ),
                      _verticalDivider(),
                      new Text(
                        widget.user.phone,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                      )
                    ],
                  ),
                ),
                // VerticalDivider(),
              ],
            ),
          ),
        ),
        new Container(
          margin:
              EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'Addresses',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              IconButton(icon: Icon(Icons.add_circle), onPressed: () {
                print('click');
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => AddUpdateAddressView()
                    ));
              })
            ],
          ),
        ),
        addressList(model),
        new Container(
          margin:
          EdgeInsets.only(left: 12.0, top: 10.0, bottom: 5.0),
          child: new Text(
            'Bank Account',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
        ),
        bankAccountList(model),
        new Container(
          margin: EdgeInsets.all(7.0),
          child: Card(
            elevation: 1.0,
            child: Row(
              children: <Widget>[
                new IconButton(icon: keyloch, onPressed: null),
                _verticalD(),
                new Text(
                  'Change Password',
                  style: TextStyle(fontSize: 15.0, color: Colors.black87),
                )
              ],
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.all(7.0),
          child: Card(
            elevation: 1.0,
            child: Row(
              children: <Widget>[
                new IconButton(icon: clear, onPressed: null),
                _verticalD(),
                new Text(
                  'Clear History',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.all(7.0),
          child: Card(
            elevation: 1.0,
            child: Row(
              children: <Widget>[
                new IconButton(icon: logout, onPressed: null),
                _verticalD(),
                new Text(
                  'Deactivate Account',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.redAccent,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  addressWidget(Address address) {
    return Card(
        elevation: 3.0,
        margin: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      address.text,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    _verticalDivider(),
                    new Text(
                      address.city != null ? address.city.name + ', ' +
                          address.city.state.name : '',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13.0,
                          letterSpacing: 0.5),
                    ),
                    _verticalDivider(),
                    new Text(
                      address.pin,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13.0,
                          letterSpacing: 0.5),
                    ),
                    new Container(
                      margin: EdgeInsets.only(
                          left: 00.0, top: 05.0, right: 0.0, bottom: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            address.addresstype,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black26,
                            ),
                          ),
                          _verticalD(),

                        ],
                      ),
                    )
                  ],
                )),

            Align(alignment: Alignment.topRight
                ,
                child: address.addresstype != 'registered' ? IconButton(
                    icon: Icon(Icons.edit), onPressed: () {
                  print(address.phone);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          AddUpdateAddressView(addresses: address,)
                  ));
                }) : Container())
          ],
        )
    );
  }

  addressList(AccountViewModel model) {
    return SizedBox(
      height: 140.0,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: model.addresses.length,
        itemBuilder: (BuildContext cont, int ind) {
          return addressWidget(model.addresses[ind]);
        },
      ),
    );
  }

  bankAccountList(AccountViewModel model) {
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext cont, int ind) {
          return bankAccountWidget(model);
        },
      ),
    );
  }

  bankAccountWidget(AccountViewModel model) {
    return Card(
        elevation: 3.0,
        margin: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      'Bank Name',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    _verticalDivider(),
                    new Text(
                      'Bank Address',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13.0,
                          letterSpacing: 0.5),
                    ),
                    new Text(
                      'Pincode',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13.0,
                          letterSpacing: 0.5),
                    ),

                  ],
                )),

          ],
        )
    );
  }
}
