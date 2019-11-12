import 'dart:convert' as convert;
import 'dart:io';
import 'package:graineasy/helpers/saveCurrentLogin.dart';
import 'package:graineasy/helpers/getToken.dart';
import 'package:graineasy/helpers/saveLogout.dart';
import 'package:graineasy/helpers/showDialogSingleButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/album.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class LoginService{
  static const String url = "https://jsonplaceholder.typicode.com/photos";
  static Future<http.Response> userLogin(Map<dynamic,dynamic> data) async{
//    print(data);
    //   print(convert.jsonEncode(data));
    var body=convert.jsonEncode(data);

//    print(body);
//    Map<String, String> headers = {"Content-type": "application/json"};
    var url='http://3.16.57.93:3000/api/auth';
    var response= await http.post(url,
        headers: {"Content-Type":"application/json"},
        body: body
    );
    print(response.body);
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

  Future parseJSON() async{
    String jsonString = await _loadItemAsset();
    final jsonResponse = convert.jsonDecode(jsonString);
    Item item = new Item.fromJson(jsonResponse);
    return item;
  }

  Future<String> _loadItemAsset() async {
    return await rootBundle.loadString('assets/items.json');
  }

  static Future<List<Album>> getPhotos() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Album> list = parsePhotos(response.body);
        print(list);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Album> parsePhotos(String responseBody) {
    final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }


}