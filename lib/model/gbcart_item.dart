import 'groupbuy.dart';

class GBCartItem {
  int qty;
  var totalPrice;
  Groupbuy gbitem;

  GBCartItem(this.qty, this.totalPrice, this.gbitem);

//  static List<Category> fromJsonArray(  List<dynamic>  json) {
//    List<Category> bannerLists = json.map<Category>((json) => Category.fromJson(json))
//        .toList();
//    return bannerLists;
//  }


}
