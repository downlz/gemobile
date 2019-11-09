import 'dart:convert';

import 'package:graineasy/manager/base/base_repository.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/Item.dart';
import 'api_config/api_config.dart';
import 'package:http/http.dart' as http;


class API extends BaseRepository
{
  static Future<List<ItemName>> getItemName()async{

    var response = await http.get(ApiConfig.getCategoryName,
        headers:  await ApiConfig.getHeaderWithToken());
    print(response.body);
    if (response.statusCode == ApiConfig.successStatusCode) {
      List<ItemName> items = ItemName.fromJsonArray(jsonDecode(response.body));
      return items;
    }
    return[];
  }

  static Future<List<Item>> getCategoryFromItemName(String itemName)async{
    print('Item name ==> ${itemName}');
    var response = await http.get(ApiConfig.getCategoryNameByItemName+itemName,
        headers:  await ApiConfig.getHeaderWithToken());

    if (response.statusCode == ApiConfig.successStatusCode) {
      List<Item> items = Item.fromJsonArray(jsonDecode(response.body));
      return items;
    }
    return[];
  }

  static Future<List<Item>> getItemFromId(String itemId)async{
    var response = await http.get(ApiConfig.getItemDetails+itemId,
        headers:  await ApiConfig.getHeaderWithToken());
    print('respo==>  ${response.body}');
//    if (response.statusCode == ApiConfig.successStatusCode) {
//      List<Item> items = Item.fromJsonArray(jsonDecode(response.body));
//      return items;
//    }
    return[];
  }



}