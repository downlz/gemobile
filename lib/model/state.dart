import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class State {
  String name;
  String id;
  String code;

  State({this.name,
    this.id,
    this.code
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
        name: json['name'],
        id: json['_id'],
        code: json['code']
    );
  }
}