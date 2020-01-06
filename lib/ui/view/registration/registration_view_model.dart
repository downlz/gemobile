import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/model/state.dart';
import 'package:graineasy/model/usermodel.dart';
import 'package:graineasy/helpers/showDialogSingleButton.dart';
import 'package:graineasy/ui/view/login/login_view.dart';

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
    API.updateUserApiToGetFCMKey();
    UserModel users = await UserPreferences.getFCMDeviceDtl();
    print('FCM KEY=========>${users.fcmkey}');
    print('FCM KEY=========>${users.devicedtl}');
    setState(ViewState.Idle);
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: ListTile(
              title: Text('Registration',style: TextStyle(color: Colors.blueGrey,fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text("You have successfully registered with graineasy.You shall be able to use graineasy services once your account is activated.You shall receive an email on account activation") ,
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