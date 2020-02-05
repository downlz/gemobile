import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/manager/shared_preference/UserPreferences.dart';
import 'package:graineasy/model/creditrequest.dart';
import 'package:graineasy/model/user.dart';
import 'package:graineasy/model/status_ref.dart';
import 'package:graineasy/ui/view/home/home_view.dart';


class CreditProductModel extends BaseModel {
  bool isListEmpty = false;
  TextEditingController partyNameController = new TextEditingController();
  TextEditingController turnoverController = new TextEditingController();
  TextEditingController lastThreeTurnoverController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController tradeItemsController = new TextEditingController();

  CreditRequest creditrequest;
  bool isFirstTime = true;
  bool isUpdateCreditRqst = false;
  List<CreditRequest> creditrequestlist;
  StatusRef statusdesc;

  init() async {
    if (isFirstTime) {
      User user = await UserPreferences.getUser();
      getActiveRequest(user.id);
      isFirstTime = false;
    }
  }

  Future getActiveRequest(user) async {
    setState(ViewState.Busy);
    creditrequestlist = await API.getUserCreditRequest(user);
    if (creditrequestlist.length >= 1) {
      isUpdateCreditRqst = true;
      statusdesc = await API.getStatusFromRef('creditrequest',creditrequestlist[0].status);
    }

    setState(ViewState.Idle);
  }

  addCreditRqstClick(
      String annualturnover,
      String lastthreeturnovr,
      String tradeitems,
      String phone) async {

    setState(ViewState.Busy);

    await API.raiseCreditRequest(int.parse(annualturnover),int.parse(lastthreeturnovr),tradeitems,phone);
    setState(ViewState.Idle);
//    showDialogSingleButton(context, 'Credit Request', 'Your credit request is raised successfully. You will receive an email for this request', "OK");

    showUploadConfirmation();
//    await Navigator.pushReplacement(
//        context, MaterialPageRoute(builder: (context) => HomeView()));
  }

//  void setAddressData(Address addresses) {
//    partyNameController.text = addresses.addridentifier == null
//        ? 'partyName'
//        : addresses.addridentifier.partyname;
//    turnoverController.text = addresses.addridentifier == null
//        ? 'gstIn'
//        : addresses.addridentifier.gstin;
//    lastThreeTurnoverController.text = addresses.text;
//    for (City city in cityList) {
//      if (city.id == addresses.city.id) {
//        selectedCity = city;
//      }
//    }
//    selectedAddressType = addresses.addresstype;
//
//    phoneNumberController.text = addresses.phone;
//    tradeItemsController.text = addresses.pin;
//  }

  Future updateCreditRqst(CreditRequest creditrequest) async {
//    User user = await UserPreferences.getUser();
//
//    if (isUpdateCreditRqst) setState(ViewState.Busy);
//    await API.updateCreditRqst(
//        address.id,
//        lastThreeTurnoverController.text,
//        tradeItemsController.text,
//        selectedCity.id,
//        selectedCity.state.id,
//        phoneNumberController.text,
//        selectedAddressType);
//    setState(ViewState.Idle);
//    Navigator.pop(context);
//    await Navigator.pushReplacement(
//        context, MaterialPageRoute(builder: (context) => HomeView()));
//    API.getAddress(address.phone, address.id);
  }

  Future addUpdateCreditRqst(CreditRequest creditrequest) async {
    if (isUpdateCreditRqst == true) {
      updateCreditRqst(creditrequest);
    } else
      addCreditRqstClick(
          turnoverController.text,
          lastThreeTurnoverController.text,
          tradeItemsController.text,
        phoneNumberController.text);
  }

  showUploadConfirmation(){
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: ListTile(
              title: Text('Credit Request',style: TextStyle(color: Colors.blueGrey,fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text('Your credit request is raised successfully. You will receive an email for this request'),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Text('OK',style: TextStyle(color: Colors.blueGrey,fontSize: 20, fontWeight: FontWeight.bold),),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                HomeView()));
                      }
                  ),
                ],
              ),
            ],
            elevation: 2,
          ),
    );
  }

  updateStatus(String id) async {
    setState(ViewState.Busy);
    await API.updateCreditRqstStatus(id);
    setState(ViewState.Idle);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeView()));
  }

}
