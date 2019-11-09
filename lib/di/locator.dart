
import 'package:get_it/get_it.dart';
import 'package:graineasy/ui/view/category/category_view_model.dart';
import 'package:graineasy/ui/view/forgot_password/forgot_password_model.dart';
import 'package:graineasy/ui/view/home/home_view_model.dart';
import 'package:graineasy/ui/view/item_details/details_view_model.dart';
import 'package:graineasy/ui/view/login/login_view_model.dart';
import 'package:graineasy/ui/view/registration/registration_view_model.dart';

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
}
