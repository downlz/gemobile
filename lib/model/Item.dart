class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final Address address;
  final String cancelOder;

  Item({this.name,
    this.deliveryTime,
    this.oderId,
    this.oderAmount,
    this.paymentType,
    this.address,
    this.cancelOder});

  factory Item.fromJson(Map<String, dynamic> json) {
    return new Item(
        name: json['sampleNo'],
        deliveryTime: json['origin'],
        oderId: json['grainCount'],
        oderAmount: json['grainCount'],
        paymentType: json['grainCount'],
        address: json['address'],
        cancelOder: json['grade']
    );
  }

}

class Address {

  final String city;
  final String pin;

  Address({this.city,
    this.pin});

  factory Address.fromJson(Map<String, dynamic> json) {
    return new Address(
        city: json['sampleNo'],
        pin: json['origin']
    );
  }

}