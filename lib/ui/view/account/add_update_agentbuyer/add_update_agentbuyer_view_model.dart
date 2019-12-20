import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/agentbuyer.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';
import 'package:graineasy/model/user.dart';

import '../account_view.dart';

class AddUpdateAgentBuyerViewModel extends BaseModel {
  bool isListEmpty = false;
  List<StateObject> stateList = [];
  List<City> cityList = [];
  TextEditingController partyNameController = new TextEditingController();
  TextEditingController gstInController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController pinCodeController = new TextEditingController();


  City selectedCity;
  String selectedAddressType;
  bool isFirstTime = true;
  bool isUpdateAgentBuyer = false;

  init(AgentBuyer agentbuyer) async {
    if (isFirstTime) {
      isFirstTime = false;
      setState(ViewState.Busy);
      cityList = await API.getCityList();
      if (agentbuyer != null) {
        setAgentBuyerData(agentbuyer);
        isUpdateAgentBuyer = true;
      }
      setState(ViewState.Idle);
    }
  }

  addAgentBuyerBtnClick(
      String partyName,
      String phone,
      String gstInNo,
      String address,
      String selectedState,
      String selectedCity,
      String pinCode,
      AgentBuyer agentbuyer) async {
    User user = await UserPreferences.getUser();

//    if(isUpdateBankAccount)
    setState(ViewState.Busy);
    await API.addAgentBuyer(partyName, phone, gstInNo, address, selectedCity,
        selectedState, pinCode);
    setState(ViewState.Idle);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountVIew(user)));
  }

  void setAgentBuyerData(AgentBuyer agentbuyer) {

    partyNameController.text = agentbuyer.agentbuyeridentifier == null
        ? 'partyName'
        : agentbuyer.agentbuyeridentifier.partyname;
    gstInController.text = agentbuyer.agentbuyeridentifier == null
        ? 'gstIn'
        : agentbuyer.agentbuyeridentifier.gstin;
    addressController.text = agentbuyer.text;
    for (City city in cityList) {
      if (city.id == agentbuyer.city.id) {
        selectedCity = city;
      }
    }
//    selectedAddressType = addresses.addresstype;

    phoneNumberController.text = agentbuyer.phone;
    pinCodeController.text = agentbuyer.pin;
    
  }

  Future updateAgentBuyer(AgentBuyer agentbuyer) async {
    User user = await UserPreferences.getUser();

    if (isUpdateAgentBuyer) setState(ViewState.Busy);
    await API.updateAgentBuyer(
        agentbuyer.id,
        addressController.text,
        pinCodeController.text,
        selectedCity.id,
        selectedCity.state.id,
        phoneNumberController.text
        );
    setState(ViewState.Idle);
    Navigator.pop(context);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountVIew(user)));
    API.getUserBankAccount(user.id);
  }

  Future addUpdateAgentBuyer(AgentBuyer agentbuyer) async {

    if (isUpdateAgentBuyer == true) {
      updateAgentBuyer(agentbuyer);
    } else
      addAgentBuyerBtnClick(
          partyNameController.text,
          phoneNumberController.text,
          gstInController.text,
          addressController.text,
          selectedCity.id,
          selectedCity.state.id,
          pinCodeController.text,
          agentbuyer);
  }
}
