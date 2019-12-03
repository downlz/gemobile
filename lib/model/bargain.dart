import 'package:graineasy/model/usermodel.dart';
import 'package:graineasy/utils/check_internet/utility.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Item.dart';

//import 'package:graineasy/model/address.dart';
//import 'package:graineasy/model/auction.dart';

@JsonSerializable(nullable: true)
class Bargain {
  String id;
  Item item;
  UserModel seller;
  UserModel buyer;
  int quantity;
  pricerequestSchema firstquote;
  pricerequestSchema secondquote;
  pricerequestSchema thirdquote;
  int bargaincounter;
  String bargainstatus;
  DateTime lastupdated;
  pauseBargain pausebargain;
  String addedby;

  Bargain(
      {this.id,
      this.bargaincounter,
      this.bargainstatus,
      this.buyer,
      this.firstquote,
      this.item,
      this.lastupdated,
      this.pausebargain,
      this.quantity,
      this.secondquote,
      this.seller,
      this.thirdquote,
      this.addedby});

  factory Bargain.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Bargain(
      id: json['_id'],
      item: Item.fromJson(json['item']),
      seller: UserModel.fromJson(json['seller']),
      buyer: UserModel.fromJson(json['buyer']),
      quantity: json['quantity'],
      firstquote: pricerequestSchema.fromJson(json['firstquote']),
      secondquote: pricerequestSchema.fromJson(json['secondquote']),
      thirdquote: pricerequestSchema.fromJson(json['thirdquote']),
      bargaincounter: json['bargaincounter'],
      bargainstatus: json['bargainstatus'],
      lastupdated: Utility.convertStringDateToDateTime(json['lastupdated']),
      pausebargain: pauseBargain.fromJson(json['firstquote']),
      addedby: json['addedby']
    );
  }


  static List<Bargain> fromJsonArray(List<dynamic> json) {
    List<Bargain> bargainLists = json.map<Bargain>((json) =>
        Bargain.fromJson(json))
        .toList();
    return bargainLists;
  }
}

class pricerequestSchema {
  DateTime requestedon;
  double buyerquote;
  double sellerquote;
  String status;

  pricerequestSchema(
      {this.requestedon, this.buyerquote, this.sellerquote, this.status});

  factory pricerequestSchema.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return pricerequestSchema(
      requestedon: Utility.convertStringDateToDateTime(json['requestedon']),
      buyerquote: json['buyerquote'] != null
          ? json['buyerquote'].toDouble()
          : 0.0,
      sellerquote: json['sellerquote'] != null
          ? json['sellerquote'].toDouble()
          : 0.0,
      status: json['status'],
    );
  }
}

class pauseBargain {
  bool isPaused;
  String pausetype;
  int pausehrs;
  DateTime pausestarttime;
  DateTime pauseendtime;
  String pausedby;
  pauseBargain(
      {this.isPaused,
      this.pauseendtime,
      this.pausehrs,
      this.pausestarttime,
      this.pausetype,
      this.pausedby});

  factory pauseBargain.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return pauseBargain(
      isPaused: json['isPaused'],
      pausetype: json['pausetype'],
      pausehrs: json['pausehrs'],
      pausestarttime: json['pausestarttime'],
      pauseendtime: json['pauseendtime'],
        pausedby: json['pausedby']
    );
  }
}
