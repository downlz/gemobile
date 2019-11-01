import 'package:graineasy/model/itemname.dart';

class Category {
  String name;
  String id;
  Itemname itemname;

  Category({this.name,this.id,this.itemname});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['name'],
        id: json['_id'],
        itemname: Itemname.fromJson(json['itemname'])
    );
  }
}