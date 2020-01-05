import 'package:graineasy/exception/data_exception.dart';
import 'package:graineasy/manager/api_call/register_user.dart';

abstract class RegisterListener {
  // result of API
  void goToLogin(String result);
  void errorObtained(String error, int errorCode, String methodName);
}

class RegisterDataManager {
  RegisterListener listener;
  static const String REGISTER = "REGISTER";

  void register(String firstName, String lastName,String email,String phoneNumber,String password) async {
    RegisterUser user = RegisterUser();
    user.registerUser(firstName,lastName,email,phoneNumber,password).then((users) {
      // TODO change logic
      if (user != null) {
        listener.goToLogin(users);
      } else {
        listener.errorObtained('Invalid data', 202, REGISTER);
      }
    }).catchError((onError) {
      int errorCode = DataException.errorUnknown;
      if (onError is DataException) {
        var dataException = onError;
        errorCode = dataException.getErrorCode();
      }
      String error = onError.toString();
//      print('error=============>' + error);

      if (listener != null) {
        listener.errorObtained(error, errorCode, REGISTER);
      }
    });
  }


}
