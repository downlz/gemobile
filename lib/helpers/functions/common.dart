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
  String userExists;
  userExists = item.addedBy.name ?? 'false';
  if (item.showAddedByName){
    listedText = item.addedBy.name ?? 'Broker';
  }
  else {
    if (userExists == 'false') {
      listedText = 'Broker';
    } else {
      if (item.addedBy.isSeller) {
        listedText = 'Seller';
      } else {
        listedText = 'Broker';
      }
    }
  }
  return listedText;
}