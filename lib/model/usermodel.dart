import 'package:graineasy/model/address.dart';

class UserModel {

  String vendorCode;
  bool isActive;
  String id;
  String name;
  String email;
  String phone;
  String pan;
  String gst;
  double sellerFeePerKg;
  int buyerBackMarginPercent;
  int buyerCreditCostPercent;
  int buyerFeePerKg;
  int buyerNetLossPercent;
  int buyerMarginPerKg;
  int buyerDiscount1Percent;
  int buyerDiscount2PerKg;
  int buyerDiscount3Lumpsump;
  int buyerFinePerKg;
  bool isSeller;
  bool isAdmin;
  bool isAgent;
  bool isBuyer;
  List<Address> addresses;
  String fcmkey;
  String devicedtl;
  String devspecs;

  UserModel(
      {this.vendorCode, this.id, this.name, this.email, this.isActive, this.phone,
    this.pan,this.gst,this.isBuyer,this.sellerFeePerKg,this.buyerBackMarginPercent,
    this.buyerCreditCostPercent,this.buyerFeePerKg,this.buyerNetLossPercent,this.buyerMarginPerKg,
    this.buyerDiscount1Percent,this.buyerDiscount2PerKg,this.buyerDiscount3Lumpsump,this.buyerFinePerKg,
        this.isAdmin, this.isSeller, this.isAgent, this.addresses,this.devicedtl,this.fcmkey,this.devspecs

//    this.address
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;
    return UserModel(
        name: json['name'],
        id: json['_id'],
        email: json['email'],
        phone: json['phone'],
        vendorCode: json['vendorCode'],
        pan: json['pan'],
        gst: json['GST'],
        sellerFeePerKg: json['sellerFeePerKg'].toDouble(),
    buyerBackMarginPercent: json['buyerBackMarginPercent'],
    buyerCreditCostPercent: json['buyerCreditCostPercent'],
    buyerFeePerKg: json['buyerFeePerKg'],
    buyerNetLossPercent: json['buyerNetLossPercent'],
    buyerMarginPerKg: json['buyerMarginPerKg'],
    buyerDiscount1Percent: json['buyerDiscount1Percent'],
    buyerDiscount2PerKg: json['buyerDiscount2PerKg'],
    buyerDiscount3Lumpsump: json['buyerDiscount3Lumpsump'],
    buyerFinePerKg: json['buyerFinePerKg'],
    isAdmin: json['isAdmin'],
      isBuyer: json['isBuyer'],
    isSeller: json['isSeller'],
    isAgent: json['isAgent'],
        fcmkey: json['fcmkey'],
        devicedtl: json['devicedtl'],
        devspecs: json['devspecs'],
        isActive: json['isactive'],
        addresses: Address.fromJsonArray(
            json['Addresses']) // This should be fixed
    );
  }
}