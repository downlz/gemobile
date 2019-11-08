import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/loaders/color_loader_5.dart';
import 'package:graineasy/manager/base/basemodel.dart';
import 'package:graineasy/ui/theme/palette.dart';

class CommonAppBar {


  Widget getProgressBar(ViewState viewState) {
    if (viewState == ViewState.Busy)
    {
      return Container(
        color: Colors.white.withAlpha(204),
        child: Center(
          child: ColorLoader5(
            dotOneColor: Palette.blueBtnColor,
            dotTwoColor: Palette.redBtnColor,
            dotThreeColor: Palette.fbBtnColor,
          ),
        ),
      );
    }
    else {
      return Container();
    }
  }





  void showErrorMessage(BuildContext context, String message, bool isError) {
    try {
      if (message != null) {
        Flushbar(
          message: message,
          flushbarStyle: FlushbarStyle.GROUNDED,
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 5),
          backgroundColor: Palette.snackBarColor,
        )..show(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
