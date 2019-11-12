import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResponsive {
  static double comparableHeight = 976;
  static double comparableWidth = 600;
  static bool isDeviceTablet = true;
  static double heightOfTheDevice = 0;
  static double widthOfTheDevice = 0;

  static void isTablet(MediaQueryData query, BuildContext context) {

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: comparableWidth, height: comparableHeight)..init(context);
//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.instance = ScreenUtil(
        width: comparableWidth,
        height: comparableHeight,
        allowFontScaling: true)
      ..init(context);

//    var size = query.size;
//    heightOfTheDevice = size.height;
//    widthOfTheDevice = size.width;
//    print('Height   $heightOfTheDevice');
//    print('Width   $widthOfTheDevice');
//    var diagonal =
//        sqrt((size.width * size.width) + (size.height * size.height));
//
//    bool isTablet = diagonal > 1100.0;
//    isDeviceTablet = isTablet;

  }

  static double getSizeOfHeight(double size) {
    return ScreenUtil.getInstance().setWidth(size);
//    double result = (size * heightOfTheDevice) / comparableHeight;
//    return result;
  }

  static double getSizeOfWidth(double size) {
    return ScreenUtil.getInstance().setHeight(size);
//    double result = (size * widthOfTheDevice) / comparableWidth;
//    return result;
  }

  static double getFontSizeOf(double size) {
    return ScreenUtil.getInstance().setSp(size);
//    double result = (size * heightOfTheDevice) / comparableHeight;
//    if (Platform.isIOS) result = result + 2;
//    return result;
  }

  static double getSizeOf(double size) {
    double result = (size * heightOfTheDevice) / comparableHeight;
//    if (Platform.isIOS) result = result + 2;
    return result;
  }
}
