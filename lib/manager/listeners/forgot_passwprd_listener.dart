import 'package:flutter/material.dart';
import 'package:graineasy/exception/data_exception.dart';
import 'package:graineasy/manager/api_call/login_user.dart';
import 'package:graineasy/manager/api_call/user_forgot_password.dart';

abstract class ForgotPasswordListener {
  // result of API
  void goToLogin(String result);
  void errorObtained(String error, int errorCode, String methodName);
}

class ForgotPasswordManager {
  ForgotPasswordListener listener;
  static const String LOGIN = "LOGIN";

  void forgotPassword(String phone,String pan,String gstin, String password) async {
    UserForgotPassword user = UserForgotPassword();
    user.forgotPassword(phone, pan, gstin, password).then((users) {
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
      String error = onError.toString() + ' Invalid Credentials, Please check the details provided';
//      print('error=============>' + error);

      if (listener != null) {
        listener.errorObtained(error, errorCode, LOGIN);
      }
    });
  }


}
