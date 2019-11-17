import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/auction.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:graineasy/model/item.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:graineasy/utils/check_internet/utility.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class Order {
  String id;
  var discount;
  int cost;
  bool reversechargemech;
  int transportcost;
  int insurancecharges;
  String orderno;
  int quantity;
  String unit;
  DateTime placedTime;
  DateTime confirmedTime;
  DateTime readyTime;
  DateTime shipmentTime;
  DateTime receivedTime;
  DateTime lastUpdated;
  String address;

  String status;
  String ordertype;
  String paymentterms;
  bool isshippingbillingdiff;
  Address shippingaddress;
  double price;
  Item item;
  UserModel buyer;
  UserModel seller;
  String remarks;
  String invoiceno;

  Bargain referenceBargain;
  Auction referenceAuction;
  Groupbuy referenceGB;

  userGeneratedBillSchema manualbill;
  String paymentMode;

  Order(
      {this.id,
      this.unit,
      this.cost,
      this.address,
      this.remarks,
      this.item,
      this.seller,
      this.quantity,
      this.buyer,
      this.confirmedTime,
      this.placedTime,
      this.discount,
      this.insurancecharges,
      this.invoiceno,
      this.isshippingbillingdiff,
      this.lastUpdated,
      this.manualbill,
      this.orderno,
      this.ordertype,
      this.paymentterms,
      this.price,
      this.readyTime,
      this.receivedTime,
      this.referenceBargain,
      this.referenceGB,
      this.referenceAuction,
      this.reversechargemech,
      this.shipmentTime,
      this.shippingaddress,
      this.status,
      this.transportcost,
      this.paymentMode});

  static List<Order> fromJsonArray(List<dynamic> json) {
    List<Order> orders =
        json.map<Order>((json) => Order.fromJson(json)).toList();
    return orders;
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;

    return Order(
        id: json['_id'],
        orderno: json['orderno'],
        unit: json['unit'],
        item: Item.fromJson(json['item']),
        quantity: json['quantity'],
        cost: getCost(json),
        remarks: json['remarks'],
        discount: json['discount'],
        price: getPrice(json),
        address: json['address'],
        buyer: UserModel.fromJson(json['buyer']),
        seller: UserModel.fromJson(json['seller']),
        isshippingbillingdiff: json['isshippingbillingdiff'],
        shippingaddress: Address.fromJson(json['shippingaddress']),
        placedTime: Utility.convertStringDateToDateTime(json['placedTime']),
//        confirmedTime: Utility.convertStringDateToDateTime(json['confirmedTime']),
//        readyTime: Utility.convertStringDateToDateTime(json['readyTime']),
//        shipmentTime: Utility.convertStringDateToDateTime(json['shipmentTime']),
//        receivedTime: Utility.convertStringDateToDateTime(json['receivedTime']),
        lastUpdated: Utility.convertStringDateToDateTime(json['lastUpdated']),
        paymentMode: json['paymentMode'],
        status: json['status'],
        invoiceno: json['invoiceno'],
        manualbill: userGeneratedBillSchema.fromJson(json['manualbill']),
        ordertype: json['ordertype'],
        reversechargemech: json['reversechargemech'],
        paymentterms: json['paymentterms'],
        transportcost: json['transportcost'],
        insurancecharges: json['insurancecharges'],
        referenceGB: Groupbuy.fromJson(json['referenceGB']),
        referenceAuction: Auction.fromJson(json['referenceAuction']),
        referenceBargain: Bargain.fromJson(json['referenceBargain']));
  }
}

int getCost(Map<String, dynamic> value) {
  try {
    return value['cost'] as int;
  } catch (e) {
    double costInDouble = value['cost'] as double;
    return costInDouble.round();
  }
  return 0;
}

double getPrice(Map<String, dynamic> value) {
  try {
    return value['price'] as double;
  } catch (e) {
    int priceInInt = value['price'] as int;
    return double.parse(priceInInt.toString());
  }
  return 0;
}

class userGeneratedBillSchema {
  String filename;
  UserModel addedBy;
  DateTime addedOn;

  userGeneratedBillSchema({this.filename, this.addedBy, this.addedOn});

  factory userGeneratedBillSchema.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return userGeneratedBillSchema(
        filename: json['filename'],
        addedBy: json['addedBy'],
        addedOn: json['addedOn']);
  }
}
