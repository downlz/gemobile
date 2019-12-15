import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/category.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/item.dart';
import 'package:graineasy/model/manufacturer.dart';
import 'package:graineasy/model/unit.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class MostOrderedItem {
  final String id;
  final Item name;
//  final String image;
//  final String price;
//  final String origin;

  MostOrderedItem({
    this.id,
    this.name,
//    this.image,
//    this.price,
//    this.origin,
  });

  factory MostOrderedItem.fromJson(Map<String, dynamic> json) {
    return MostOrderedItem(
      id: json['_id'],
      name: Item.fromJson(json['item']),
//        image: Item.fromJson(json['item']['image']),
//        price: Item.fromJson(json['item']),
//      origin: Item.fromJson(json['item']),
    );
  }

  static List<MostOrderedItem> fromJsonArray(List<dynamic> json) {
    List<MostOrderedItem> bannerLists = json
        .map<MostOrderedItem>((json) => MostOrderedItem.fromJson(json))
        .toList();
    return bannerLists;
  }
}

//class Specs {
//  String moisture;
//  String graincount;
//  String icumsa;
//
//  Specs({this.moisture, this.graincount, this.icumsa});
//
//  Specs.fromJson(Map<String, dynamic> json)
//      : this.moisture = json["moisture"],
//        this.graincount = json["graincount"],
//        this.icumsa = json["icumsa"];
//}

//class Address {
//
//  final String city;
//  final String pin;
//
//  Address({this.city,
//    this.pin});
//
//  factory Address.fromJson(Map<String, dynamic> json) {
//    return new Address(
//        city: json['sampleNo'],
//        pin: json['origin']
//    );
//  }
//
