import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

Future launchEmail(Item recentItem) async {
  launch('mailto:?subject=${"Graineasy item listing: " +
      recentItem.name}&body=${'Category:' +
      recentItem.category.name + "\n" +
      'List Price:' + '\u20B9'+ '${recentItem.price}' + "/" + '${recentItem.unit.mass}'+ "\n" +
      recentItem.image}' + "\n" +
      'For details visit ' + 'https://graineasy.com/product/'+'${recentItem.id}' );
}

Future launchWhatsApp(Item recentItem) async {
  FlutterShareMe().shareToWhatsApp(
      msg: recentItem.name + "/" + recentItem.category.name + "\n" +
          'List Price:' + '\u20B9'+ '${recentItem.price}' + "/" + '${recentItem.unit.mass}'+ "\n" +
          recentItem.image);
}

Future launchGBEmail(Groupbuy item) async {
  launch('mailto:?subject=${"ItemName: " +                                  // Modified to remove email to trade@graineasy.com
      item.item.name}&body=${item.item.name + "/" + item.item.category.name + "\n" +
      item.item.image}');
}

Future launchGBWhatsApp(Groupbuy item) async {
  FlutterShareMe().shareToWhatsApp(
      msg: item.item.name + "/" + item.item.category.name + "\n" + item.item.image);
}

Future launchCustomerEmail() async {
  launch('mailto:trade@graineasy.com?subject=Customer Query');
}