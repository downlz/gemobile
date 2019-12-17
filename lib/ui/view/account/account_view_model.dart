import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/bankaccount.dart';
import 'package:graineasy/model/user.dart';

class AccountViewModel extends BaseModel {
  List<Address> addresses = [];
  List<BankAccount> bankacc = [];
//  User user;

  bool isFirstTime = true;

  getAddress(String phone, String id) async {
    setState(ViewState.Busy);
    addresses = await API.getAddress(phone, id);
    setState(ViewState.Idle);
  }

  getBankAccount(String id) async {
    setState(ViewState.Busy);
    bankacc = await API.getUserBankAccount(id);
    setState(ViewState.Idle);
  }

  Future init(String phone, String id) async {
    if (isFirstTime) {
      getAddress(phone, id);
      getBankAccount(id);
      isFirstTime = false;
    }
  }

  getUserDetail() async {
    User user = await UserPreferences.getUser();
    print(user.name);

  }
}
