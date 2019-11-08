import 'package:flutter/material.dart';
import 'package:graineasy/HomeScreen.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/listeners/register_listener.dart';
import 'package:graineasy/ui/localization/app_localization.dart';
import 'package:graineasy/utils/check_internet/utility.dart';

class RegistrationViewModel extends BaseModel
{

//  String fName,lName,mobile,pasword,emailId;
//  void registerBtnIsClicked(String firstName, String lastName, String email, String phoneNumber, String password)
//  {
//    fName = firstName;
//    lName=lastName;
//    emailId=email;
//    mobile=phoneNumber;
//    pasword=password;
//    sendDataToServer(fName,lName,emailId,mobile,pasword);
//  }
//
//  @override
//  void errorObtained(String error, int errorCode, String methodName) {
//    showMessage(error, isError);
//    setState(ViewState.Idle);
//  }
//
//  @override
//  void goToLogin(String result) {
//    setState(ViewState.Idle);
//    showMessage(result, isError);
//    Navigator.pushAndRemoveUntil(
//        context, MaterialPageRoute(builder: (context)=> Home_screen()), (Route<dynamic> route) => false);
//  }
//
//  void sendDataToServer(String fName, String lName, String emailId, String mobile, String pasword)
//  {
//    Utility.isInternetAvailable().then((isConnected) async {
//      if (isConnected) {
//        setState(ViewState.Busy);
//        RegisterDataManager loginDataManager = RegisterDataManager();
//        loginDataManager.listener = this;
//        loginDataManager.register(fName, lName,emailId,mobile,pasword);
//      } else {
//        showMessage(AppLocalizations.of(context).noInternet, true);
//      }
//    });
//  }


}