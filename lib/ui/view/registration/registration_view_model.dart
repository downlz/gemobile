import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';

class RegistrationViewModel extends BaseModel
{
  bool isListEmpty = false;
  List<States> stateList = [];
  List<City> cityList = [];

  bool isFirstTime = true;

  getState() async
  {
//    setState(ViewState.Busy);
    stateList = await API.getStateList();
    cityList = await API.getCityList();

    print('sxxxsxxxxs==>${stateList.length}');
    print('sxxxsxxxxs==>${cityList.length}');
    notifyListeners();
//    setState(ViewState.Idle);
  }

  void init() {
    if (isFirstTime) {
      getState();
      isFirstTime = false;
    }
  }

  registerBtnIsClicked(String name, String email, String phone, String password,
      String gst, String address, String city, String state,
      String pincode) async {
    setState(ViewState.Busy);
    await API.register(
        name,
        email,
        phone,
        password,
        gst,
        address,
        city,
        state,
        pincode);
    setState(ViewState.Idle);
  }


}