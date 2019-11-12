import 'package:flutter/material.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:graineasy/ui/theme/text_style.dart';



class AppWidget {
  static darkTextField(String hint) {
    return InputDecoration(
//                            contentPadding: EdgeInsets.only(top: 25, left: 7),
      hintText: hint,

      disabledBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.loginBgColor),
      ),
      focusedBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.loginBgColor),
      ),
      enabledBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.loginBgColor),
      ),
      errorBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.loginBgColor),
      ),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.loginBgColor),
      ),

//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(25.0)),
      hintStyle: AppTextStyle.getLargeHeading(false,Palette.loginBgColor),
    );
  }

  static darkTextFieldTextStyle() {
    return AppTextStyle.getLargeHeading(false, Colors.black);
  }

  static latLongText() {
    return AppTextStyle.commonTextStyle(Palette.loginBgColor, 15, FontWeight.w500, FontStyle.normal);
  }

  static darkWhiteTextField(String hint,IconData icon) {

    return InputDecoration(
//                            contentPadding: EdgeInsets.only(top: 25, left: 7),

    icon: Icon(icon,color: Palette.whiteTextColor,),
      hintText: hint,
      disabledBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),
      focusedBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),
      enabledBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),
      errorBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),

//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(25.0)),
      hintStyle: AppTextStyle.getLargeHeading(false,Palette.whiteTextColor),
    );
  }

  static darkWhiteTextFieldTextStyle() {
    return AppTextStyle.getLargeHeading(false, Palette.whiteTextColor);
  }

  static whiteTextField(String hint) {
    return InputDecoration(
//                            contentPadding: EdgeInsets.only(top: 25, left: 7),

      hintText: hint,
      disabledBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),
      focusedBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),
      enabledBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),
      errorBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(color: Palette.whiteTextColor),
      ),

//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(25.0)),
      hintStyle: AppTextStyle.getLargeHeading(false, Colors.white24),
    );
  }

}
