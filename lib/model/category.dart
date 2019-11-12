import 'package:graineasy/model/itemname.dart';

class Category {
  String name;
  String id;
  ItemName itemname;

  Category({this.name,this.id,this.itemname});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['name'],
        id: json['_id'],
        itemname: ItemName.fromJson(json['itemname'])
    );
  }

//  static List<Category> fromJsonArray(  List<dynamic>  json) {
//    List<Category> bannerLists = json.map<Category>((json) => Category.fromJson(json))
//        .toList();
//    return bannerLists;
//  }



}