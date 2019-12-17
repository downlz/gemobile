import 'package:get_it/get_it.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view_model.dart';
import 'package:graineasy/ui/view/BargainDetail/bargain_history_view_model.dart';
import 'package:graineasy/ui/view/account/account_view_model.dart';
import 'package:graineasy/ui/view/account/add_update_address/add_update_addresses_view_model.dart';
import 'package:graineasy/ui/view/account/add_update_bankacc/add_update_bankacc_view_model.dart';
import 'package:graineasy/ui/view/cart_screen/cart_view_model.dart';
import 'package:graineasy/ui/view/gbcart_screen/gbcart_view_model.dart';
import 'package:graineasy/ui/view/category/category_view_model.dart';
import 'package:graineasy/ui/view/forgot_password/forgot_password_model.dart';
import 'package:graineasy/ui/view/group-buy/groupbuy_view_model.dart';
import 'package:graineasy/ui/view/home/home_view_model.dart';
import 'package:graineasy/ui/view/item_details/details_view_model.dart';
import 'package:graineasy/ui/view/group-buy/gbitem_details/gbdetails_view_model.dart';
import 'package:graineasy/ui/view/login/login_view_model.dart';
import 'package:graineasy/ui/view/manage_order/manage_order/manage_order_view_model.dart';
import 'package:graineasy/ui/view/manage_order_detail/manage_order_detail_model.dart';
import 'package:graineasy/ui/view/order/order_history/order_history_view_model.dart';
import 'package:graineasy/ui/view/order_detail/order_detail_model.dart';
import 'package:graineasy/ui/view/registration/registration_view_model.dart';
import 'package:graineasy/ui/view/search/search_item_view_model.dart';


GetIt locator = GetIt();

void setupLocator() {
  locator.registerFactory(() {
    return LoginViewModel();
  });

  locator.registerFactory(() {
    return RegistrationViewModel();
  });

  locator.registerFactory(() {
    return ForgotPasswordModel();
  });

  locator.registerFactory(() {
    return HomeViewModel();
  });

  locator.registerFactory(() {
    return CategoryViewModel();
  });

  locator.registerFactory(() {
    return DetailsViewModel();
  });

  locator.registerFactory(() {
    return GBDetailsViewModel();
  });

  locator.registerFactory(() {
    return AccountViewModel();
  });

  locator.registerFactory(() {
    return OrderHistoryViewModel();
  });

  locator.registerFactory(() {
    return BargainViewModel();
  });

  locator.registerFactory(() {
    return CartViewModel();
  });

  locator.registerFactory(() {
    return GBCartViewModel();
  });

  locator.registerFactory(() {
    return AddUpdateAddressViewModel();
  });

  locator.registerFactory((){
    return AddUpdateBankAccViewModel();
  });

  locator.registerFactory(() {
    return OrderDetailViewModel();
  });

  locator.registerFactory(() {
    return ManageOrderViewModel();
  });

  locator.registerFactory(() {
    return ManageOrderDetailViewModel();
  });

  locator.registerFactory(() {
    return BargainHistoryViewModel();
  });

  locator.registerFactory(() {
    return SearchItemViewModel();
  });

  locator.registerFactory(() {
    return GroupbuyViewModel();
  });
}
