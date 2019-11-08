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
    if (!(value.length > 6) ) {
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

 static validateEmptyPhone(String value)
  {
    if (value.isEmpty) {
      return 'Phone Number Required';
    }
    else
      return null;

  }
static  validateEmptyPassword(String value)
  {
    if (value.isEmpty) {
      return 'Password Required';
    }
    else
      return null;

  }

}