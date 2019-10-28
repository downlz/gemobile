class userModel {

  String vendorCode;
  String id;
  String email;
  String phone;
  String name;
//  List<Address> address;

  userModel({this.vendorCode,this.id,this.name,this.email,this.phone,
//    this.address
  });

  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
        name: json['name'],
        id: json['_id'],
        email: json['email'],
        phone: json['phone'],
        vendorCode: json['vendorCode'],
//        address:
    );
  }
}