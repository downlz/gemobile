import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/category.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/manufacturer.dart';
import 'package:graineasy/model/unit.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:graineasy/utils/check_internet/utility.dart';

@JsonSerializable(nullable: true)
class Item {
  final String name;
  final String id;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final Category category;
  final ItemName itemname;
  final String image;
  final String grade;
  final int qty;
  final int bargaintrgqty;
  final bool bargainenabled;
  final Unit unit;
  final double price;
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
  final bool showAddedByName;
  final bool showSeller;
  final bool brokerage;
  final String brokerageRate;
  final String remarks;
  final DateTime paymentDt;
  final DateTime liftDt;
  Item({
    this.name,
    this.id,
    this.deliveryTime,
    this.oderId,
    this.oderAmount,
    this.paymentType,
    this.grade,
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
    this.brokerage,
    this.showAddedByName,
    this.showSeller,
    this.brokerageRate,
    this.remarks,
    this.paymentDt,
    this.liftDt
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;

    return Item(
      name: json['sampleNo'],
      id: json['_id'],
      deliveryTime: json['origin'],
      oderId: json['grainCount'],
      oderAmount: json['grainCount'],
      paymentType: json['grainCount'],
      image: json['image'],
      grade: json['grade'],
      qty: json['qty'],
      bargainenabled: json['bargainenabled'],
      bargaintrgqty: json['bargaintrgqty'],
      sampleNo: json['sampleNo'],
      origin: json['origin'],
      isLive: json['isLive'],
      isTaxable: json['isTaxable'],
//        price: json['price'].toDouble(),
      price: json['price'] == null ? 0.0 : getPriceInDouble(json['price']),
      itemname: ItemName.fromJson(json['name']),
      unit: Unit.fromJson(json['unit']),
      category: Category.fromJson(json['category']),
      city: City.fromJson(json['city']),
      manufacturer: Manufacturer.fromJson(json['manufacturer']),
        addedBy: UserModel.fromJson(json['addedby']),
      seller: UserModel.fromJson(json['seller']),
      specs: Specs.fromJson(json['specs']),
      address: Address.fromJson(json['address']), // Issue with null data
      brokerage: json['brokerage'],
      showAddedByName: json['showaddedbyname'],
      showSeller: json['showseller'],
      brokerageRate: json['brokeragerate'],
      remarks: json['remarks'],
      paymentDt : json['paymentdate'] == null ? DateTime.now(): Utility.convertStringDateToDateTime(json['paymentdate']),
      liftDt : json['liftdate'] == null ? DateTime.now() : Utility.convertStringDateToDateTime(json['liftdate']),
    );
  }

  static List<Item> fromJsonArray(List<dynamic> json) {
    List<Item> bannerLists =
    json.map<Item>((json) => Item.fromJson(json)).toList();
    return bannerLists;
  }
}

getPriceInDouble(var price) {
//  print('Price ==========> $price');
  if (price == null)
    return 0;
  try {
    double doublePrice = price.toDouble();
    return doublePrice;
  } catch (e) {
    try {
      int intPrice = price as int;
      double doublePrice = double.parse(intPrice.toString());
      return doublePrice;
    } catch (e) {
      return 0;
    }
  }
}

class Specs {
  String moisture;
  String graincount;
  String icumsa;

  Specs({this.moisture, this.graincount, this.icumsa});

  // Constructor overload
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
