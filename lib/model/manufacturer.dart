class Manufacturer {
  String name;
  String address;
  String id;
  String phone;
  String email;

  Manufacturer({this.name,this.address,this.id,this.phone,this.email});

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
        name: json['name'],
        id: json['_id'],
        address: json['address'],
        email: json['email'],
        phone: json['phone']
    );
  }

  static List<Manufacturer> fromJsonArray(List<dynamic> json) {
    List<Manufacturer> bannerLists =
    json.map<Manufacturer>((json) => Manufacturer.fromJson(json)).toList();
    return bannerLists;
  }
}