class Unit {
  String mass;
  String id;

  Unit({this.mass,this.id});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
        mass: json['mass'],
        id: json['_id']
    );
  }
}