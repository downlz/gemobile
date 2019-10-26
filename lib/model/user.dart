class User {
  String _phone;
  String _password;
  User(this._phone, this._password);

  User.map(dynamic obj) {
    this._phone = obj["phone"];
    this._password = obj["password"];
  }

  String get phone => _phone;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["phone"] = _phone;
    map["password"] = _password;

    return map;
  }
}