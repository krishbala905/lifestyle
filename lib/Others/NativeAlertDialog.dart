import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/res/Colors.dart';


Future<void> ShowNativeDialogue(BuildContext context,var TitleTxt,Mesage )async   {
  if (Platform.isIOS) {
    return showCupertinoModalPopup (
      context: context,
      builder: (context) => CupertinoAlertDialog(

        title: Text(TitleTxt),
        content: Text(Mesage),
        actions: [
          CupertinoDialogAction(
            child: Text("ok",style: TextStyle(
              color: Colors.red
            ),),
            onPressed: (){
              print('Exit');
              Navigator.pop( context, "ok");
              //Navigator.of(context).pop(false);


            },

          ),
        ],

      ) ,
    );
  } else if(Platform.isAndroid){
    AlertDialog alert = AlertDialog(

      backgroundColor: Colors.white,
      title: Text(TitleTxt),
      // content: CircularProgressIndicator(),
      content: Text(Mesage,style: TextStyle(color: Colors.black45)),
      actions: [
        GestureDetector(
          onTap: (){

            Navigator.pop(context,true);
            },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 35,
              width: 100,
              color: Colors.white,
              child:Center(child: Text('OK',style: TextStyle(color: Maincolor),)),
            ),
          ),
        ),
      ],
    );
    showDialog(

      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6),
          child: alert,
        );
      },
    );
  }
  else{
    print("noting");
  }
}











