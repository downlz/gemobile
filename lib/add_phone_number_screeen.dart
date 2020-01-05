import 'package:flutter/material.dart';
import 'package:graineasy/ui/theme/palette.dart';
import 'package:url_launcher/url_launcher.dart';

class AddPhoneNumber extends StatefulWidget {
  @override
  _AddPhoneNumberState createState() => _AddPhoneNumberState();
}

class _AddPhoneNumberState extends State<AddPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(_backIcon(context)),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Phone Number'),
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: 400,
          height: 180,
          padding: EdgeInsets.only(top: 10),
          child: Card(
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                            icon: Image.asset('images/call.png'),
                            onPressed: () {}),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            '+91 8340 445 819',
                            style: TextStyle(
                                fontSize: 20,
                                color: Palette.assetColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      launch("tel://+91 8340 445 819");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 10),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'images/whatsapp.png',
                          width: 50,
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('+91 8252 482 338',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Palette.assetColor,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    onTap: () async {
//                      launch("tel://+91 8297 855 195");

                      var phone = "+91 8252 482 338";
                      var whatsAppUrl = "whatsapp://send?phone=$phone";
                      await canLaunch(whatsAppUrl)
                          ? launch(whatsAppUrl)
                          : print(
                          "Unable to launch Whatsapp as no such application is installed.");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 10),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'images/whatsapp.png',
                          width: 50,
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('+91 8297 855 195',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Palette.assetColor,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    onTap: () async {
//                      launch("tel://+91 8297 855 195");

                      var phone = "+91 8297 855 195";
                      var whatsAppUrl = "whatsapp://send?phone=$phone";
                      await canLaunch(whatsAppUrl)
                          ? launch(whatsAppUrl)
                          : print(
                              "Unable to launch Whatsapp as no such application is installed.");
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

IconData _backIcon(BuildContext context) {
  switch (Theme.of(context).platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
      return Icons.arrow_back;
    case TargetPlatform.iOS:
      return Icons.arrow_back_ios;
  }
  assert(false);
  return null;
}
