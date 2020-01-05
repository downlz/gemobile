import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/agentbuyer.dart';
import 'package:graineasy/model/bankaccount.dart';
import 'package:graineasy/model/user.dart';


class AccountViewModel extends BaseModel {
  List<Address> addresses = [];
  List<BankAccount> bankacc;
  List<AgentBuyer> agentbuyer = [];
  User user;
  bool checkAgent;
  bool checkAdmin;
  String emptyAddrMsg = '';

  bool isFirstTime = true;

  init(String phone, String id) async {
    if (isFirstTime) {
//      await getAddress(phone, id);
//      await getBankAccount(id);
//      await getAgentBuyer(id);
      user = await UserPreferences.getUser();
      checkAdmin = user.isAdmin;
      checkAgent = user.isAgent;
//      addresses = await API.getAddress(phone, id);
//      bankacc = await API.getUserBankAccount(id);
//      agentbuyer = await API.getUserAgentBuyer(id);
      getAddress(phone, id);
      getBankAccount(id);
      getAgentBuyer(id);

      isFirstTime = false;
//      notifyListeners();
//      getUserDetail();
//      isFirstTime = false;

    }
//    SchedulerBinding.instance.addPostFrameCallback((_) => setState((ViewState.Idle)));
//    WidgetsBinding.instance.addPostFrameCallback((_) => setState((ViewState.Idle)));
  }

  Future getAddress(String phone, String id) async {
    setState(ViewState.Busy);
    addresses = await API.getAddress(phone, id);
    if (addresses.length == 0) emptyAddrMsg='No address found.Add an address to continue';
    setState(ViewState.Idle);
  }

  Future getBankAccount(String id) async {
    setState(ViewState.Busy);
    bankacc = await API.getUserBankAccount(id);
    setState(ViewState.Idle);
  }

  Future getAgentBuyer(String id) async {
    setState(ViewState.Busy);
    agentbuyer = await API.getUserAgentBuyer(id);
    setState(ViewState.Idle);
  }

//  Future getUserDetail() async {
////    User user = await UserPreferences.getUser();
//    user = await UserPreferences.getUser();
//  }
}
