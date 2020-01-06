import 'package:graineasy/model/Item.dart';
import 'package:graineasy/model/groupbuy.dart';
import 'package:graineasy/helpers/showDialogSingleButton.dart';

class Validation
{


  static String  validateName(String value) {
    if (value.isEmpty) {
      return 'Incorrect Name';
    }
    else
      return null;
  }

  static String  validateIfsc(String value) {
    if (value.isEmpty || !(value.length == 11)) {
      return 'Incorrect IFSC';
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

  static validateRemark(String value) {
    if (value.isEmpty) {
      return 'Remark Required';
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
      return 'only $qty stock is available';
    }
  }


  static validateEmptyItemQty(String value, Item itemDetails) {
    if (value.isEmpty)
      return 'Quantity required';

//    showDialogSingleButton(context, "Unable to get Order Details", "Faced connectivity issue while pulling order details or authenticated failure", "OK");

    if (itemDetails.qty < int.parse(value))
      return '${itemDetails.qty} qty available';
    else
      return null;
  }

  static validateEmptyGBItemQty(String value, Groupbuy gbitemDetails) {
    if (value.isEmpty)
      return 'Quantity equired';

    if (gbitemDetails.maxqty < int.parse(value))
      return '${gbitemDetails.maxqty} qty available';           // Check logic for available qty
    else
      return null;
  }


  static validateItemQtyAndPrice(String value, Item itemDetails) {
    print('validating');
    if (value.isEmpty)
      return 'Quote required';

    if (double.parse(value) <= 1 || double.parse(value) > itemDetails.price)
      return 'Enter valid Quote amount';
    else
      return null;
  }




  static validateGstInNumber(String value) {
    if ((value.length != 15)) {
      return "Incorrect GSTIN";
    }
    else if (value.isEmpty) {
      return "Incorrect GSTIN";
    }
    return null;
  }

  static validatePin(String value) {
    if (value.length != 6) {
      return "Incorrect Pincode";
    }
    else if (value.isEmpty) {
      return "Incorrect Pincode";
    }
    return null;
  }

}