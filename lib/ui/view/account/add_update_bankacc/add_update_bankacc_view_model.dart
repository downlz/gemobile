import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/bankaccount.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';
import 'package:graineasy/model/user.dart';

import '../account_view.dart';

class AddUpdateBankAccViewModel extends BaseModel {
  bool isListEmpty = false;
  List<StateObject> stateList = [];
  List accTypesList = ['Current', 'Savings' ,'Nodal'];
  List accPreferencesList = ['Primary', 'Secondary', 'Tertiary','Others'];
  TextEditingController accNameController = new TextEditingController();
//  TextEditingController accTypeController = new TextEditingController();
  TextEditingController accNoController = new TextEditingController();
//  TextEditingController micrController = new TextEditingController();
  TextEditingController ifscController = new TextEditingController();
//  TextEditingController accPrefController = new TextEditingController();

  City selectedCity;
  String selectedAddressType;
  bool isFirstTime = true;
  bool isUpdateBankAccount = false;

  init(BankAccount bankacc) async {
    if (isFirstTime) {
      isFirstTime = false;
      setState(ViewState.Busy);
//      cityList = await API.getCityList();
      if (bankacc != null) {
        setBankAccountData(bankacc);
        isUpdateBankAccount = true;
      }
      setState(ViewState.Idle);
    }
  }

  addBankAccountBtnClick(
      String name,
      String accountNo,
      String ifsc,
//      String address,
//      String selectedState,
//      String selectedCity,
//      String selectedAddressType,
//      String pinCode,
      BankAccount bankacc) async {
    User user = await UserPreferences.getUser();

//    if(isUpdateBankAccount)
    setState(ViewState.Busy);
    await API.addBankAccount(name,accountNo,ifsc);
    setState(ViewState.Idle);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountVIew(user)));
  }

  void setBankAccountData(BankAccount bankacc) {
//    partyNameController.text = bankacc.addridentifier == null
//        ? 'partyName'
//        : bankacc.addridentifier.partyname;
//    gstInController.text = bankacc.addridentifier == null
//        ? 'gstIn'
//        : bankacc.addridentifier.gstin;
//    addressController.text = bankacc.text;
//    for (City city in cityList) {
//      if (city.id == bankacc.city.id) {
//        selectedCity = city;
//      }
//    }
//    selectedAddressType = bankacc.addresstype;

    accNameController.text = bankacc.name;
    accNoController.text = bankacc.accountNo;
    ifscController.text = bankacc.ifsc;
    
  }

  Future updateBankAccount(BankAccount bankacc) async {
    User user = await UserPreferences.getUser();

    if (isUpdateBankAccount) setState(ViewState.Busy);
    await API.updateBankAccount(
        accNameController.text,
        accNoController.text,
        ifscController.text,
        bankacc.id);
    setState(ViewState.Idle);
    Navigator.pop(context);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountVIew(user)));
    API.getUserBankAccount(user.id);
  }

  Future addUpdateBankAccount(BankAccount bankacc) async {
    if (isUpdateBankAccount == true) {
      updateBankAccount(bankacc);
    } else
      addBankAccountBtnClick(
          accNameController.text,
          accNoController.text,
          ifscController.text,
          bankacc);
  }
}
