import 'package:flutter/material.dart';
import 'package:graineasy/exception/data_exception.dart';
import 'package:graineasy/manager/api_call/login_user.dart';

abstract class LoginListener {
  // result of API
  void goToLogin(String result);
  void errorObtained(String error, int errorCode, String methodName);
}

class LoginDataManager {
  LoginListener listener;
  static const String LOGIN = "LOGIN";

  void login(String phone, String password) async {
    LoginUser user = LoginUser();
    user.loginUser(phone, password).then((users) {
      // TODO change logic
      if (user != null) {
        listener.goToLogin(users);
      } else {
        listener.errorObtained('Invalid data', 202, LOGIN);
      }
    }).catchError((onError) {
      int errorCode = DataException.errorUnknown;
      if (onError is DataException) {
        var dataException = onError;
        errorCode = dataException.getErrorCode();
      }
      String error = onError.toString();
      print('error=============>' + error);

      if (listener != null) {
        listener.errorObtained(error, errorCode, LOGIN);
      }
    });
  }


}
