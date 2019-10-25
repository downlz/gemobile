import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:graineasy/model/Address_model.dart';
import 'package:http/http.dart' as http;

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class itemService {

//  static Future<http.Response> userPhoto(var authToken) async{
//
//    Map<dynamic,dynamic> header={"Authorization":"$authToken"};
//    var url='http://127.0.0.1:3000/api/item/all';
//    var response=await http.get(url,
//        headers: header
//    );
//    return response;
//  }

  Future<Stream<Items>> getItems() async {
    final String url = 'http://127.0.0.1:3000/api/item/all';

    final client = new http.Client();
    final streamedRest = await client.send(
        http.Request('get', Uri.parse(url))
    );

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((data) => (data as List))
        .map((data) => Items.fromJSON(data));
  }

}