import 'package:graineasy/utils/check_internet/utility.dart';

class CreditRequest {
  String id;
  int annualTurnover;
  int lastThreeTurnovr;
  String tradeItems;
  String phone;
  String status;
  String requestedOn;
  String lastUpdated;
  String remarks;

  CreditRequest({this.annualTurnover,this.id,this.lastThreeTurnovr,this.tradeItems,this.phone,
  this.status,this.requestedOn,this.lastUpdated,this.remarks});

  factory CreditRequest.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return CreditRequest(
      annualTurnover: json['annualturnover'],
        id: json['_id'],
      lastThreeTurnovr: json['lastthreeturnovr'],
        tradeItems: json['tradeitems'],
        phone: json['phone'],
      status: json['status'],
      requestedOn: json['requestedon'],
      lastUpdated: json['lastupdated'],
      remarks: json['remarks']
    );
  }

  static List<CreditRequest> fromJsonArray(List<dynamic> json) {
    List<CreditRequest> creditrequest = json.map<CreditRequest>((json) =>
        CreditRequest.fromJson(json))
        .toList();
    return creditrequest;
  }

//  static checkBool(Map<String, dynamic> json, String data) {
//    if (json.containsKey(data))
//      return json[data];
//    return false;
//  }
}