import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/address.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';
import 'package:graineasy/model/user.dart';

import '../account_view.dart';

class AddUpdateAddressViewModel extends BaseModel {
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
  bool isUpdateAddress = false;

  init(Address addresses) async {
    if (isFirstTime) {
      isFirstTime = false;
      setState(ViewState.Busy);
      cityList = await API.getCityList();
      if (addresses != null) {
        setAddressData(addresses);
        isUpdateAddress = true;
      }
      setState(ViewState.Idle);
    }
  }

  addAddressesBtnClick(
      String partyName,
      String phone,
      String gstInNo,
      String address,
      String selectedState,
      String selectedCity,
      String selectedAddressType,
      String pinCode,
      Address addresses) async {
    User user = await UserPreferences.getUser();

//    if(isUpdateAddress)
    setState(ViewState.Busy);
    print(selectedCity);
    await API.addAddresses(partyName, phone, gstInNo, address, selectedCity,
        selectedState, selectedAddressType, pinCode);
    setState(ViewState.Idle);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountVIew(user)));
  }

  void setAddressData(Address addresses) {
    partyNameController.text = addresses.addridentifier == null
        ? 'partyName'
        : addresses.addridentifier.partyname;
    gstInController.text = addresses.addridentifier == null
        ? 'gstIn'
        : addresses.addridentifier.gstin;
    addressController.text = addresses.text;
    for (City city in cityList) {
      if (city.id == addresses.city.id) {
        selectedCity = city;
      }
    }
    selectedAddressType = addresses.addresstype;

    phoneNumberController.text = addresses.phone;
    pinCodeController.text = addresses.pin;
  }

  Future updateAddress(Address address) async {
    User user = await UserPreferences.getUser();

    if (isUpdateAddress) setState(ViewState.Busy);
    await API.updateAddress(
        address.id,
        addressController.text,
        pinCodeController.text,
        selectedCity.id,
        selectedCity.state.id,
        phoneNumberController.text,
        selectedAddressType);
    setState(ViewState.Idle);
    Navigator.pop(context);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountVIew(user)));
    API.getAddress(address.phone, address.id);
  }

  Future addUpdateAddress(Address addresses) async {
    if (isUpdateAddress == true) {
      updateAddress(addresses);
    } else
      addAddressesBtnClick(
          partyNameController.text,
          phoneNumberController.text,
          gstInController.text,
          addressController.text,
          selectedCity.id,
          selectedCity.state.id,
          selectedAddressType,
          pinCodeController.text,
          addresses);
    print(selectedCity.name);
  }

//	//countered
//rejected
//accepted
}
