class Itemname {
  String name;
  String id;
  String hsn;
  String image;
  int tax;
  int insurance;

  Itemname({this.name,this.id,this.hsn,this.tax,this.insurance,this.image});

  factory Itemname.fromJson(Map<dynamic, dynamic> json) {
    return Itemname(
        name: json['name'],
        id: json['_id'],
        hsn:json['hsn'],
        tax: json['tax'],
        image: json['image'],
        insurance: json['insurance']
    );
  }



  static List<Itemname> fromJsonArray(Map json) {
//    var rest = json['items'] as List;
    List<Itemname> bannerLists =  json[''].map<Itemname>((json) => Itemname.fromJson(json))
        .toList();
    return bannerLists;
  }


}