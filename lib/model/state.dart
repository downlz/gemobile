class State {
  String name;
  String id;

  State({this.name,this.id});

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
        name: json['name'],
        id: json['_id']
    );
  }
}