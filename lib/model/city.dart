import 'package:graineasy/model/state.dart';

class City {
  String name;
  String id;
  State state;
  Object location;

  City({this.name,this.id,this.state,this.location});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        name: json['name'],
        id: json['_id'],
        location: json['location'],
        state: State.fromJson(json['state'])
    );
  }
}