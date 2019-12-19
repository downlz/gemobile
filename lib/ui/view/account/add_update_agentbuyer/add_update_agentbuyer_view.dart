import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/agentbuyer.dart';
import 'package:graineasy/model/city.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/account/add_update_agentbuyer/add_update_agentbuyer_view_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/utils/ui_helper.dart';

class AddUpdateAgentBuyerView extends StatefulWidget {
  AgentBuyer agentbuyer;

  AddUpdateAgentBuyerView({this.agentbuyer});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<AddUpdateAgentBuyerView>
    with CommonAppBar {
  ShapeBorder shape;
  final addAddressScaffoldKey = GlobalKey<ScaffoldState>();
  final addAddressFormKey = GlobalKey<FormState>();
  var partyNameFocus = new FocusNode();
  var gstInFocus = new FocusNode();
  var addressFocus = new FocusNode();
  var phoneFocus = new FocusNode();
  var pinCodeFocus = new FocusNode();
  var emailFocus = new FocusNode();
  var passwordFocus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return BaseView<AddUpdateAgentBuyerViewModel>(
        builder: (context, model, child) {
          model.init(widget.agentbuyer);
          showMessage(model);
          return new Scaffold(
            appBar: new AppBar(
              title:
              Text(widget.agentbuyer == null ? 'Add Buyer' : "Update Buyer"),
              backgroundColor: Colors.white,
            ),
            key: addAddressScaffoldKey,
            backgroundColor: Palette.loginBgColor,
            body: _getBody(model),
          );
        });
  }

  Widget _getBody(AddUpdateAgentBuyerViewModel model) {
    return Stack(
      children: <Widget>[
        model.isFirstTime ? Container() : _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(AddUpdateAgentBuyerViewModel model) {
    try {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (model.shouldShowMessage) {
          model.messageIsShown();
          showErrorMessage(context, model.message, model.isError);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  _getBaseContainer(AddUpdateAgentBuyerViewModel model) {
    return new SingleChildScrollView(
      child: addAddressWidget(model),
    );
  }

  addAddressWidget(AddUpdateAgentBuyerViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: new Column(
        children: <Widget>[
          Form(
              key: addAddressFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                          controller: model.partyNameController,
                          focusNode: partyNameFocus,
                          style: AppWidget.darkWhiteTextFieldTextStyle(),
                          keyboardType: TextInputType.text,
                          decoration: AppWidget.whiteTextField('PartyName'),
                          validator: (value) {
                            return Validation.validateName(value);
                          },
                        ),
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                            controller: model.phoneNumberController,
                            focusNode: phoneFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return Validation.validateMobile(value);
                            },
                            decoration:
                            AppWidget.whiteTextField('Phone Number')),
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                            controller: model.gstInController,
                            focusNode: gstInFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validation.validateGstInNumber(value);
                            },
                            decoration:
                            AppWidget.whiteTextField('GSTIN Number')),
                        UIHelper.verticalSpaceSmall1,
                        TextFormField(
                            controller: model.addressController,
                            focusNode: addressFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validation.validateAddress(value);
                            },
                            decoration: AppWidget.whiteTextField('Address')),
                        UIHelper.verticalSpaceSmall1,
                        Theme(
                          data: Theme.of(context)
                              .copyWith(canvasColor: Palette.blackTextColor),
                          child: DropdownButton<City>(
                            underline: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.white))),
                            ),
                            isExpanded: true,
                            elevation: 4,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            hint: new Text(
                              "Select City",
                              style: AppTextStyle.getLargeHeading(
                                  false, Colors.white24),
                            ),
                            value: model.selectedCity,
                            onChanged: (City newValue) {
                              setState(() {
                                model.selectedCity = newValue;
                              });
                            },
                            items: model.cityList.map((City city) {
                              return new DropdownMenuItem<City>(
                                value: city,
                                child: new Text(
                                  city.name,
                                  style: new TextStyle(
                                      color: Palette.whiteTextColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        UIHelper.verticalSpaceSmall1,
                        Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                model.selectedCity == null
                                    ? 'StateName'
                                    : model.selectedCity.state.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            )),
//                        UIHelper.verticalSpaceSmall1,
//                        Theme(
//                          data: Theme.of(context)
//                              .copyWith(canvasColor: Palette.blackTextColor),
//                          child: DropdownButton<String>(
//                            underline: Container(
//                              decoration: BoxDecoration(
//                                  border: Border(
//                                      bottom: BorderSide(color: Colors.white))),
//                            ),
//                            isExpanded: true,
//                            elevation: 4,
//                            icon: Icon(
//                              Icons.arrow_drop_down,
//                              color: Colors.white,
//                            ),
//                            hint: new Text(
//                              "Select AddressType",
//                              style: AppTextStyle.getLargeHeading(
//                                  false, Colors.white38),
//                            ),
//                            value: model.selectedAddressType,
//                            onChanged: (String selectedAddressTypes) {
//                              setState(() {
//                                model.selectedAddressType =
//                                    selectedAddressTypes;
//                              });
//                            },
//                            items: API.addressType.map((String value) {
//                              return new DropdownMenuItem<String>(
//                                value: value,
//                                child: new Text(
//                                  value,
//                                  style:
//                                  TextStyle(color: Palette.whiteTextColor),
//                                ),
//                              );
//                            }).toList(),
//                          ),
//                        ),
                        UIHelper.verticalSpaceSmall,
                        TextFormField(
                            controller: model.pinCodeController,
                            focusNode: pinCodeFocus,
                            style: AppWidget.darkWhiteTextFieldTextStyle(),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return Validation.validatePin(value);
                            },
                            decoration: AppWidget.whiteTextField('Pincode')),
                        UIHelper.verticalSpaceMedium,
                        RaisedButton(
                          color: Palette.whiteTextColor,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
//                            'Add Address',
                            !model.isUpdateAgentBuyer
                                ? 'Add New Buyer'
                                : 'Update Buyer',
                            style: AppTextStyle.commonTextStyle(
                                Palette.loginBgColor,
                                AppResponsive.getFontSizeOf(30),
                                FontWeight.bold,
                                FontStyle.normal),
                          ),
                          onPressed: () {
//                          _submit();
                            if (addAddressFormKey.currentState.validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());

//                              if(widget.agentbuyer!=null)
//                              {
//                                model.isAddAddress;
//                                model.setAddressData(widget.agentbuyer);
//                              }
//                              else
//                              {
//                                !model.isAddAddress;
//                                model.addUpdateAddress(widget.agentbuyer);
//                              }

                              model.addUpdateAgentBuyer(widget.agentbuyer);
//                              model.addAddressesBtnClick(model.partyNameController.text,model.phoneNumberController.text,model.gstInController.text,model.addressController.text,model.selectedCity.state.name,model.selectedCity.id,model.selectedAddressType,model.pinCodeController.text);
                            }
                          },
                        ),
                        UIHelper.verticalSpaceMedium,
                      ]),
                ),
              ))
        ],
      ),
    );
  }
}
