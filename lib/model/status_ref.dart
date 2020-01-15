class StatusRef {
  String model;
  String id;
  String submodel;
  String description;
  String code;

  StatusRef({this.model,this.code,this.description,this.id,this.submodel});

  factory StatusRef.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return StatusRef(
        model: json['model'],
        id: json['_id'],
      submodel: json['submodel'],
      description: json['description'],
      code: json['code'],
    );
  }

  static List<StatusRef> fromJsonArray(List<dynamic> json) {
    List<StatusRef> statusref = json.map<StatusRef>((json) =>
        StatusRef.fromJson(json))
        .toList();
    return statusref;
  }

  static checkBool(Map<String, dynamic> json, String data) {
    if (json.containsKey(data))
      return json[data];
    return false;
  }
}