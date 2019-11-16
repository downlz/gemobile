// base_model.dart

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:graineasy/ui/theme/palette.dart';

/// Represents the state of the view
/// this is trypically used to show/hide progress indicator

enum ViewState { Idle, Busy }

class BaseModel extends ChangeNotifier {
  static const String success = "Success";

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  bool _shouldShowMessage = false;
  bool _isError = false;
  String _message;

  get message => _message;
  get isError => _isError;
  get shouldShowMessage => _shouldShowMessage;

  BuildContext context;

  void setState(ViewState viewState) {
    if (_state != viewState) _state = viewState;
    notifyListeners();
  }

  void messageIsShown() {
    _shouldShowMessage = false;
  }

  getCity() {
    return _state;
  }

  void showError(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
  void showMessageError( String message, bool isError) {
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

  void showMessage(String message, bool isError) {
    _shouldShowMessage = true;
    _isError = isError;
    _message = message;
    notifyListeners();
  }

  bool isUserSessionValid(int responseCode) {
    return true;
  }
}
