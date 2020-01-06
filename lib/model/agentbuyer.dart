import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class AgentBuyer {

  City city;
  String id;
  String text;
  StateObject state;
  String addedby;
  String pin;
  String phone;
  AgentBuyeridentifier agentbuyeridentifier;


  AgentBuyer({this.id,this.state,this.city,
    this.addedby,
    this.pin,
    this.phone,
    this.text,
    this.agentbuyeridentifier
  });

  factory AgentBuyer.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;

    return AgentBuyer(

      id: json['_id'],
        addedby: json['addedby'],
        text: json['text'],
        state: StateObject.fromJson(json['state']),
      city: City.fromJson(json['city']),
      pin: json['pin'],
      phone: json['phone'],
      agentbuyeridentifier: AgentBuyeridentifier.fromJson(json['addressbasicdtl']),

    );
  }

  static List<AgentBuyer> fromJsonArray(List<dynamic> json) {
    List<AgentBuyer> addresses = json.map<AgentBuyer>((json) =>
        AgentBuyer.fromJson(json))
        .toList();
    return addresses;
  }
}

class AgentBuyeridentifier {
  String partyname;
  String gstin;

  AgentBuyeridentifier({this.partyname,this.gstin});

  factory AgentBuyeridentifier.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;
    return AgentBuyeridentifier(
        partyname: json['partyname'],
        gstin: json['gstin']
    );
  }

//  static List<Addridentifier> fromJsonArray(List<dynamic> json) {
//    List<Addridentifier> addresses = json.map<Addridentifier>((json) =>
//        Addridentifier.fromJson(json))
//        .toList();
//    return addresses;
//  }

}