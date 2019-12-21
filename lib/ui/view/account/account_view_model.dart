import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/bankaccount.dart';
import 'package:graineasy/model/agentbuyer.dart';
import 'package:graineasy/model/user.dart';

class AccountViewModel extends BaseModel {
  List<Address> addresses = [];
  List<BankAccount> bankacc = [];
  List<AgentBuyer> agentbuyer = [];
  User user;
  bool checkAgent;
  bool checkAdmin;

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

  getAgentBuyer(String id) async {
    setState(ViewState.Busy);
    agentbuyer = await API.getUserAgentBuyer(id);
    setState(ViewState.Idle);
  }

  Future init(String phone, String id) async {
    if (isFirstTime) {
      setState(ViewState.Busy);
//      getAddress(phone, id);
//      getBankAccount(id);
//      getAgentBuyer(id);
      user = await UserPreferences.getUser();
      checkAdmin = user.isAdmin;
      checkAgent = user.isAgent;
      addresses = await API.getAddress(phone, id);
      bankacc = await API.getUserBankAccount(id);
      agentbuyer = await API.getUserAgentBuyer(id);

      isFirstTime = false;
      setState(ViewState.Idle);
      notifyListeners();
//      getUserDetail();
//      isFirstTime = false;

    }

  }

  getUserDetail() async {
    User user = await UserPreferences.getUser();
//    user = await UserPreferences.getUser();
  }
}
