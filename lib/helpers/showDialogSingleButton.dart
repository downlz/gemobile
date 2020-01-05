import 'package:flutter/material.dart';

void showDialogSingleButton(BuildContext context, String title, String message, String buttonLabel) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title,style: TextStyle(color: Colors.blueGrey,fontSize: 20, fontWeight: FontWeight.bold),),
        content: new Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(buttonLabel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


showUploadConfirmation(BuildContext context,appView,id,title,subtitle){
  return showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          content: ListTile(
            title: Text(title,style: TextStyle(color: Colors.blueGrey,fontSize: 18, fontWeight: FontWeight.bold),),
            subtitle: Text(subtitle) ,
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                    child: Text('Ok',style: TextStyle(color: Colors.blueGrey,fontSize: 18, fontWeight: FontWeight.bold),),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              appView()));
                    }
                ),
              ],
            ),
          ],
          elevation: 2,
        ),
  );
}