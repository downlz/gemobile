import 'dart:convert' as convert;
import 'dart:io';
import 'package:graineasy/helpers/saveCurrentLogin.dart';
import 'package:graineasy/helpers/getToken.dart';
import 'package:graineasy/helpers/saveLogout.dart';
import 'package:graineasy/helpers/showDialogSingleButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginService{

  static Future<http.Response> userLogin(Map<dynamic,dynamic> data) async{
//    print(data);
    //   print(convert.jsonEncode(data));
    var body=convert.jsonEncode(data);

//    print(body);
//    Map<String, String> headers = {"Content-type": "application/json"};
    var url='http://192.168.0.105:3000/api/auth';
    var response= await http.post(url,
        headers: {"Content-Type":"application/json"},
        body: body
    );
    return response;
  }

  static Future<http.Response> getItems() async{

//    Map<String,String> header={"Authorization":"$authToken"};
    var url='http://192.168.0.105:3000/api/item';
    var response=await http.get(url
//        headers: {"Accept":"application/json"}
    );
    return response;
  }

  static Future<http.Response> userOrder(var authToken) async{

    Map<String,String> header={"Authorization":"$authToken"};
    var url='http://192.168.0.105:3000/api/order';
    var response=await http.get(url,
        headers: header
    );
    return response;
  }

  static Future<http.Response> userLogout() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();

    await saveLogout();
//    Future<bool> remove(String token) => _setValue(null, token, null);
  }
}