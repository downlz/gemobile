import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:graineasy/ui/theme/palette.dart';

class WidgetUtils
{
  static getCategoryImage(String imageUrl)
  {
    return TransitionToImage(
        image: AdvancedNetworkImage(imageUrl,
        loadedCallback: () {
      print('It works!');
    },),
  fit: BoxFit.cover,
  placeholder: const Icon(Icons.refresh),
  enableRefresh: true,
  );
  }

  static Widget showMessageAtCenterOfTheScreen(String message)
  {
    return Center(child: Text(message,style: TextStyle(color:Palette.assetColor,fontSize: 20),),);
  }


}