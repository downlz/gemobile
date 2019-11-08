import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';

import 'package:graineasy/helpers/saveCurrentLogin.dart';
import 'package:graineasy/login_page.dart';
import 'package:graineasy/manager/api_call/api_config/api_config.dart';
import 'package:graineasy/manager/repository/forgot_password_repository.dart';
import 'package:graineasy/manager/repository/login_repository.dart';
import 'package:http/http.dart' as http;

class UserForgotPassword extends ForgotPasswordRepository {
//  @override
//  Future<String> loginUser(String phone, String password) async {
//    var data = {'phone': '+91'+phone,'password':password};
//
//    var response = await http.post(ApiConfig.login,
//        headers:  {"Content-Type": "application/json"},
//        body: convert.jsonEncode(data));
//    if (response.statusCode == ApiConfig.successStatusCode) {
//      print(response.body);
//      Map<dynamic,dynamic>  responseBody = jsonDecode(response.body);
//      saveCurrentLogin(responseBody);
//      return 'Welcome back, ${responseBody['name']}';
//    } else {
//      throw throw getErrorBasedOnStatusCode(response.statusCode);
//    }
//  }

  @override
  Future<String> forgotPassword(String phone, String pan, String gstin, String password) async {
    // TODO: implement forgotPassword
    var data = {'phone': '+91'+phone,'pan':pan,'gstin':gstin,'password':password};

    var response = await http.post(ApiConfig.forgotPassword,
        headers:  {"Content-Type": "application/json"},
        body: convert.jsonEncode(data));
    if (response.statusCode == ApiConfig.successStatusCode) {
      print(response.body);
      Map<dynamic,dynamic>  responseBody = jsonDecode(response.body);
//      saveCurrentLogin(responseBody);
      return 'Reset Password';
    } else {
      throw throw getErrorBasedOnStatusCode(response.statusCode);
    }
  }


}
