import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/helpers/saveCurrentLogin.dart';
import 'package:graineasy/manager/api_call/api_config/api_config.dart';
import 'package:graineasy/manager/repository/login_repository.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/model/app_pref.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';


class LoginUser extends LoginRepository {
  @override
  Future<String> loginUser(String phone, String password) async {
    var data = {'phone': '+91' + phone, 'password': password};
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    var response = await http.post(ApiConfig.login,
        headers: await ApiConfig.getHeader(),
        body: convert.jsonEncode(data));
    if (response.statusCode == ApiConfig.successStatusCode) {
      Map<dynamic, dynamic> responseBody = jsonDecode(response.body);
      saveCurrentLogin(responseBody);
      AppPref currAppPref = await API.getAppPref(version);
      User user = User.fromJson(responseBody);
      if (user.isActive && !user.isTransporter
          && !currAppPref.appupdaterequired ) {
        UserPreferences.saveUserDetails(user);
      } else if (!user.isActive) {
        String activationstatus = 'activation';
        throw throw getErrorBasedOnAppDataSetup(activationstatus);
      } else if (user.isTransporter) {
        String usertype = 'transporter';
        throw throw getErrorBasedOnAppDataSetup(usertype);
      }
      else if (currAppPref.appupdaterequired) {
        String appupdate = 'updatereq';
        throw throw getErrorBasedOnAppDataSetup(appupdate);
      } else {
        print('Do Nothing');
      }
    } else if (response.statusCode == 400 && (response.body == '"password" length must be at least 8 characters long'
    || response.body == 'Invalid email or password.')) {
      String appPassword = 'incorrectpass';
      throw throw getErrorBasedOnAppDataSetup(appPassword);
    } else if (response.statusCode == 400 && (response.body == '"phone" length must be 13 characters long')) {
      String appUser = 'incorrectuser';
      throw throw getErrorBasedOnAppDataSetup(appUser);
    }
      else {
        throw throw getErrorBasedOnStatusCode(response.statusCode);
      }
  }
}
