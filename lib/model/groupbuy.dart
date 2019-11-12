import 'package:graineasy/model/item.dart';
import 'package:graineasy/model/unit.dart';
import 'package:graineasy/utils/check_internet/utility.dart';
import 'package:json_annotation/json_annotation.dart';
//import 'package:graineasy/model/auction.dart';

@JsonSerializable(nullable: true)
class Groupbuy {
  String id;
  Item item;
  DateTime gbstarttime;
  DateTime gbendtime;
  double dealprice;
  int moq;
  int maxqty;
  String sampleno;
  int totalqty;
  Unit unit;
  int taxrate;
  bool isactive;
  String remarks;

  Groupbuy(
      {this.id,
      this.item,
      this.isactive,
      this.dealprice,
      this.gbendtime,
      this.gbstarttime,
      this.maxqty,
      this.moq,
      this.remarks,
      this.sampleno,
      this.taxrate,
      this.totalqty,
      this.unit});

  factory Groupbuy.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Groupbuy(
        id: json['_id'],
        item: Item.fromJson(json['item']),
        gbstarttime: Utility.convertStringDateToDateTime(json['gbstarttime']),
        gbendtime: Utility.convertStringDateToDateTime(json['gbendtime']),
        dealprice: json['dealprice'].toDouble(),
        moq: json['moq'],
        maxqty: json['maxqty'],
        sampleno: json['sampleno'],
        totalqty: json['totalqty'],
        unit: Unit.fromJson(json['unit']),
        taxrate: json['taxrate'],
        isactive: json['isactive'],
        remarks: json['remarks']);
  }
}
