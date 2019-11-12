import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class States {
  String name;
  String id;
  int code;

  States({this.name,
    this.id,
    this.code
  });

  factory States.fromJson(Map<String, dynamic> json) {
    return States(
        name: json['name'],
        id: json['_id'],
        code: json['code'] as int
    );
  }

  static List<States> fromJsonArray(List<dynamic> json) {
    List<States> addresses = json.map<States>((json) => States.fromJson(json))
        .toList();
    return addresses;
  }
}