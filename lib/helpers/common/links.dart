import 'package:url_launcher/url_launcher.dart';

Future launchTermsOfServiceURL() async {
  const url = 'https://graineasy.com/termsofuse';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}