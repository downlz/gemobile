import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class StateObject {
  String name;
  String id;
  int code;

  StateObject({this.name,
    this.id,
    this.code
  });

  factory StateObject.fromJson(Map<String, dynamic> json) {
    return StateObject(
        name: json['name'],
        id: json['_id'],
        code: json['code'] as int
    );
  }

  static List<StateObject> fromJsonArray(List<dynamic> json) {
    List<StateObject> addresses = json.map<StateObject>((json) =>
        StateObject.fromJson(json))
        .toList();
    return addresses;
  }
}