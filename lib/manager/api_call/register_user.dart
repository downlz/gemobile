import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';

import 'package:graineasy/helpers/saveCurrentLogin.dart';
import 'package:graineasy/login_page.dart';
import 'package:graineasy/manager/api_call/api_config/api_config.dart';
import 'package:graineasy/manager/repository/login_repository.dart';
import 'package:graineasy/manager/repository/register_repository.dart';
import 'package:http/http.dart' as http;

class RegisterUser extends RegistrationRepository {
//  @override
//  Future<String> loginUser(String phone, String password) async {
//    var data = {'phone': '+91'+p hone,'password':password};
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
  Future<String> registerUser(String firstName, String lastName, String email, String phoneNumber, String password) async {
      var data = {'firstname':firstName, 'lastname': lastName,'email':email,'mobile':phoneNumber,'password':password};

      var response = await http.post(ApiConfig.login,
          headers: {"Content-Type": "application/json"},
          body: convert.jsonEncode(data));
      if (response.statusCode == ApiConfig.successStatusCode) {
        print(response.body);
        Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
        saveCurrentLogin(responseBody);
        return 'Welcome back, ${responseBody['name']}';
      } else {
        throw throw getErrorBasedOnStatusCode(response.statusCode);
      }
  }


}
