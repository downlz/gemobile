import 'package:graineasy/manager/api_call/API.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/manufacturer.dart';

class SearchItemViewModel extends BaseModel {
  List<Item> items = [];
  List<Item> recentItem = [];
  List<Manufacturer> manufacturerItem = [];
  String selectedGrade;
  Manufacturer selectedManufacturer;
  List<Manufacturer> manufacturerList = [];
  Item itemData;
  bool isFirstTime = true;


  void searchText(String searchString) async {
    setState(ViewState.Busy);
    items = await API.searchItem(searchString);
//    print('Item length ===? ${items.length}');
    setState(ViewState.Idle);
    recentItem.addAll(items);
//    print('recent==>${recentItem}');
  }

  void getItemByGrade(String grade) async {
    setState(ViewState.Busy);
    items = await API.itemGrade(grade);
//    print('Item length ===? ${items.length}');
    setState(ViewState.Idle);
    recentItem.addAll(items);
//    print('recent==>${recentItem}');
  }


  getRecentlyAddedItem() async {
    setState(ViewState.Busy);
    items = await API.getRecentlyAddedItem();
    setState(ViewState.Idle);
  }

  getManufacturerItem() async {
    manufacturerItem = await API.getManufacturerItem();
    notifyListeners();
  }

  Future init() async {
    if (isFirstTime) {
      getManufacturerItem();
      isFirstTime = false;
    }
  }



}
