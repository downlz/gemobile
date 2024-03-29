class ItemName {
  String name;
  String id;
  String hsn;
  String image;
  int tax;
  int insurance;

  ItemName({this.name,this.id,this.hsn,this.tax,this.insurance,this.image});

  factory ItemName.fromJson(Map<String, dynamic> json) {
    return ItemName(
        name: json['name'],
        id: json['_id'],
        hsn:json['hsn'],
        tax: json['tax'] as int,
        image: json['image'],
        insurance: json['insurance'] as int
    );
  }



  static List<ItemName> fromJsonArray(  List<dynamic>  json) {
    List<ItemName> bannerLists = json.map<ItemName>((json) => ItemName.fromJson(json))
        .toList();
    return bannerLists;
  }


}