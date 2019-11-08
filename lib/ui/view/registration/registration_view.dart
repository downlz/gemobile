import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/view/registration/registration_view_model.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/utils/ui_helper.dart';

//class Signup_Screen extends StatefulWidget {
//
//
//  final Key fieldKey;
//  final String hintText;
//  final String labelText;
//  final String helperText;
//  final FormFieldSetter<String> onSaved;
//  final FormFieldValidator<String> validator;
//  final ValueChanged<String> onFieldSubmitted;
//
//  const Signup_Screen({Key key, this.fieldKey, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted}) : super(key: key);
//
//  ThemeData buildTheme() {
//    final ThemeData base = ThemeData();
//    return base.copyWith(
//      hintColor: Colors.red,
//      inputDecorationTheme: InputDecorationTheme(
//        labelStyle: TextStyle(
//            color: Colors.yellow,
//            fontSize: 24.0
//        ),
//      ),
//    );
//  }
//  @override
//  State<StatefulWidget> createState() => signup();
//}
//
//class signup extends State<Signup_Screen> {
//
//  ShapeBorder shape;
//  final regScaffoldKey = GlobalKey<ScaffoldState>();
//  final regFormKey = GlobalKey<FormState>();
//
//  String _email;
//  String _password;
//  String _firstname;
//  String _lastname;
//  String _phone;
//  TextEditingController firstNameController=new TextEditingController();
//  TextEditingController lastNameController=new TextEditingController();
//  TextEditingController emailController=new TextEditingController();
//  TextEditingController phoneNumberController=new TextEditingController();
//  TextEditingController passwordController=new TextEditingController();
//
//  var phoneFocus=new FocusNode();
//  var passwordFocus=new FocusNode();
//  var firstNameFocus=new FocusNode();
//  var lastNameFocus=new FocusNode();
//  var emailFocus=new FocusNode();
//  bool _autovalidate = false;
//  bool _formWasEdited = false;
//
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    bool _obscureText = true;
//    return new Scaffold(
//        key: regScaffoldKey,
//        backgroundColor: Palette.loginBgColor,
//        appBar: new AppBar(
//          title: Text('Signup'),
//          backgroundColor: Colors.white,
//        ),
//        body: SafeArea(
//            child: new SingleChildScrollView(
//              child: regWidget(),
//            )
//        ));
//  }
//
//
//  void _submit() {
//    final form = regFormKey.currentState;
//
//    if (form.validate()) {
//      FocusScope.of(context).requestFocus(FocusNode());
//      form.save();
//      _performLogin();
//    }
//    else{
//      showInSnackBar('Please fix the errors in red before submitting.');
//
//    }
//  }
//
//  void showInSnackBar(String value) {
//    regScaffoldKey.currentState.showSnackBar(SnackBar(
//        content: Text(value)
//    ));
//  }
//  void _performLogin() {
//   Navigator.pushNamedAndRemoveUntil(context,'/HomeScreen',(Route<dynamic> route) => false);
//
//  }
//
//
//  regWidget()
//  {
//    return Padding(
//      padding: const EdgeInsets.only(left: 10,right: 10),
//      child: new Column(
//        children: <Widget>[
//          Form(
//              key: regFormKey,
//              autovalidate: _autovalidate,
//              child: SingleChildScrollView(
//                child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: <Widget>[
//                      UIHelper.verticalSpaceSmall1,
//                      TextFormField(
//                        controller: firstNameController,
//                        focusNode: firstNameFocus,
//                        style: AppWidget.darkWhiteTextFieldTextStyle(),
//                        keyboardType: TextInputType.text,
//                        decoration: AppWidget.darkWhiteTextField('FirstName',Icons.person),
//                        validator: (value) {
//                          return Validation.validateName(value);
//                        },
//                      ),
//                      UIHelper.verticalSpaceSmall1,
//
//                      TextFormField(
//                          controller: lastNameController,
//                          focusNode: lastNameFocus,
//                          style: AppWidget.darkWhiteTextFieldTextStyle(),
//                          keyboardType: TextInputType.text,
//                          validator: (value) {
//                            return Validation.validateName(value);
//                          },
//                          decoration: AppWidget.darkWhiteTextField('LastName',Icons.person_outline)
//                      ),
//                      UIHelper.verticalSpaceSmall1,
//
//                      TextFormField(
//                          controller: emailController,
//                          focusNode: emailFocus,
//                          style: AppWidget.darkWhiteTextFieldTextStyle(),
//                          keyboardType: TextInputType.emailAddress,
//                          validator: (value) {
//                            return Validation.validateEmail(value);
//                          },
//                          decoration: AppWidget.darkWhiteTextField('Email',Icons.email)
//                      ),
//                      UIHelper.verticalSpaceSmall1,
//
//                      TextFormField(
//                          controller: phoneNumberController,
//                          focusNode: phoneFocus,
//                          style: AppWidget.darkWhiteTextFieldTextStyle(),
//                          keyboardType: TextInputType.number,
//                          validator: (value) {
//                            return Validation.validateMobile(value);
//                          },
//                          decoration: AppWidget.darkWhiteTextField('Phone Number',Icons.mobile_screen_share)
//                      ),
//                      UIHelper.verticalSpaceSmall1,
//
//                      TextFormField(
//                        obscureText: true,
//                          controller: passwordController,
//                          focusNode: passwordFocus,
//                          style: AppWidget.darkWhiteTextFieldTextStyle(),
//                          keyboardType: TextInputType.text,
//                          validator: (value) {
//                            return Validation.validatePassword(value);
//                          },
//                          decoration: AppWidget.darkWhiteTextField('Password',Icons.lock)
//                      ),
//                      UIHelper.verticalSpaceLarge,
//
//
//                      RaisedButton(
//                        color:Palette.whiteTextColor,
//                        padding: EdgeInsets.symmetric(vertical: 12),
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(20)),
//                        child: Text(
//                          'Register',
//                          style: AppTextStyle.commonTextStyle(
//                              Palette.loginBgColor,
//                              AppResponsive.getFontSizeOf(30),
//                              FontWeight.bold,
//                              FontStyle.normal),
//                        ),
//                        onPressed: () {
//                          _submit();
//                        },
//                      ),
//                      UIHelper.verticalSpaceSmall1,
//
//                      GestureDetector(
//                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Text(
//                              'Already have an account? ',
//                              style: AppTextStyle.commonTextStyle(
//                                  Palette.whiteTextColor,
//                                  AppResponsive.getFontSizeOf(25),
//                                  FontWeight.w500,
//                                  FontStyle.normal),
//                            ),
//
//                            Text('Login ',
//                              style: AppTextStyle.commonTextStyle(
//                                  Palette.whiteTextColor,
//                                  AppResponsive.getFontSizeOf(25),
//                                  FontWeight.bold,
//                                  FontStyle.normal),
//                            ),
//                          ],
//                        ),
//                        onTap: (){
//                          Navigator.pushNamed(context, '/LoginScreen');
//                        },
//                      ),
//
//                      UIHelper.verticalSpaceMedium,
//
//
//                    ]
//                ),
//              )
//
//          )
//        ],
//      ),
//    );
//  }
//
//}

