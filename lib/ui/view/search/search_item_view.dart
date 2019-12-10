import 'package:flutter/material.dart';
import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/manufacturer.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';
import 'package:graineasy/ui/theme/widget.dart';
import 'package:graineasy/ui/view/item_details/details_view.dart';
import 'package:graineasy/ui/view/search/search_item_view_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';

class SearchItemView extends StatefulWidget {
  @override
  _SearchItemViewState createState() => _SearchItemViewState();
}

class _SearchItemViewState extends State<SearchItemView> with CommonAppBar {
  var searchItemFocus = new FocusNode();
  TextEditingController searchItemController = new TextEditingController();
  bool firstCheckBox = false;
  bool secondCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchItemViewModel>(builder: (context, model, child) {
      model.init();
      model.manufacturerList = model.manufacturerItem;
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Search'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  _getBody(SearchItemViewModel model) {
    return Stack(
      children: <Widget>[
        searchWidget(model),
//        _getBaseContainer(model),
        getProgressBar(model.state)
      ],
    );
  }

  searchWidget(SearchItemViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Theme(data: Theme.of(context).copyWith(
                          canvasColor: Palette.blackTextColor),
                        child: DropdownButton<Manufacturer>(
                          underline: Container(decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))
                          ),),
                          isExpanded: true,
                          elevation: 4,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Palette.assetColor,
                          ),
                          hint: new Text("Select Manufacturer",
                            style: AppTextStyle.getLargeHeading(false,
                                Palette.assetColor),),
                          value: model.selectedManufacturer,
                          onChanged: (Manufacturer newValue) {
                            setState(() {
                              model.selectedManufacturer = newValue;
                            });
                          },
                          items: model.manufacturerList.map((Manufacturer mfg) {
                            return new DropdownMenuItem<Manufacturer>(
                              value: mfg,
                              child: new Text(
                                mfg.name,
                                style: new TextStyle(
                                    color: Palette.assetColor),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      DropdownButton<String>(
                        underline: Container(
                          decoration: BoxDecoration(
                              border:
                              Border(bottom: BorderSide(
                                  color: Palette.assetColor))),
                        ),
                        isExpanded: true,
                        elevation: 4,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Palette.assetColor,
                        ),
                        hint: new Text('Select Grade',
                          style: AppTextStyle.getLargeHeading(
                              false, Palette.assetColor),
                        ),
                        value: model.selectedGrade,
                        onChanged: (String selectedOrderStatus) {
                          setState(() {
                            model.selectedGrade = selectedOrderStatus;
                            model.searchText(model.selectedGrade);
                            searchItemController.text = model.selectedGrade;
                          });
                        },
                        items: API.grade.map((String status) {
                          return new DropdownMenuItem<String>(
                            value: status,
                            child: new Text(
                              status,
                              style: TextStyle(color: Palette.assetColor),
                            ),
                          );
                        }).toList(),
                      ),
                      TextField(
                        autofocus: true,
                        controller: searchItemController,
                        style: AppWidget.darkTextFieldTextStyle(),
                        keyboardType: TextInputType.text,
                        decoration: AppWidget.darkTextField(
                            'Search by name, sku, id'),
                        onChanged: (String searchString) {
                          if (searchString.length > 0) {
                            model.searchText(model.selectedGrade);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
//              Column(
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Checkbox(
//                        value: firstCheckBox,
//                        onChanged: (bool value) {
//                          setState(() {
//                            firstCheckBox = value;
//                            if (firstCheckBox == true) {
//                              model.getRecentlyAddedItem();
//                              getCategoryWidget(model);
//                            }
//                          });
//                        },
//                      ),
//                      Text('Test1', style: TextStyle(fontSize: 15),),
//
//                    ],
//                  ),
//                  Row(
//                    children: <Widget>[
//                      Checkbox(
//                        value: secondCheckBox,
//                        onChanged: (bool value) {
//                          setState(() {
//                            secondCheckBox = value;
//                            if (secondCheckBox == true) {
//                              model.getRecentlyAddedItem();
//                              getCategoryWidget(model);
//                            }
//                          });
//                        },
//                      ),
//                      Text('Test2', style: TextStyle(fontSize: 15),),
//
//                    ],
//                  ),
//                ],
//              )
            ],
          ),
          getCategoryWidget(model),


        ],
      ),
    );
  }

  getCategoryWidget(SearchItemViewModel model) {
    return Expanded(
      child: new GridView.builder(
          itemCount: model.items.length,
          padding: const EdgeInsets.all(5.0),
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsView(
                                item: model.items[index],
                              )));
                },
                child: new Card(
                  elevation: 3.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: model.items[index].image != null
                              ? WidgetUtils.getCategoryImage(
                                  model.items[index].image)
                              : Icon(Icons.refresh)),
                      Container(
                        color: Colors.black38,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            //margin: EdgeInsets.only(left: 10.0),
                            padding: EdgeInsets.only(left: 3.0, bottom: 3.0),
                            alignment: Alignment.bottomLeft,
                            child: new Text(
                              model.items[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
//                        Container(
//                          alignment: Alignment.bottomRight
//                          ,child: Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            crossAxisAlignment: CrossAxisAlignment.end
//                            ,children: <Widget>[
//
//                          Padding(
//                            padding: const EdgeInsets.only(bottom: 3),
//                            child: InkWell(child: Image.asset('images/whatsapp.png',width: 30,height: 25,),
//                            onTap: (){
//                          _launchWhatsApp(model.items[index]);
//                            },),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(left: 3,right: 1,bottom: 3),
//                            child: InkWell(child: Image.asset('images/mail.png',width: 25,height: 25,),
//                            onTap: (){
//                              _launchEmail(model.items[index]);
//
//                            },),
//                          )
//                          ],
//                          ),
//                        ),
                        ],
                      ),
                    ],
                  ),
                ));
          }),
    );
  }

