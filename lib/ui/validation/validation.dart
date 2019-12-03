import 'package:graineasy/model/Item.dart';

class Validation
{


  static String  validateName(String value) {
    if (value.isEmpty) {
      return 'Incorrect Name';
    }
    else
      return null;
  }

  static String  validatePan(String value) {
    if (value.isEmpty) {
      return 'Incorrect PanNumber';
    }
    else
      return null;
  }

  static String  validateAddress(String value) {
    if (value.isEmpty) {
      return 'Incorrect Address';
    }
    else
      return null;
  }

  static String  validateGstIn(String value) {
    if (value.isEmpty) {
      return 'Incorrect GstIn';
    }
    else
      return null;
  }

  static String validatePassword(String value) {
    if (!(value.length > 7)) {
      return "Incorrect password";
    }
    else if (value.isEmpty) {
      return "Incorrect password";
    }
    return null;
  }

  static String validateMobile(String value) {
    if ((value.length < 10) ) {
      return "Incorrect Mobile";
    }
    else if (value.isEmpty) {
      return "Incorrect Mobile";
    }
    return null;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Incorrect Email';
    else if (value.isEmpty) {
      return "Incorrect Email";
    }
    else
      return null;
  }

  static validateEmptyPhone(String value) {
    if (value.isEmpty) {
      return 'Phone Number Required';
    }
    else
      return null;
  }
static  validateEmptyPassword(String value) {
  if (value.isEmpty) {
    return 'Password Required';
  }
  else
    return null;
}

  static validateItemQty(String value, int qty) {
    int selectedQty = int.parse(value);
    if (qty <= selectedQty) {
      return null;
    }
    if (selectedQty == 0) {
      return 'Please add qty';
    }

    if (selectedQty > qty) {
      return 'only $qty stock is availabel';
    }
  }


  static validateEmptyItemQty(String value, Item itemDetails) {
    if (value.isEmpty)
      return 'Quntity equired';

    if (itemDetails.qty < int.parse(value))
      return '${itemDetails.qty} qty availabel';
    else
      return null;
  }


  static validateItemQtyAndPrice(String value, Item itemDetails) {
    if (value.isEmpty)
      return 'Quote equired';

    if (int.parse(value) == 0)
      return 'Enter valid Quote amount';
    else
      return null;
  }




  static validateGstInNumber(String value) {
    if ((value.length < 15)) {
      return "Incorrect GSTIN";
    }
    else if (value.isEmpty) {
      return "Incorrect GSTIN";
    }
    return null;
  }

  static validatePin(String value) {
    if (!(value.length > 4)) {
      return "Incorrect Pincode";
    }
    else if (value.isEmpty) {
      return "Incorrect Pincode";
    }
    return null;
  }

}