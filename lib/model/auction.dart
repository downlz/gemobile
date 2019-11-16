import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/category.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/model/state.dart';
import 'package:graineasy/model/unit.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class Auction {
  String id;
  ItemName itemName;
  Category itemCategory;
  Item sampleNo;
  String auctionType;
  String address;
  String pincode;
  StateObject state;
  int availableQty;
  int maxQty;
  int minQty;
  Unit unit;
  int floorPrice;
  int ceilingPrice;
  bool nameVisible;
  bool transportCost;
  DateTime startTime;
  DateTime endTime;
  bool approved;
  UserModel user;       // Object Id
  String remarks;
  UserModel createdBy;
  DateTime createdAt;

  Auction({
    this.id,
    this.itemName,
    this.itemCategory,
    this.sampleNo,
    this.auctionType,
    this.address,
    this.pincode,
    this.state,
    this.availableQty,
    this.maxQty,
    this.minQty,
    this.unit,
    this.floorPrice,
    this.ceilingPrice,
    this.nameVisible,
    this.transportCost,
    this.startTime,
    this.endTime,
    this.approved,
    this.user,
    this.remarks,
    this.createdBy,
    this.createdAt,
  });

  factory Auction.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Auction(
        id: json['_id'],
        itemName: ItemName.fromJson(json['itemName']),
        itemCategory: Category.fromJson(json['itemCategory']),
        sampleNo: Item.fromJson(json['sampleNo']),
        auctionType: json['auctionType'],
        address: json['address'],
        pincode: json['pincode'],
        state: StateObject.fromJson(json['state']),
        availableQty: json['availableQty'],
        maxQty: json['minQty'],
        minQty: json['maxQty'],
        unit: Unit.fromJson(json['unit']),
        floorPrice: json['floorPrice'],
        ceilingPrice: json['ceilingPrice'],
        nameVisible: json['nameVisible'],
        transportCost: json['transportCost'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        approved: json['approved'],
        user: UserModel.fromJson(json['user']),
        remarks: json['remarks'],
        createdBy: UserModel.fromJson(json['createdBy']),
        createdAt: json['createdAt']);
  }
}
