import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';

class RegistrationViewModel extends BaseModel
{
  bool isListEmpty = false;
  List<StateObject> stateList = [];
  List<City> cityList = [];

  bool isFirstTime = true;

  getCity() async
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
      getCity();
      isFirstTime = false;
    }
  }

  registerBtnIsClicked(String name, String email, String phone, String password,
      String gst, String address, String city, String state,
      String pinCode) async {
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
        pinCode);
    setState(ViewState.Idle);
    Navigator.pop(context);
  }


}