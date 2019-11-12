import 'package:flutter/material.dart';
import 'package:graineasy/HomeScreen.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/listeners/login_listener.dart';
import 'package:graineasy/ui/localization/app_localization.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/utils/check_internet/utility.dart';

class LoginViewModel extends BaseModel implements LoginListener
{
  String phone, password;

  @override
  void errorObtained(String error, int errorCode, String methodName) {
    showMessage(error, isError);
    setState(ViewState.Idle);
  }

  @override
  void goToLogin(String result) {
    setState(ViewState.Idle);
    showMessage(result, isError);
    Navigator.pushNamedAndRemoveUntil(
        context, Screen.Home_screen.toString(), (Route<dynamic> route) => false);
  }

  void loginBtnIsClicked(String phones, String passwords) {
    phone = phones;
    password = passwords;
    sendDataToServer(phones, passwords);
  }

  void sendDataToServer(String phone, String password) {
    Utility.isInternetAvailable().then((isConnected) async {
      if (isConnected) {
        setState(ViewState.Busy);
        LoginDataManager loginDataManager = LoginDataManager();
        loginDataManager.listener = this;
        loginDataManager.login(phone, password);
      } else {
        showMessage(AppLocalizations.of(context).noInternet, true);
      }
    });
  }

}