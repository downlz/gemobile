import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graineasy/helpers/functions/common.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

Future launchEmail(Item recentItem) async {
  launch('mailto:?subject=${"Graineasy item listing: " +
      recentItem.sampleNo}&body=${'Category:' +
      recentItem.category.name + "\n" +
      'Item:' + recentItem.itemname.name}'+ "\n" +
      'List Price:' + '\u20B9'+ '${recentItem.price}' + "/" + '${recentItem.unit.mass}'+ "\n" +
      'Manufacturer:' + recentItem.manufacturer.name + "\n" +
      'Origin:' + recentItem.origin + "\n" +
      "Brokerage Applicable: " + (recentItem.brokerage ? 'Yes'  : 'No') + "\n" +
      'Listed By:' + getListedByDtl(recentItem) + "\n" +
      (recentItem.remarks != 'NA' && recentItem.remarks != null ? 'Season-' + recentItem.remarks:'') + "\n" +
//      recentItem.image}' + "\n" +
      'For details visit ' + 'https://graineasy.com/products/'+'${recentItem.id}' );
}

Future launchWhatsApp(Item recentItem) async {
  FlutterShareMe().shareToWhatsApp(
      msg: 'Sharing an item from graineasy.com: ' + recentItem.name + "\n" +
          'Item:' + recentItem.itemname.name + "\n" +
          'Category: ' + recentItem.category.name + "\n" +
          'List Price: ' + '\u20B9'+ '${recentItem.price}' + "/" + '${recentItem.unit.mass}'+ "\n" +
          'Manufacturer: ' + recentItem.manufacturer.name + "\n" +
          'Origin:' + recentItem.origin + "\n" +
          "Brokerage Applicable: " + (recentItem.brokerage ? 'Yes'  : 'No') + "\n" +
          'Listed By:' + getListedByDtl(recentItem) + "\n" +
//          recentItem.image);
          'For details visit ' + 'https://graineasy.com/products/'+'${recentItem.id}' );
}

Future launchGBEmail(Groupbuy item) async {
  launch('mailto:?subject=${"Item available for Groupbuy at graineasy: " +                                  // Modified to remove email to trade@graineasy.com
      item.item.name}&body=${'Item: '+ item.item.sampleNo + "\n" +
      'Category:'+ item.item.category.name + "\n" +
      'Manufacturer: ' + item.item.manufacturer.name + "\n" +
      'Offer Price: ' + item.dealprice.toString()  + "/" + '${item.unit.mass}'+ "\n" +
      'Minimum Order Quantity: ' + item.moq.toString()  + "/" + '${item.unit.mass}'+ "\n"
      'For details visit: ' + 'https://graineasy.com/groupbuy/gbproduct/'+'${item.id}'}'
      );
}

Future launchGBWhatsApp(Groupbuy item) async {
  FlutterShareMe().shareToWhatsApp(
//      msg: item.item.name + "/" + item.item.category.name + "\n" + item.item.image);
      msg: 'Sharing an item from graineasy.com: ' + item.item.sampleNo + "\n" +
          'Item: ' + item.item.name + "\n" +
          'Category: ' + item.item.category.name + "\n" +
      'Manufacturer: ' + item.item.manufacturer.name + "\n" +
      'Offer Price: ' + item.dealprice.toString()  + "/" + '${item.unit.mass}'+ "\n" +
      'Minimum Order Quantity: ' + item.moq.toString()  + "/" + '${item.unit.mass}'+ "\n"
      'For details visit: ' + 'https://graineasy.com/groupbuy/gbproduct/'+'${item.id}');
}

Future launchCustomerEmail() async {
  launch('mailto:trade@graineasy.com?subject=Customer Query');
}

Future launchFeedbackEmail() async {
  launch('mailto:trade@graineasy.com?subject=Graineasy Feedback and Feature Request');
}