import 'package:graineasy/model/item.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:graineasy/utils/check_internet/utility.dart';
import 'package:json_annotation/json_annotation.dart';

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
      this.thirdquote});

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
    );
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
      buyerquote: json['buyerquote'].toDouble(),
      sellerquote: json['sellerquote'].toDouble(),
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

  pauseBargain(
      {this.isPaused,
      this.pauseendtime,
      this.pausehrs,
      this.pausestarttime,
      this.pausetype});

  factory pauseBargain.fromJson(Map<String, dynamic> json) {
    return pauseBargain(
      isPaused: json['isPaused'],
      pausetype: json['pausetype'],
      pausehrs: json['pausehrs'],
      pausestarttime: json['pausestarttime'],
      pauseendtime: json['pauseendtime'],
    );
  }
}
