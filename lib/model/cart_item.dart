import 'Item.dart';

class CartItem {
  int qty;
  int totalPrice;

  Item item;

  CartItem(this.qty, this.totalPrice, this.item);
//  static List<Category> fromJsonArray(  List<dynamic>  json) {
//    List<Category> bannerLists = json.map<Category>((json) => Category.fromJson(json))
//        .toList();
//    return bannerLists;
//  }

}
