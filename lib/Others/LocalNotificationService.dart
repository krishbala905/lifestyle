import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/PPNAPIClass.dart';

import 'PPNApiClassXML.dart';


class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static void initialize(BuildContext context){
    final InitializationSettings initializationSettings =InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? route) async{
      print("InboxDetails:"+route.toString());
      if(route !="0"&& route!=""){
        CommonUtils.msgid=route!;
        print(CommonUtils.msgid.toString());
        Navigator.of(context).pushNamed("InboxDetails");
      }else{
        dynamic result=await callPPNAPIXML(context,"0","","","");
        //changeToPage(result);
        //Navigator.of(context).pushNamed('InboxDetails');
      }
    });
  }
  static void display (RemoteMessage message) async{
    try {
      final id = DateTime.now().millisecondsSinceEpoch~/1000;
      final NotificationDetails notificationDetails =NotificationDetails(
          android: AndroidNotificationDetails("bioderma",
              "bioderma channel",
              importance: Importance.max,
              priority: Priority.high)      );
      await _notificationsPlugin.show(
        id,message.notification!.title,
        message.notification!.body,notificationDetails,
        payload: message.data["moredata"],
      );
    }
    on Exception catch (e) {
      print(e);
    }
  }

  static void displayForBroadCast (var tittle,var message) async{
    try {
      final id = DateTime.now().millisecondsSinceEpoch~/1000;
      final NotificationDetails notificationDetails =NotificationDetails(
          android: AndroidNotificationDetails("bioderma",
              "bioderma channel",
              importance: Importance.max,
              priority: Priority.high)      );
      await _notificationsPlugin.show(
        id,tittle,
        message,notificationDetails,
        payload: "InboxDetails",
      );
    }
    on Exception catch (e) {
      print(e);
    }
  }
}