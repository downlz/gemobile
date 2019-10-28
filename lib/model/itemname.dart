class Itemname {
  String name;
  String id;
  String hsn;
  int tax;
  int insurance;

  Itemname({this.name,this.id,this.hsn,this.tax,this.insurance});

  factory Itemname.fromJson(Map<String, dynamic> json) {
    return Itemname(
        name: json['name'],
        id: json['_id'],
        hsn:json['hsn'],
        tax: json['tax'],
        insurance: json['insurance']
    );
  }
}