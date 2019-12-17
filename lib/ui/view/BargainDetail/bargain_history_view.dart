import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/bargain.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/view/Bargain/bargain_view.dart';
import 'package:graineasy/ui/view/BargainDetail/bargain_history_view_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';
import 'package:graineasy/ui/widget/widget_utils.dart';
import 'package:graineasy/utils/check_internet/utility.dart';

class BargainHistoryView extends StatefulWidget {
  Bargain bargainList;
  String id;

  BargainHistoryView({this.id});

//  BargainHistoryView(this.bargainList);

  @override
  _BargainHistoryViewState createState() => _BargainHistoryViewState();
}

class _BargainHistoryViewState extends State<BargainHistoryView>
    with CommonAppBar {

  List<Bargain> bargain = new List<Bargain>();

  @override
  Widget build(BuildContext context) {
    return BaseView<BargainHistoryViewModel>(builder: (context, model, child) {
      model.init(widget.id, bargain, model.perPage, model.present);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Bargain History'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(BargainHistoryViewModel model) {
    return Stack(
      children: <Widget>[
        model.bargainList != null ? _getBaseContainer(model) : Container(),
        getProgressBar(model.state)
      ],
    );
  }

  void showMessage(BargainHistoryViewModel model) {
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

  _getBaseContainer(BargainHistoryViewModel model) {
    return new Container(
      child: getBargainHistory(model),
    );
  }

  getBargainHistory(BargainHistoryViewModel model) {
    return Card(
      child: model.bargainList == null
          ? Container()
          : model.bargainList.isEmpty
              ? Container(
                  child: Center(
                    child: Text(
                      'No Bargain Data Found',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: (bargain.length <= model.bargainList.length)
                      ? bargain.length + 1
                      : model.bargainList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext cont, int ind) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BargainView(
                                      bargainDetail: model.bargainList[ind],)));
                      },
                      child: (ind == bargain.length) ?
                      Container(
                        color: Palette.assetColor,
                        child: FlatButton(
                          child: Text("Load More",
                            style: TextStyle(color: Palette.whiteTextColor,
                                fontSize: 15),),
                          onPressed: () {
                            loadMoreData(model);
                          },
                        ),
                      ) :
                      Card(
                        elevation: 4.0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 90,
                                  height: 80,
                                  color: Palette.assetColor,
                                  child: WidgetUtils.getCategoryImage(
                                      model.bargainList[ind].item.image)),
                              Expanded(
                                child: setBargainHistoryData(
                                    model.bargainList[ind].item.name,
                                    model.bargainList[ind].bargainstatus,
                                    model.bargainList[ind].lastupdated),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Icon(Icons.arrow_forward_ios),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
    );
  }

  setBargainHistoryData(String name, String status,DateTime lastUpdated) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 15),
          child: new Text(
            name,
            style: TextStyle(
                fontSize: 18.0,
                color: Palette.assetColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "Status: " + status,
            style: TextStyle(fontSize: 15, color: Palette.assetColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "Updated On: " + Utility.dateToString(lastUpdated),
            style: TextStyle(fontSize: 15, color: Palette.assetColor),
          ),
        )
      ],
    );
  }

  void loadMoreData(BargainHistoryViewModel model) {
    setState(() {
      if ((model.present + model.perPage) > model.bargainList.length) {
        bargain.addAll(
            bargain.getRange(model.present, model.bargainList.length));
      } else {
        bargain.addAll(
            bargain.getRange(model.present, model.present + model.perPage));
      }
      model.present = model.present + model.perPage;
    });
  }

}
