import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class BankAccount {
  String id;
  String user;          // Is a object id
  String name;
  String bank;
  String accountType;
  String accountNo;
  String micr;
  String ifsc;
  String accountPreference;
  bool approved;
  String remarks;
  String createdAt;
  String createdBy;
  String updatedAt;

  BankAccount({this.id,this.user,
    this.name,this.bank,this.accountType,this.accountNo,
    this.micr,this.ifsc,this.accountPreference,this.approved,this.remarks,this.createdAt,
    this.createdBy,this.updatedAt
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
        name: json['name'],
        id: json['_id'],
        bank: json['bank'],
      accountType: json['accountType'],
      accountNo: json['accountNo'],
      micr: json['micr'],
      ifsc: json['ifsc'],
      accountPreference: json['accountPreference'],
      approved: json['approved'],
      remarks: json['remarks'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt']
    );
  }

  static List<BankAccount> fromJsonArray(List<dynamic> json) {
    List<BankAccount> bankacc = json.map<BankAccount>((json) => BankAccount.fromJson(json))
        .toList();
    return bankacc;
  }
}