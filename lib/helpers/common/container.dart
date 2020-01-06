import 'package:flutter/material.dart';

getBargainContainer(){
  return Container(
    padding: EdgeInsets.all(3),
    decoration: new BoxDecoration(
        border: Border.all(
            color: Colors.white),
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(
                40.0),
            bottomLeft: const Radius
                .circular(40.0),
            bottomRight: const Radius
                .circular(40.0),
            topRight: const Radius.circular(
                40.0))
    ),
    alignment: Alignment.topLeft,
    child: Text('Bargain Enabled',
      style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12),),
  );
}