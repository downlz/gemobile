import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/listeners/forgot_passwprd_listener.dart';
import 'package:graineasy/ui/localization/app_localization.dart';
import 'package:graineasy/ui/view/login/login_view.dart';
import 'package:graineasy/ui/view/router.dart';
import 'package:graineasy/utils/check_internet/utility.dart';

class ForgotPasswordModel extends BaseModel implements ForgotPasswordListener
{
  String phoneNo,panNo,gstinNo,pasword;
  void resetPswBtnIsClicked(String phone, String pan, String gstin, String password)
  {
    phoneNo =phone;
    panNo=pan;
    gstinNo=gstin;
    pasword=password;
    sendDataToServer(phoneNo, panNo,gstinNo,pasword);

  }


  @override
  void errorObtained(String error, int errorCode, String methodName) {
    showMessage(error, isError);
    setState(ViewState.Idle);
  }

  @override
  void goToLogin(String result) {
    setState(ViewState.Idle);
    showMessage(result, isError);
    print('password test');
    showUploadConfirmation();
//    Navigator.pushNamedAndRemoveUntil(context, Screen.Login.toString(), (Route<dynamic> route) => false);
  }

  void sendDataToServer(String phoneNo, String panNo, String gstinNo, String pasword)
  {
    Utility.isInternetAvailable().then((isConnected) async {
      if (isConnected) {
        setState(ViewState.Busy);
        ForgotPasswordManager loginDataManager = ForgotPasswordManager();
        loginDataManager.listener = this;
        loginDataManager.forgotPassword(phoneNo, panNo, gstinNo, pasword);
      } else {
        showMessage(AppLocalizations.of(context).noInternet, true);
      }
    });
  }

  showUploadConfirmation(){
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: ListTile(
              title: Text('Password Reset',style: TextStyle(color: Colors.blueGrey,fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text('Your password was reset successfully.Please login using new password'),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Text('Ok',style: TextStyle(color: Colors.blueGrey,fontSize: 20, fontWeight: FontWeight.bold),),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                LoginView()));
                      }
                  ),
                ],
              ),
            ],
            elevation: 2,
          ),
    );
  }

}