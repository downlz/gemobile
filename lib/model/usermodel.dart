import 'package:graineasy/model/address.dart';

class userModel {

  final String vendorCode;
  final bool isActive;
  final String id;
  final String name;
  final String email;
  final String phone;
  final String pan;
  final String gst;
  final int sellerFeePerKg;
  final int buyerBackMarginPercent;
  final int buyerCreditCostPercent;
  final int buyerFeePerKg;
  final int buyerNetLossPercent;
  final int buyerMarginPerKg;
  final int buyerDiscount1Percent;
  final int buyerDiscount2PerKg;
  final int buyerDiscount3Lumpsump;
  final int buyerFinePerKg;
  final bool isSeller;
  final bool isAdmin;
  final bool isAgent;
  final bool isBuyer;
  final Address address;

  userModel({this.vendorCode,this.id,this.name,this.email,this.isActive,this.phone,
    this.pan,this.gst,this.isBuyer,this.sellerFeePerKg,this.buyerBackMarginPercent,
    this.buyerCreditCostPercent,this.buyerFeePerKg,this.buyerNetLossPercent,this.buyerMarginPerKg,
    this.buyerDiscount1Percent,this.buyerDiscount2PerKg,this.buyerDiscount3Lumpsump,this.buyerFinePerKg,
    this.isAdmin,this.isSeller,this.isAgent,this.address

//    this.address
  });

  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
        name: json['name'],
        id: json['_id'],
        email: json['email'],
        phone: json['phone'],
        vendorCode: json['vendorCode'],
        pan: json['pan'],
        gst: json['GST'],
    sellerFeePerKg: json['sellerFeePerKg'],
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
        isActive: json['isactive'],
//    address: Address.fromJson(json['Addresses'][0]) // This should be fixed
    );
  }
}