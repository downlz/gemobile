import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/Item.dart';

class CategoryViewModel extends BaseModel
{
  bool isListEmpty =  false;
  List<Item> items ;

  bool isFirstTime = true;

  void init(String name) {
    if(isFirstTime){
        getCategories(name);
        isFirstTime = false;
        print('Cat first time');
    }

    print('Cat loop');
  }

  getCategories(String name) async {
    setState(ViewState.Busy);
    items = await API.getCategoryFromItemName(name);
    setState(ViewState.Idle);
  }

}