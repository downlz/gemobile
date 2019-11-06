import 'package:graineasy/model/state.dart';
import 'package:graineasy/model/city.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class Address {
  String text;
  City city;
  String id;
  State state;
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
    return Address(
        text: json['text'],
        id: json['_id'],
//        addedby: json['addedby'],
//        state: State.fromJson(json['state']),
        city: City.fromJson(json['city']),
        pin: json['pin'],
        addresstype: json['addresstype'],
        phone: json['phone'],
//        addridentifier: Addridentifier.fromJson(json['addressbasicdtl']),

    );
  }
}

class Addridentifier {
  String partyname;
  String gstin;

  Addridentifier({this.partyname,this.gstin});

  factory Addridentifier.fromJson(Map<String, dynamic> json) {
    return Addridentifier(
        partyname: json['partyname'],
        gstin: json['gstin']
    );
  }

}