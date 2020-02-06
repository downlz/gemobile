import 'package:graineasy/model/Item.dart';

String slice(String subject, [int start = 0, int end]) {
  if (subject is! String) {
    return '';
  }

  int _realEnd;
  int _realStart = start < 0 ? subject.length + start : start;
  if (end is! int) {
    _realEnd = subject.length;
  } else {
    _realEnd = end < 0 ? subject.length + end : end;
  }

  return subject.substring(_realStart, _realEnd);
}

getListedByDtl(Item item) {
  String listedText;
  if (item.showAddedByName && (item.addedBy != null)){
    listedText = item.addedBy.name;
  } else if (item.addedBy == null) {
    listedText = 'Admin';
  }
  else {
    if (item.addedBy.isAgent) {
      listedText = 'Broker';
    } else if (item.addedBy.isAdmin) {
      listedText  = 'Admin';
    } else {
      listedText = 'Seller';
    }
  }
  return listedText;
}