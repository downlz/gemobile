import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/cart_item.dart';
import 'package:graineasy/model/usermodel.dart';

class CartViewModel extends BaseModel {
  List<CartItem> cartItems;
  UserModel userModel;
  bool isFirstTime = true;
  double totalPriceOfTheOrder = 0;

  void init(List<CartItem> cartItems) {
    if (isFirstTime) {
      isFirstTime = false;
      this.cartItems = cartItems;
      calculateTotalPrice(this.cartItems);
      getAddress();
    }
  }

  void getAddress() async {
    setState(ViewState.Busy);
    userModel = await API.getUserDetail();
    setState(ViewState.Idle);
  }

  void calculateTotalPrice(List<CartItem> cartItems) {
    for (CartItem cartItem in cartItems) {
      totalPriceOfTheOrder = totalPriceOfTheOrder + cartItem.totalPrice;
    }
  }
}
