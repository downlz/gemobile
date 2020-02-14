import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/Item.dart';

class CategoryViewModel extends BaseModel
{
  bool isListEmpty =  false;
  List<Item> items;
  bool isFirstTime = true;
  int pageNumber = 1;
  bool hasNextPage = true;


  void init(String name) {
    if(isFirstTime){
        getCategories(name);
        isFirstTime = false;
//        print('Cat first time');
    }
//    print('Cat loop');
  }

  getCategories(String name) async {
//    List<Item> items;
    setState(ViewState.Busy);
    items = await API.getCategoryFromItemName(name,pageNumber);
//    print('length=======>${items.length}');
//    if (items.length <= 0) {
//      hasNextPage = false;
////      emptyOrderText = 'No orders found';
//    } else
//      hasNextPage = true;
//    this.items.addAll(items);
    setState(ViewState.Idle);
  }



}