class RegistrationView extends StatefulWidget {
  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView>  with CommonAppBar {

  ShapeBorder shape;
  final regScaffoldKey = GlobalKey<ScaffoldState>();
  final regFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController=new TextEditingController();
  TextEditingController lastNameController=new TextEditingController();
  TextEditingController emailController=new TextEditingController();
  TextEditingController phoneNumberController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

  var phoneFocus=new FocusNode();
  var passwordFocus=new FocusNode();
  var firstNameFocus=new FocusNode();
  var lastNameFocus=new FocusNode();
  var emailFocus=new FocusNode();
  bool _autovalidate = false;
  bool _formWasEdited = false;
  @override
  Widget build(BuildContext context) {
    AppResponsive.isTablet(MediaQuery.of(context), context);

    return BaseView<RegistrationViewModel>(builder: (context, model, child) {
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      UIHelper.verticalSpaceSmall1,
                      TextFormField(
                        controller: firstNameController,
                        focusNode: firstNameFocus,
                        style: AppWidget.darkWhiteTextFieldTextStyle(),
                        keyboardType: TextInputType.text,
                        decoration: AppWidget.darkWhiteTextField('FirstName',Icons.person),
                        validator: (value) {
                          return Validation.validateName(value);
                        },
                      ),
                      UIHelper.verticalSpaceSmall1,

                      TextFormField(
                          controller: lastNameController,
                          focusNode: lastNameFocus,
                          style: AppWidget.darkWhiteTextFieldTextStyle(),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            return Validation.validateName(value);
                          },
                          decoration: AppWidget.darkWhiteTextField('LastName',Icons.person_outline)
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
                          decoration: AppWidget.darkWhiteTextField('Email',Icons.email)
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
                          decoration: AppWidget.darkWhiteTextField('Phone Number',Icons.mobile_screen_share)
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
                          decoration: AppWidget.darkWhiteTextField('Password',Icons.lock)
                      ),
                      UIHelper.verticalSpaceLarge,


                      RaisedButton(
                        color:Palette.whiteTextColor,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Register',
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
//                            model.registerBtnIsClicked(firstNameController.text,lastNameController.text,emailController.text,phoneNumberController.text,passwordController.text);
                          }
                        },
                      ),
                      UIHelper.verticalSpaceSmall1,

                      GestureDetector(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
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
                        onTap: (){
                          Navigator.pushNamed(context, Screen.Login.toString());
                        },
                      ),

                      UIHelper.verticalSpaceMedium,


                    ]
                ),
              )

          )
        ],
      ),
    );
  }

}