//  getRecentData(SearchItemViewModel model) {
//    return Expanded(
//      child: new GridView.builder(
//          itemCount: model.items.length,
//          padding: const EdgeInsets.all(5.0),
//          gridDelegate:
//          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//          itemBuilder: (BuildContext context, int index) {
//            return new GestureDetector(
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => DetailsView(
//                            item: model.items[index],
//                          )));
//                },
//                child: new Card(
//                  elevation: 3.0,
//                  child: Stack(
//                    children: <Widget>[
//                      Positioned.fill(
//                          child: model.items[index].image != null
//                              ? WidgetUtils.getCategoryImage(
//                              model.items[index].image)
//                              : Icon(Icons.refresh)),
//                      Container(
//                        color: Colors.black38,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                        children: <Widget>[
//                          Container(
//                            //margin: EdgeInsets.only(left: 10.0),
//                            padding: EdgeInsets.only(left: 3.0, bottom: 3.0),
//                            alignment: Alignment.bottomLeft,
//                            child: new Text(
//                              model.items[index].name,
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  fontSize: 20.0,
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),
////                        Container(
////                          alignment: Alignment.bottomRight
////                          ,child: Row(
////                            mainAxisAlignment: MainAxisAlignment.end,
////                            crossAxisAlignment: CrossAxisAlignment.end
////                            ,children: <Widget>[
////
////                          Padding(
////                            padding: const EdgeInsets.only(bottom: 3),
////                            child: InkWell(child: Image.asset('images/whatsapp.png',width: 30,height: 25,),
////                            onTap: (){
////                          _launchWhatsApp(model.items[index]);
////                            },),
////                          ),
////                          Padding(
////                            padding: const EdgeInsets.only(left: 3,right: 1,bottom: 3),
////                            child: InkWell(child: Image.asset('images/mail.png',width: 25,height: 25,),
////                            onTap: (){
////                              _launchEmail(model.items[index]);
////
////                            },),
////                          )
////                          ],
////                          ),
////                        ),
//                        ],
//                      ),
//
//                      /*Positioned(
//                                      child: FittedBox(
//
//                                       fit: BoxFit.fill,
//                                        alignment: Alignment.centerLeft,
//                                        child: Text(photos[index].title,
//                                          style: TextStyle(color: Colors.black87,fontSize: 15.0),
//                                        ),
//
//                                    )
//                                    )*/
//                    ],
//                  ),
//                ));
//          }),
//    );
//  }

}
