import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/utils/ui_helper.dart';

import 'forgot_password_model.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> with CommonAppBar {
  ShapeBorder shape;
  final forgotPasswordScaffoldKey = GlobalKey<ScaffoldState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  TextEditingController panController=new TextEditingController();
  TextEditingController gstinController=new TextEditingController();
  TextEditingController phoneNumberController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

  var phoneFocus=new FocusNode();
  var passwordFocus=new FocusNode();
  var panFocus=new FocusNode();
  var gstinFocus=new FocusNode();


  @override
  void initState() {
    phoneNumberController.text = '3333333333';
    panController.text = 'BUYER2019K';
    gstinController.text = 'BUYER2019KQWERT';
    passwordController.text = 'gemobile2019';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppResponsive.isTablet(MediaQuery.of(context), context);

    return BaseView<ForgotPasswordModel>(builder: (context, model, child) {
      showMessage(model);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Reset Password'),
          backgroundColor: Colors.white,
        ),
        key: forgotPasswordScaffoldKey,
        backgroundColor: Palette.loginBgColor,

        body: _getBody(model),
      );
    });
  }

  Widget _getBody(ForgotPasswordModel model) {
    return Stack(
      children: <Widget>[
        _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(ForgotPasswordModel model) {
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

  _getBaseContainer(ForgotPasswordModel model)
  {
    return new SingleChildScrollView(
      child: forgotPasswordWidget(model),
    );
  }

  forgotPasswordWidget(ForgotPasswordModel model)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: new Column(
        children: <Widget>[
          Form(
              key: forgotPasswordFormKey,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      UIHelper.verticalSpaceSmall1,
                      TextFormField(
                        controller: phoneNumberController,
                        focusNode: phoneFocus,
                        style: AppWidget.darkWhiteTextFieldTextStyle(),
                        keyboardType: TextInputType.phone,
                        decoration: AppWidget.darkWhiteTextField('PhoneNumber',Icons.call),
                        validator: (value) {
                          return Validation.validateMobile(value);
                        },
                      ),
                      UIHelper.verticalSpaceSmall1,

                      TextFormField(
                          controller: panController,
                          focusNode: panFocus,
                          style: AppWidget.darkWhiteTextFieldTextStyle(),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            return Validation.validatePan(value);
                          },
                          decoration: AppWidget.darkWhiteTextField('Pan Number',Icons.credit_card)
                      ),
                      UIHelper.verticalSpaceSmall1,

                      TextFormField(
                          controller: gstinController,
                          focusNode: gstinFocus,
                          style: AppWidget.darkWhiteTextFieldTextStyle(),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            return Validation.validateGstIn(value);
                          },
                          decoration: AppWidget.darkWhiteTextField('GstNumber',Icons.email)
                      ),
                      UIHelper.verticalSpaceSmall1,

                      TextFormField(
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
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Reset Password',
                          style: AppTextStyle.commonTextStyle(
                              Palette.loginBgColor,
                              AppResponsive.getFontSizeOf(30),
                              FontWeight.bold,
                              FontStyle.normal),
                        ),
                        onPressed: () {
//                          _submit();
                          if (forgotPasswordFormKey.currentState.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            model.resetPswBtnIsClicked(phoneNumberController.text,panController.text,gstinController.text,passwordController.text);
                          }
                        },
                      ),



                    ]
                ),
              )

          )
        ],
      ),
    );
  }
}
