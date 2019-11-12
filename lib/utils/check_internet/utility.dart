import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';


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

}