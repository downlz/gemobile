class User {

  String name;
//  String _id;
//  String isAdmin;
//  String isBuyer;
//  String isSeller;
//  String isAgent;
//  String isActive;
  String token;
  String phone;

  User(this.name,
//      this.isActive,this.isAdmin,this.isAgent,this.isBuyer,this.isSeller,
      this.token,this.phone);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
//        isBuyer = json['isBuyer'],
//        isSeller = json['isSeller'],
//        isAgent = json['isAgent'],
//        isAdmin = json['isAdmin'],
//        isActive = json['isActive'],
        token = json['token'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'token': token,
        'phone': phone
//        'isBuyer': isBuyer,
//        'isSeller': isSeller,
//        'isAgent': isAgent,
//        'isAdmin': isAdmin,
//        'isActive': isActive,
      };
}