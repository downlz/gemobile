import 'package:graineasy/HomeScreen.dart';
import 'package:graineasy/signup_screen.dart';
import 'package:graineasy/item_details.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/item_screen.dart';
import 'package:graineasy/services/login.dart';
import 'package:graineasy/helpers/saveCurrentLogin.dart';
import 'package:graineasy/helpers/showDialogSingleButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

const URL = "https://graineasy.com";

class Login_Screen extends StatefulWidget {

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const Login_Screen({Key key, this.fieldKey, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted}) : super(key: key);

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: Colors.yellow,
            fontSize: 24.0
        ),
      ),
    );
  }
  @override
  State<StatefulWidget> createState() => login();
}

class login extends State<Login_Screen> {

  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  bool _formWasEdited = false;

  Future launchURL(String url) async {
    if(await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      showDialogSingleButton(context, "Unable to reach your website.", "Currently unable to reach the website $URL. Please try again at a later time.", "OK");
    }
  }

  @override
  void initState() {
    super.initState();
    _saveCurrentRoute("/LoginScreen");
  }

  _saveCurrentRoute(String lastRoute) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('LastScreenRoute', lastRoute);
  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _obscureText = true;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: Text('Login'),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
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
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => Item_Details()));
                        },
                        child: new Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      _verticalD(),
                      new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup_Screen()));
                        },
                        child: new Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                new SafeArea(

                    top: false,
                    bottom: false,
                    child: Card(
                        elevation: 5.0,
                        child: Form(
                            key: formKey,
                            autovalidate: _autovalidate,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.email,color: Colors.black38,),
                                          hintText: 'Your phone no',
                                          labelText: 'Phone',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (val) =>
//                                      !val.contains('@') ? 'Not a valid email.' : null,
                                      val.length < 9 ? 'Not a valid phone no.' : null,
                                      onSaved: (val) => _email = val,
                                    ),

                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.lock,color: Colors.black38,),
                                          hintText: 'Your password',
                                          labelText: 'Password',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),

                                      validator: (val) =>
                                      val.length < 6 ? 'Password too short.' : null,
                                      onSaved: (val) => _password = val,
                                    ),

                                    SizedBox(height: 35.0,),
                                    new Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          new Container(
                                            alignment: Alignment.bottomLeft,
                                            margin: EdgeInsets.only(left: 10.0),
                                            child: new GestureDetector(
                                              onTap: (){

                                              },
                                              child: Text('FORGOT PASSWORD?',style: TextStyle(
                                                  color: Colors.blueAccent,fontSize: 13.0
                                              ),),
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.bottomRight,
                                            child: new GestureDetector(
                                              onTap: (){
                                                _submit();
                                              },
                                              child: Text('LOGIN',style: TextStyle(
                                                  color: Colors.orange,fontSize: 20.0,fontWeight: FontWeight.bold
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /*   const SizedBox(height:24.0),

                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('FORGOT PASSWORD?',style: TextStyle(
                                    color: Colors.blueAccent,fontSize: 13.0
                                  ),),
                                ),

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.orange,fontSize: 15.0
                                  ),),
                                ),

                              ],
                            )


*/
                                  ]
                              ),
                            )

                        )        //login,
                    ))
              ],
            ),
          )
        ));
  }

  void _submit() async{
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      // Email & password matched our validation rules
      // and are saved to _email and _password fields.

      Map<dynamic,dynamic> data;
      data = {'phone': '+91'+_email,'password':_password};

      var response=await LoginService.userLogin(data);
      //print(val);
      if(response.statusCode==200){
//        print(response.body);
        var decodeResponse=jsonDecode(response.body);
        saveCurrentLogin(decodeResponse);
        _performLogin();

//        storage.setItem('GEUser', decodeResponse);
      }
      else{
        print(response.body);
        showDialogSingleButton(context, "Unable to Login", "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.", "OK");
      }

//      _performLogin();
    }
    else{
      showInSnackBar('Please fix the errors in red before submitting.');
    }
  }


  void _logout() async{
    var response=await LoginService.userLogout();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_Screen()));
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }
  void _performLogin() {
    // This is just a demo, so no actual login here.
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen()));
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  }
