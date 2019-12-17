class User {


  String name;
  String id;
  bool isAdmin;
  String email;
  bool isSeller;
  bool isAgent;
  bool isActive;
  bool isBuyer;
  String token;
  String fcmkey;
  String phone;

  User({this.name,this.id,this.fcmkey,this.email,
      this.isActive,this.isAdmin,this.isAgent,this.isBuyer,this.isSeller,
      this.token,this.phone});



  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['_id'],
        phone = json['phone'],
        email = json['email'],
        isSeller = checkBool(json, 'isSeller'),
        isAgent = checkBool(json, 'isAgent'),
        isAdmin = checkBool(json, 'isAdmin'),
        isBuyer = checkBool(json, 'isBuyer'),
        isActive = checkBool(json, 'isActive'),
        token = json['token'],
        fcmkey = json['fcmkey'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        '_id': id,
        'token': token,
        'email': email,
        'phone': phone,
        'isSeller': isSeller,
        'isBuyer': isBuyer,
        'isAgent': isAgent,
        'isAdmin': isAdmin,
        'isActive': isActive,
        'fcmkey' : fcmkey
      };

  static checkBool(Map<String, dynamic> json, String data) {
    if (json.containsKey(data))
      return json[data];
    return false;
  }
}