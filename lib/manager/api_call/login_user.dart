import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';

import 'package:graineasy/helpers/saveCurrentLogin.dart';
import 'package:graineasy/manager/api_call/api_config/api_config.dart';
import 'package:graineasy/manager/repository/login_repository.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/user.dart';
import 'package:http/http.dart' as http;

class LoginUser extends LoginRepository {
  @override
  Future<String> loginUser(String phone, String password) async {
    var data = {'phone': '+91'+phone,'password':password};

    var response = await http.post(ApiConfig.login,
        headers:  await ApiConfig.getHeader(),
        body: convert.jsonEncode(data));
    if (response.statusCode == ApiConfig.successStatusCode) {
      print(response.body);
      Map<dynamic,dynamic>  responseBody = jsonDecode(response.body);
      saveCurrentLogin(responseBody);
      User user = User.fromJson(responseBody);
      UserPreferences.saveUserDetails(user);
      return 'Welcome back, ${responseBody['name']}';
    } else {
      throw throw getErrorBasedOnStatusCode(response.statusCode);
    }
  }


}
