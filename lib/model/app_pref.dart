class AppPref {
  String appversion;
  String id;
  bool appupdaterequired;
  bool buyer;
  bool seller;

  AppPref({this.appversion,this.id,
  this.appupdaterequired,this.seller,this.buyer});

  factory AppPref.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return AppPref(
        appversion: json['appversion'],
        id: json['_id'],
        appupdaterequired: checkBool(json, 'appupdaterequired'),
        buyer: checkBool(json, 'buyer'),
        seller: checkBool(json, 'seller'),
    );
  }

  static List<AppPref> fromJsonArray(List<dynamic> json) {
    List<AppPref> apppref = json.map<AppPref>((json) =>
        AppPref.fromJson(json))
        .toList();
    return apppref;
  }

  static checkBool(Map<String, dynamic> json, String data) {
    if (json.containsKey(data))
      return json[data];
    return false;
  }
}