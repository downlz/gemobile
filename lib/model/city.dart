import 'package:graineasy/model/state.dart';

class City {
  String name;
  String id;
  State state;

  City({this.name,this.id,this.state});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        name: json['name'],
        id: json['_id'],
        state: State.fromJson(json['state'])
    );
  }
}