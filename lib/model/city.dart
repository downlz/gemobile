import 'package:graineasy/model/state.dart';

class City {
  String name;
  String id;
  States state;
  Object location;

  City({this.name,this.id,this.state,this.location});

  factory City.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;
    return City(
        name: json['name'],
        id: json['_id'],
        location: json['location'],
        state: States.fromJson(json['state'])
    );
  }

  static List<City> fromJsonArray(List<dynamic> json) {
    List<City> addresses = json.map<City>((json) => City.fromJson(json))
        .toList();
    return addresses;
  }
}