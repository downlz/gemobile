import 'package:flutter/material.dart';
import 'package:graineasy/manager/base/base_view.dart';
import 'package:graineasy/model/itemname.dart';
import 'package:graineasy/ui/view/Bargein/bargain_view_model.dart';
import 'package:graineasy/ui/widget/AppBar.dart';

class BargainView extends StatefulWidget {
  final ItemName itemName;

  const BargainView({Key key, this.itemName}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<BargainView> with CommonAppBar {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BargainViewModel>(builder: (context, model, child) {
      model.init(widget.itemName.id);
      return new Scaffold(
        appBar: new AppBar(
          title: Text('Bargain'),
          backgroundColor: Colors.white,
        ),
        body: _getBody(model),
      );
    });
  }

  Widget _getBody(BargainViewModel model) {
    return Stack(
      children: <Widget>[_getBaseContainer(model), getProgressBar(model.state)],
    );
  }

  void showMessage(BargainViewModel model) {
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

  _getBaseContainer(BargainViewModel model) {
    return getCategoryWidget(model);
//      model.items!=null?
//      getCategoryWidget(model):Container();
  }

  getCategoryWidget(BargainViewModel model) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Product Name'),
          Text('Product Qty'),
          Text('Product Price'),
          RaisedButton(
            onPressed: () {},
            child: Text('Add Request'),
          ),
        ],
      ),
    );
  }
}
