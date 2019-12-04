import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/Item.dart';

class SearchItemViewModel extends BaseModel {
  List<Item> items = [];
  List<Item> recentItem;


  void searchText(String searchString) async {
    setState(ViewState.Busy);
    items = await API.searchItem(searchString);
    print('Item length ===? ${items.length}');
    setState(ViewState.Idle);
  }

  getRecentlyAddedItem() async {
    setState(ViewState.Busy);
    items = await API.getRecentlyAddedItem();
    setState(ViewState.Idle);
  }

}
