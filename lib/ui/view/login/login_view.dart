import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/utils/ui_helper.dart';

import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with CommonAppBar {
  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController phoneController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

  var phoneFocus=new FocusNode();
  var passwordFocus=new FocusNode();
  bool _formWasEdited = false;

  void initState() {
    phoneController.text = '';
    passwordController.text = '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppResponsive.isTablet(MediaQuery.of(context), context);

    return BaseView<LoginViewModel>(builder: (context, model, child) {
      showMessage(model);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Login'),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Palette.loginBgColor,
        key: scaffoldKey,
        body: _getBody(model),
      );
    });
  }



  Widget _getBody(LoginViewModel model) {
    return Stack(
      children: <Widget>[
        _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(LoginViewModel model) {
    try {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (model.shouldShowMessage) {
          model.messageIsShown();
          if (!model.isError && model.context != null) {
            showErrorMessage(context, model.message,
                model.isError);         // Smart handle based on system performance by Shahnawaz 22 Dec 2019
          }
        }
      });
    } catch (e) {
      print(e);
    }

  }

  _getBaseContainer(LoginViewModel model)
  {

    return  Center(
      child: SingleChildScrollView(
        child: Card(
            margin: EdgeInsets.all(AppResponsive.getSizeOfHeight(20)),
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Form(
                key: loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        UIHelper.verticalSpaceMedium,

                        Text(
                          'Login',textAlign: TextAlign.center,
                          style: AppTextStyle.commonTextStyle(
                              Palette.loginBgColor,
                              AppResponsive.getFontSizeOf(37),
                              FontWeight.bold,
                              FontStyle.normal),
                        ),
                        UIHelper.verticalSpaceSmall1,

                        TextFormField(
                          validator: (value) {
                            return Validation.validateEmptyPhone(value);
                          },
                          focusNode: phoneFocus,
                          controller: phoneController,
                          style: AppWidget.darkTextFieldTextStyle(),
                          keyboardType: TextInputType.number,
                          decoration: AppWidget.darkTextField('Phone Number'),
                        ),
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                          validator: (value) {
                            return Validation.validateEmptyPassword(value);
                          },
                          focusNode: passwordFocus,
                          controller: passwordController,
                          style: AppWidget.darkTextFieldTextStyle(),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: AppWidget.darkTextField('Password'),
                        ),
                        UIHelper.verticalSpaceSmall1,
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButton<String>(
                            underline: Container(
                              decoration: BoxDecoration(
                                  border:
                                  Border(bottom: BorderSide(
                                      color: Palette.assetColor))),
                            ),
                            isExpanded: true,
                            elevation: 4,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Palette.assetColor,
                            ),
                            hint: new Text('Default',
                              style: AppTextStyle.getLargeHeading(
                                  false, Palette.assetColor),
                            ),
                            value: model.selectedChooseRole,
                            onChanged: (String selectedChooseRole) {
                              setState(() {
                                model.selectedChooseRole = selectedChooseRole;
                              });
                            },
                            items: API.chooseRole.map((String role) {
                              return new DropdownMenuItem<String>(
                                value: role,
                                child: new Text(
                                  role,
                                  style: TextStyle(color: Palette.assetColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        UIHelper.verticalSpaceSmall1,

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child:
                                Text('Forgot Password?',
                                    style: AppWidget.latLongText()),),
                              onTap: (){
                                Navigator.pushNamed(context, Screen.ForgotPassword.toString());
                              },
                            ),
                            UIHelper.verticalSpaceSmall1,
                            RaisedButton(
                              color:Palette.loginBgColor,
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Login',
                                style: AppTextStyle.commonTextStyle(
                                    Palette.whiteTextColor,
                                    AppResponsive.getFontSizeOf(30),
                                    FontWeight.bold,
                                    FontStyle.normal),
                              ),
                              onPressed: () {
//                                _submit();

                                if (loginFormKey.currentState.validate()) {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  model.loginBtnIsClicked(phoneController.text, passwordController.text);
                                }
                              },
                            ),
                          ],
                        ),

                        UIHelper.verticalSpaceSmall1,

                        GestureDetector(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Don\'t have an account?',
                                style: AppTextStyle.commonTextStyle(
                                    Palette.loginBgColor,
                                    AppResponsive.getFontSizeOf(24),
                                    FontWeight.w500,
                                    FontStyle.normal),
                              ),

                              Text('Create new account',
                                style: AppTextStyle.commonTextStyle(
                                    Palette.loginBgColor,
                                    AppResponsive.getFontSizeOf(24),
                                    FontWeight.bold,
                                    FontStyle.normal),
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.pushNamed(context, Screen.Registration.toString());
                          },
                        ),

                        UIHelper.verticalSpaceMedium,

                      ]
                  ),
                )

            )        //login,
        ),
      ),
    );
  }
}
