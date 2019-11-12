import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class Address {
  String text;
  City city;
  String id;
  States state;
//  String addedby;
  String pin;
  String addresstype;
  String phone;
  Addridentifier addridentifier;


  Address({this.text,this.id,this.state,this.city,
//    this.addedby,
    this.pin,
    this.addresstype,
    this.phone,
    this.addridentifier
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;
    return Address(
      text: json['text'],
      id: json['_id'],
//        addedby: json['addedby'],
//        state: State.fromJson(json['state']),
      city: City.fromJson(json['city']),
      pin: json['pin'],
      addresstype: json['addresstype'],
      phone: json['phone'],
      addridentifier: Addridentifier.fromJson(json['addressbasicdtl']),

    );
  }

  static List<Address> fromJsonArray(List<dynamic> json) {
    List<Address> addresses = json.map<Address>((json) =>
        Address.fromJson(json))
        .toList();
    return addresses;
  }
}

class Addridentifier {
  String partyname;
  String gstin;

  Addridentifier({this.partyname,this.gstin});

  factory Addridentifier.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;
    return Addridentifier(
        partyname: json['partyname'],
        gstin: json['gstin']
    );
  }

  static List<Addridentifier> fromJsonArray(List<dynamic> json) {
    List<Addridentifier> addresses = json.map<Addridentifier>((json) =>
        Addridentifier.fromJson(json))
        .toList();
    return addresses;
  }

}