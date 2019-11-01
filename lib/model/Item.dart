import 'package:graineasy/model/unit.dart';
import 'package:graineasy/model/category.dart';

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final Category category;
//  final Unit cancelOder;


  Item({this.name,
    this.deliveryTime,
    this.oderId,
    this.oderAmount,
    this.paymentType,
    this.address,
//    this.cancelOder,
    this.category
  });

  factory Item.fromJson(Map<String, dynamic> json) {
//    print(json['category.name']);
    return Item(
        name: json['sampleNo'],
        deliveryTime: json['origin'],
        oderId: json['grainCount'],
        oderAmount: json['grainCount'],
        paymentType: json['grainCount'],
        address: json['origin'],
//        cancelOder: Unit.fromJson(json['unit']),
        category: Category.fromJson(json['category'])
    );

  }

}
//  factory address.fromJson(Map<String, dynamic> parsedJson){
//
//    var list = parsedJson['images'] as List;
//    print(list.runtimeType);
//    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();
//
//
//    return address(
//        status: parsedJson['status'],
//        message: parsedJson['message'],
//        data: dataList
//
//    );
//  }


//class People {
//  String name;
//  int age;
//  People({this.name, this.age});
//
//  // Constructor overload
//  People.fromJson(Map<String, dynamic> json)
//      : this.age = json["age"],
//        this.name = json["name"];
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

