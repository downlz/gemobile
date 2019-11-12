class User {


  String name;
  String id;
  bool isAdmin;
  bool isBuyer;
  bool isSeller;
  bool isAgent;
  bool isActive;
  String token;
  String phone;

  User({this.name,this.id,
      this.isActive,this.isAdmin,this.isAgent,this.isBuyer,this.isSeller,
      this.token,this.phone});



  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['_id'],
        phone = json['phone'],
        isBuyer = json['isBuyer'],
        isSeller = json['isSeller'],
        isAgent = json['isAgent'],
        isAdmin = json['isAdmin'],
        isActive = json['isActive'],
        token = json['token'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        '_id': id,
        'token': token,
        'phone': phone,
        'isBuyer': isBuyer,
        'isSeller': isSeller,
        'isAgent': isAgent,
        'isAdmin': isAdmin,
        'isActive': isActive,
      };
}