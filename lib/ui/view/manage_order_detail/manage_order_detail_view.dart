import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graineasy/helpers/functions/orders.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/order.dart';
import 'package:graineasy/ui/theme/app_responsive.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/validation/validation.dart';
import 'package:graineasy/ui/view/manage_order_detail/manage_order_detail_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:graineasy/utils/check_internet/utility.dart';
import 'package:graineasy/utils/ui_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graineasy/manager/api_call/api_config/api_config.dart';

const URL = "https://graineasy.com";

class ManageOrderDetailView extends StatefulWidget {
  Order orderList;
  String id;
  ManageOrderDetailView({this.orderList, this.id});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<ManageOrderDetailView> with CommonAppBar {
  String status;
  final orderKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ManageOrderDetailViewModel>(
        builder: (context, model, child) {
          model.init(widget.id, widget.orderList);
          return new Scaffold(
            appBar: new AppBar(
              title: Text('Order Details'),
              backgroundColor: Colors.white,
            ),
            body: _getBody(model),
          );
        });
  }

  Widget _getBody(ManageOrderDetailViewModel model) {
    return Stack(
      children: <Widget>[
        model.order != null ? model.order.item != null ? _getBaseContainer(
            model) : Container() : Container(),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(ManageOrderDetailViewModel model) {
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

  _getBaseContainer(ManageOrderDetailViewModel model) {
    return SingleChildScrollView(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          orderDetailList(model),
          Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Update Order Status:',
                style: TextStyle(
                    color: Palette.assetColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButton<String>(
              underline: Container(
                decoration: BoxDecoration(
                    border:
                    Border(bottom: BorderSide(color: Palette.assetColor))),
              ),
              isExpanded: true,
              elevation: 4,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Palette.assetColor,
              ),
              hint: new Text(
                model.selectedOrderStatus != null
                    ? model.selectedOrderStatus
                    : model.order.status,
                style: AppTextStyle.getLargeHeading(false, Palette.assetColor),
              ),
              value: model.selectedOrderStatus,
              onChanged: (String selectedOrderStatus) {
                setState(() {
                  model.selectedOrderStatus = selectedOrderStatus;
                });
              },
              items: API.orderStatus.map((String status) {
                return new DropdownMenuItem<String>(
                  value: status,
                  child: new Text(
                    status,
                    style: TextStyle(color: Palette.assetColor),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
            child: model.selectedOrderStatus == 'cancelled'
                ? getTextFormField(model)
                : Container(),
          ),
          API.user!=null && API.user.isAdmin==true?Container(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            child: Column(
              children: <Widget>[
                GestureDetector(child: Container(padding: EdgeInsets.only(left: 10),
                  alignment:Alignment.centerLeft,
                  child: Text(model.order!=null && model.order.manualbill!=null?"Uploaded Image: "+model.order.manualbill.filename:''),),
                  onTap: (){
//                  print('data');
//                  model.downloadImage(model);
                  launch(ApiConfig.baseURL+'uploadbill/'+ model.order.id);
                  },),

                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(alignment: Alignment.bottomLeft,child: Container(width: 180,child: Text(model.filePath!=null?model.filePath.path:'No File Selected'),)),
                  Container(child: RaisedButton(
                    color: Palette.assetColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    child: Text('Upload',textAlign: TextAlign.center,
                        style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),
                    onPressed: (){
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return SimpleDialog(
                            title: new Text('Select the Option'),
                            children: <Widget>[
                              // usually buttons at the bottom of the dialog
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Container(child: RaisedButton(onPressed: (){openImage(model);

                                  },
                                    color: Palette.assetColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text('Image Upload',textAlign: TextAlign.center,
                                        style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
                                  ),
                                  Container(child: RaisedButton(onPressed: (){openImage(model);},
                                    color: Palette.assetColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text('Image Upload',textAlign: TextAlign.center,
                                        style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
                                  ),
                                  Container(child: RaisedButton(onPressed: (){openImage(model);},
                                    color: Palette.assetColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text('Image Upload',textAlign: TextAlign.center,
                                        style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
                                  ),
                                ],)
                            ],
                          );
                        },
                      );
                    },),
//                      Padding(
//                        padding: const EdgeInsets.only(top: 15),
//                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Container(child: RaisedButton(onPressed: (){openImage(model);},
//                              color: Palette.assetColor,
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(7)),
//                              child: Text('Image Upload',textAlign: TextAlign.center,
//                                  style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
//                              width: 100,),
//                            Container(width: 100,
//                              child: RaisedButton(onPressed: (){openCamera(ImageSource.camera, model);},
//                                color: Palette.assetColor,
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(7)),
//                                child: Text('Camera Upload',textAlign: TextAlign.center, style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
//                            ),
//                            Container(width: 100,
//                              child: RaisedButton(onPressed: (){openPdf(model);},
//                                color: Palette.assetColor,
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(7)),
//                                child: Text('PDF   Upload',textAlign: TextAlign.center,
//                                    style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
//                            )
//                          ],),
                      )
                    ],
                  ),
                )
              ],
            ),
          ):Column(children: <Widget>[
            GestureDetector(child: Container(padding: EdgeInsets.only(left: 10),alignment:Alignment.centerLeft,child: Text(model.order!=null && model.order.manualbill!=null?model.order.manualbill.filename:''),),
            onTap: (){print('data');
            model.downloadImage(model);
            },),
            model.order.manualbill==null?Container(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(alignment: Alignment.bottomLeft,child: Container(width: 180,child: Text(model.filePath!=null?model.filePath.path:'No File Selected'),)),
                 Container(child: RaisedButton(
                   color: Palette.assetColor,
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(7)),
                   child: Text('Upload',textAlign: TextAlign.center,
                       style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),
                 onPressed: (){
                  return showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       // return object of type Dialog
                       return SimpleDialog(
                         title: new Text('Select the Option'),
                         children: <Widget>[
                           // usually buttons at the bottom of the dialog
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                              Container(child: RaisedButton(onPressed: (){openImage(model);

                              },
                                color: Palette.assetColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                child: Text('Image Upload',textAlign: TextAlign.center,
                                    style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
                              ),
                              Container(child: RaisedButton(onPressed: (){openImage(model);},
                                color: Palette.assetColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                child: Text('Image Upload',textAlign: TextAlign.center,
                                    style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
                              ),
                              Container(child: RaisedButton(onPressed: (){openImage(model);},
                                color: Palette.assetColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                child: Text('Image Upload',textAlign: TextAlign.center,
                                    style: AppTextStyle.drawerText(false, Palette.whiteTextColor, 12)),),
                              ),
                            ],)
                         ],
                       );
                     },
                   );
                 },),
                   width: 100,)
                ],
              ),
            ):Container()
          ],),
          updateOrderButton(model)
        ],
      ),
    );
  }

  orderDetailList(ManageOrderDetailViewModel model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            color: Palette.whiteTextColor,
            child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: 200,
                child:
                WidgetUtils.getCategoryImage(model.order.item.image)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
            child: new Text(
              model.order.item.name,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Order No: " + model.order.orderno,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Amount: " + "\u20B9" + model.order.cost.toString(),
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Quantity: " + model.order.quantity.toString() + " " + model.order.unit,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Order Type: " + model.order.ordertype,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Status: " + model.order.status,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Text(
              "Address: " + getShippingAddress(model.order),
//                  model.order.item.address.text +
//                  "" +
//                  model.order.item.address.city.name,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10, top: 3),
            child: new Text(
              "Order Date: " +
                  Utility.dateToString(model.order.placedTime),
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.assetColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

//            Padding(
//              padding: const EdgeInsets.only(left: 10),
//              child: Text(
//                'To Deliver On :' +
//                    Utility.dateTimeToString(
//                       widget.orderList.placedTime),
//                style: TextStyle(
//                    fontSize: 14.0, color:Palette.assetColor),
//              ),
//            ),
          UIHelper.verticalSpaceSmall1,
        ],
      ),
    );
  }

  getTextFormField(ManageOrderDetailViewModel model) {
    return Form(
      key: orderKey,
      child: TextFormField(
        controller: model.remarkController,
        focusNode: model.remarkFocus,
        validator: (value) {
          return Validation.validateRemark(value);
        },
        style: TextStyle(
          color: Palette.assetColor,
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Remark',
          disabledBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Palette.assetColor),
          ),
          focusedBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Palette.assetColor),
          ),
          enabledBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Palette.assetColor),
          ),
          errorBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Palette.assetColor),
          ),
          border: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Palette.assetColor),
          ),

