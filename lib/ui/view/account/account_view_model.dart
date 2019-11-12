import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/usermodel.dart';

class AccountViewModel extends BaseModel {
  UserModel userModel;

  bool isFirstTime = true;

  getAddress() async {
    setState(ViewState.Busy);
    userModel = await API.getUserDetail();
    isFirstTime = false;
    setState(ViewState.Idle);
  }

  void init() {
    if (isFirstTime) {
      getAddress();
//        isFirstTime = false;

    }
  }
}
