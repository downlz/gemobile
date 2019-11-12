import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/registration/registration_view_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/utils/ui_helper.dart';
import 'package:url_launcher/url_launcher.dart';


class Users {
  const Users(this.name);

  final String name;
}
class RegistrationView extends StatefulWidget {
  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView>  with CommonAppBar {

  ShapeBorder shape;
  final regScaffoldKey = GlobalKey<ScaffoldState>();
  final regFormKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController gstinController = new TextEditingController();
  TextEditingController emailController=new TextEditingController();
  TextEditingController phoneNumberController=new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();

  var phoneFocus=new FocusNode();
  var passwordFocus=new FocusNode();
  var firstNameFocus=new FocusNode();
  var gstinFocus = new FocusNode();
  var emailFocus=new FocusNode();
  var addressFocus = new FocusNode();
  var pincodeFocus = new FocusNode();

  String selectedUser;
  List<Users> users = <Users>[ Users('India')];
  String _value;
  List<States> _region = [];
  List<City> _list = [];
  bool checkboxValue = false;

  States stateUser;
  City cityUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RegistrationViewModel>(builder: (context, model, child) {
      model.init();

      _region = model.stateList;
      _list = model.cityList;
      showMessage(model);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('SignUp'),
          backgroundColor: Colors.white,
        ),
        key: regScaffoldKey,
        backgroundColor: Palette.loginBgColor,

        body: _getBody(model),
      );
    });
  }

  Widget _getBody(RegistrationViewModel model) {
    return Stack(
      children: <Widget>[
        _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(RegistrationViewModel model) {
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

  _getBaseContainer(RegistrationViewModel model)
  {
   return new SingleChildScrollView(
    child: regWidget(model),
    );
  }



  regWidget(RegistrationViewModel model)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: new Column(
        children: <Widget>[
          Form(
              key: regFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                          controller: nameController,
                          focusNode: firstNameFocus,
                          style: AppWidget.darkWhiteTextFieldTextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: AppWidget.whiteTextField('Your Name'),
                          validator: (value) {
                            return Validation.validateName(value);
                          },
                        ),
                        UIHelper.verticalSpaceSmall1,


                        TextFormField(
                            controller: emailController,
                            focusNode: emailFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              return Validation.validateEmail(value);
                            },
                            decoration: AppWidget.whiteTextField('Email')
                        ),
                        UIHelper.verticalSpaceSmall1,

                        TextFormField(
                            controller: phoneNumberController,
                            focusNode: phoneFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return Validation.validateMobile(value);
                            },
                            decoration: AppWidget.whiteTextField('Phone Number')
                        ),
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                          obscureText: true,
                            controller: passwordController,
                            focusNode: passwordFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validation.validatePassword(value);
                            },
                            decoration: AppWidget.whiteTextField('Password')
                        ),

                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                            controller: gstinController,
                            focusNode: gstinFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validation.validateGstInNumber(value);
                            },
                            decoration: AppWidget.whiteTextField('GSTIN Number')
                        ),

                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                            controller: addressController,
                            focusNode: addressFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            validator: (value) {
                              return Validation.validateAddress(value);
                            },
                            decoration: AppWidget.whiteTextField('Address')
                        ),
                        UIHelper.verticalSpaceSmall1,


                        Theme(data: Theme.of(context).copyWith(
                            canvasColor: Palette.blackTextColor),
                          child: DropdownButton<States>(
                            underline: Container(decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))
                            ),),
                            isExpanded: true,
                            elevation: 4,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            hint: new Text("Select State",
                              style: AppTextStyle.getLargeHeading(false,
                                  Colors.white24),),
                            value: stateUser,
                            onChanged: (States newValue) {
                              setState(() {
                                stateUser = newValue;
                              });
                            },
                            items: _region.map((States user) {
                              return new DropdownMenuItem<States>(
                                value: user,
                                child: new Text(
                                  user.name,
                                  style: new TextStyle(
                                      color: Palette.whiteTextColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        UIHelper.verticalSpaceSmall1,
                        Theme(data: Theme.of(context).copyWith(
                            canvasColor: Palette.blackTextColor),
                          child: DropdownButton<City>(
                            underline: Container(decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))
                            ),),
                            isExpanded: true,
                            elevation: 4,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            hint: new Text("Select City",
                              style: AppTextStyle.getLargeHeading(false,
                                  Colors.white24),),
                            value: cityUser,
                            onChanged: (City newValue) {
                              setState(() {
                                cityUser = newValue;
                              });
                            },
                            items: _list.map((City user) {
                              return new DropdownMenuItem<City>(
                                value: user,
                                child: new Text(
                                  user.name,
                                  style: new TextStyle(
                                      color: Palette.whiteTextColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        UIHelper.verticalSpaceSmall1,

                        TextFormField(
                            controller: pincodeController,
                            focusNode: pincodeFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return Validation.validatePin(value);
                            },
                            decoration: AppWidget.whiteTextField('Pincode')
                        ),
                        UIHelper.verticalSpaceSmall1,


                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Checkbox(activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: checkboxValue,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxValue = value;
                                });
                              },
                            ),
                            new Text(
                              'I agree to the ',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Palette.whiteTextColor,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            InkWell(
                              child: new Text(
                                'Terms and Condition',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              onTap: () {
                                _launchURL();
                              },
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall1,


                        RaisedButton(
                          color: Palette.whiteTextColor,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'Sign Up',
                            style: AppTextStyle.commonTextStyle(
                                Palette.loginBgColor,
                                AppResponsive.getFontSizeOf(30),
                                FontWeight.bold,
                                FontStyle.normal),
                          ),
                          onPressed: () {
//                          _submit();
                            if (regFormKey.currentState.validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());
//                            model.registerBtnIsClicked(nameController.text,emailController.text,phoneNumberController.text,passwordController.text,gstinController.text,addressController.text,cityUser.toString(),stateUser.toString(),pincodeController.toString());
                            }
                          },
                        ),
                        UIHelper.verticalSpaceSmall1,


                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Already have an account? ',
                                style: AppTextStyle.commonTextStyle(
                                    Palette.whiteTextColor,
                                    AppResponsive.getFontSizeOf(25),
                                    FontWeight.w500,
                                    FontStyle.normal),
                              ),

                              Text('Login ',
                                style: AppTextStyle.commonTextStyle(
                                    Palette.whiteTextColor,
                                    AppResponsive.getFontSizeOf(25),
                                    FontWeight.bold,
                                    FontStyle.normal),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),

                        UIHelper.verticalSpaceMedium,


                      ]
                  ),
                ),
              )

          )
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://graineasy.com/termsofuse';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
