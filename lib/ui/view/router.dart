import 'package:flutter/material.dart';
import 'package:graineasy/HomeScreen.dart';
import 'package:graineasy/ui/view/home/home_view.dart';
import 'package:graineasy/ui/view/registration/registration_view.dart';

import 'forgot_password/forgot_password_view.dart';
import 'login/login_view.dart';


enum Screen {
  Login,
  Registration,
  ForgotPassword,
  Home_screen
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Screen screen;

   if (settings.name == Screen.Login.toString()) {
      screen = Screen.Login;
    }

   else if (settings.name == Screen.Registration.toString()) {
      screen = Screen.Registration;
    }
   else if (settings.name == Screen.ForgotPassword.toString()) {
     screen = Screen.ForgotPassword;
   }
   else if (settings.name == Screen.Home_screen.toString()) {
     screen = Screen.Home_screen;
   }
    return getRoute(screen, settings.arguments);
  }

  static Route<dynamic> getRoute(
      Screen screen, Map<String, dynamic> arguments) {
    if (screen == null) {
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for screen'),
                ),
              ));
    } else {
      if (screen == Screen.Login) {
        return MaterialPageRoute(builder: (_) => LoginView());
      }
      else if(screen==Screen.Registration)
        {
          return MaterialPageRoute(builder: (_) => RegistrationView());
        }
      else if(screen==Screen.ForgotPassword)
      {
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      }
      else if(screen==Screen.Home_screen)
      {
        return MaterialPageRoute(builder: (_) => HomeView());
      }
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for screen'),
                ),
              ));
    }
  }
}
