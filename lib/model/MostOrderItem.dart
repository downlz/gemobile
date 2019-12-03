import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/category.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/manufacturer.dart';
import 'package:graineasy/model/unit.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class MostOrderItem {
  final String mostOrderId;
  final String name;
  final String id;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final Category category;
  final ItemName itemname;
  final String image;
  final int qty;
  final int bargaintrgqty;
  final bool bargainenabled;
  final Unit unit;
  final int price;
  final String sampleNo;
  final City city;
  final String origin;
  final bool isLive;
  final bool isTaxable;
  final Manufacturer manufacturer;
  final UserModel addedBy;
  final UserModel seller;
  final Specs specs;
  final Address address;

  MostOrderItem({
    this.mostOrderId,
    this.name,
    this.id,
    this.deliveryTime,
    this.oderId,
    this.oderAmount,
    this.paymentType,
    this.address,
    this.image,
    this.qty,
    this.bargainenabled,
    this.bargaintrgqty,
    this.sampleNo,
    this.origin,
    this.isLive,
    this.isTaxable,
    this.price,
    this.unit,
    this.category,
    this.itemname,
    this.city,
    this.manufacturer,
    this.seller,
    this.addedBy,
    this.specs,
  });

  factory MostOrderItem.fromJson(Map<String, dynamic> json) {
    return MostOrderItem(
      mostOrderId: json['_id'],
      name: json['item']['sampleNo'],
      id: json['item']['_id'],
      deliveryTime: json['item']['origin'],
      oderId: json['item']['grainCount'],
      oderAmount: json['item']['grainCount'],
      paymentType: json['item']['grainCount'],
      image: json['item']['image'],
      qty: json['item']['qty'],
      bargainenabled: json['item']['bargainenabled'],
      bargaintrgqty: json['item']['bargaintrgqty'],
      sampleNo: json['item']['sampleNo'],
      origin: json['item']['origin'],
      isLive: json['item']['isLive'],
      isTaxable: json['item']['isTaxable'],
      price: json['item']['price'],
      itemname: ItemName.fromJson(json['item']['name']),
      unit: Unit.fromJson(json['item']['unit']),
      category: Category.fromJson(json['item']['category']),
      city: City.fromJson(json['item']['city']),
      manufacturer: Manufacturer.fromJson(json['item']['manufacturer']),
//        addedBy: userModel.fromJson(json['addedby']),
      seller: UserModel.fromJson(json['item']['seller']),
      specs: Specs.fromJson(json['item']['specs']),
      address:
          Address.fromJson(json['item']['address']), // Issue with null data
    );
  }

  static List<MostOrderItem> fromJsonArray(List<dynamic> json) {
    List<MostOrderItem> bannerLists = json
        .map<MostOrderItem>((json) => MostOrderItem.fromJson(json))
        .toList();
    return bannerLists;
  }
}

class Specs {
  String moisture;
  String graincount;
  String icumsa;

  Specs({this.moisture, this.graincount, this.icumsa});

  Specs.fromJson(Map<String, dynamic> json)
      : this.moisture = json["moisture"],
        this.graincount = json["graincount"],
        this.icumsa = json["icumsa"];
}

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
