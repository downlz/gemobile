import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';


class Utility
{

  static Future<bool> isInternetAvailable() async {
    var connectivityResult = await new Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static String dateTimeToString(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static DateTime convertStringDateToDateTime(String dateTime) {
    return new DateFormat("yyyy-MM-ddThh:mm:s.sssZ").parse(dateTime);
  }

  static String dateToString(DateTime dateTime) {
    var updateTime = Jiffy(dateTime).add(
        hours: 5, minutes: 30); // 2018-08-16 12:00:00.000Z
    return DateFormat('dd-MM-yyyy hh:mm a').format(updateTime);


  }
}