//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(25.0)),
          hintStyle: TextStyle(
            color: Palette.assetColor,
          ),
        ),
      ),
    );
  }

  getUpdateBtn(ManageOrderDetailViewModel model) {
    var _onPressed;

    if (model.order.status != 'cancelled'){
        _onPressed = () {
//          if (orderKey.currentState.validate())
            model.updateStatus(model.order.id);

      };
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        color: Palette.loginBgColor,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(
          'Update Order',
          style: AppTextStyle.commonTextStyle(
              Palette.whiteTextColor,
              AppResponsive.getFontSizeOf(30),
              FontWeight.bold,
              FontStyle.normal),
        ),
        onPressed: _onPressed,
      ),
    );
  }

  updateOrderButton(ManageOrderDetailViewModel model) {
    if (model.selectedOrderStatus == null)
      return Container();
    if (model.selectedOrderStatus != null)
      return getUpdateBtn(model);
//    if (model.selectedOrderStatus == 'cancelled')
//      return Container();
  }

   openPdf(ManageOrderDetailViewModel model)
  async {
    File file;
     file = await FilePicker.getFile(type: FileType.CUSTOM,fileExtension: 'pdf');
    setState(() {
      model.filePath=file;
      print('filePath===>${file}');
    });
    model.uploadFile(model);
    Navigator.pop(context);

  }

   openImage(ManageOrderDetailViewModel model)
  async {
    File file;
    file = await FilePicker.getFile(type: FileType.IMAGE);
    setState(() {
      model.filePath=file;
      print('filePath===>${file}');
    });
    model.uploadFile(model);
    Navigator.pop(context);
  }
  openCamera(ImageSource source, ManageOrderDetailViewModel model) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      model.filePath = image;
    });
    model.uploadFile(model);
    Navigator.pop(context);

  }

}
