import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lifestyle/SplashScreen.dart';
import 'dart:convert';
import '../res/Colors.dart';
import '../res/Strings.dart';
import 'AlertDialogUtil.dart';
import 'CommonUtils.dart';
import 'Urls.dart';
import 'Utils.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


Future<String> callPPNAPIXML(BuildContext context , var action,var pnsId,var confirmStatus,var type)async {
  var navigatePath="null";
  var data=null;
  print("s.version:"+CommonUtils.softwareVersion.toString());

  final http.Response response = await http.post(
    Uri.parse(PPN_URL),

    body: {
      "pns_id":pnsId,
      "confirmation_status":confirmStatus,
      "type":type,
      "action":action,
      "consumer_id": CommonUtils.consumerID,
      "cma_timestamps":Utils().getTimeStamp(),
      "time_zone":Utils().getTimeZone(),
      "software_version":CommonUtils.softwareVersion,
      "os_version":CommonUtils.osVersion,
      "phone_model":CommonUtils.deviceModel,
      "device_type":CommonUtils.deviceType,
      'consumer_application_type':CommonUtils.consumerApplicationType,
      'consumer_language_id':CommonUtils.consumerLanguageId,
      'flutter_app':"1",
      'device_token':CommonUtils.deviceToken,
    },
  ).timeout(Duration(seconds: 30));


  print("ppnresponse"+response.body.toString());

  if (response.statusCode == 200) {

    final Xml2Json xml2json = new Xml2Json();

    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = jsonDecode(jsonstring);
    var data1 = data['info'];


    var p1= Utils().stringSplit(data1['p1']);

    if(p1!="False") {
      String p2 = Utils().stringSplit(data1['p2']).toString();
      var p2Data = p2.split(";");



      String actionType = p2Data[0].split(":")[2];


      var p3 = Utils().stringSplit(data1['p3']);
      var msg = Utils().stringSplit(data1['p4']);

      if (actionType == "logeventonly") {
        // CommonUtils.NAVIGATE_PATH = CommonUtils.inboxPage;

        showAlertDialog_oneBtn(context, appName, msg);
        CommonUtils.pid=Utils().stringSplit(data1['p3']);
        print("pid:"+CommonUtils.pid.toString());


      }
      else if (actionType == CommonUtils.KEY_REWARD_REDEEM ) {
        navigatePath = CommonUtils.homePage;
        CommonUtils.PPN_RESPONSE_CONTENT = response.body;
        showAlertDialog_oneBtn(context, appName, msg);
        var pid=p2.split(";")[1].split(":")[1];
        print("pid:"+pid.toString());
        // callPPNAPIXML(context, "1", pid,"1", actionType);
      }
      else if (actionType == CommonUtils.UPDATE_POINTS ) {
        navigatePath = CommonUtils.homePage;
        CommonUtils.PPN_RESPONSE_CONTENT = response.body;
        showAlertDialog_oneBtn(context, appName, msg);
        CommonUtils.pid=Utils().stringSplit(data1['p3']);
        print("pid:"+CommonUtils.pid.toString());
        // callPPNAPIXML(context, "1", pid,"1", actionType);
      }
      else if (actionType == CommonUtils.KEY_WALLET_SYNC ||
          actionType == CommonUtils.KEY_WALLET_SYNC_NEW) {
        navigatePath = CommonUtils.walletPage;
        CommonUtils.PPN_RESPONSE_CONTENT = response.body;
        // showRewardsDeliveryDialog(context, response.body.toString());
      }
      else if (actionType == CommonUtils.KEY_FORCE_LOG_OUT) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('alreadyLoggedIn', "");
        prefs.setString('consumerId', "");
        prefs.setString('consumerName', "");
        prefs.setString('consumerEmail', "");

        CommonUtils.consumerID = "";
        CommonUtils.consumerName = "";
        CommonUtils.consumerEmail = "";
        navigatePath = CommonUtils.none;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen(),));
        showToast(logout_message, gravity: Toast.bottom);
        // Need to call Api
      }
      else if (actionType == CommonUtils.KEY_FORCE_UPDATE) {
        navigatePath = CommonUtils.none;
        showAlertDialog_forAppUpdate(context, alert1, msg);
      }
    }
    //   data=await jsonDecode(response.body);
    //   var status=data["STATUS"].toString();
    //   var message=data["MESSAGE"].toString();
    //   // CommonUtils.deviceTokenID=data["  "];
    //   //
    //
    //
    //
    //   if(status=="True"){
    //
    //     var actionType=data["ACTION"].toString();
    //     if(actionType==CommonUtils.KEY_FORCE_LOG_OUT) {
    //       SharedPreferences prefs = await SharedPreferences.getInstance();
    //       prefs.setString('alreadyLoggedIn', "");
    //       prefs.setString('consumerId', "");
    //       prefs.setString('consumerName',"" );
    //       prefs.setString('consumerEmail',"" );
    //
    //       CommonUtils.consumerID="";
    //       CommonUtils.consumerName="";
    //       CommonUtils.consumerEmail="";
    //       navigatePath=CommonUtils.none;
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen(),));
    //       showToast(logout_message, gravity: Toast.bottom);
    //       // Need to call Api
    //     }
    //     else if(actionType==CommonUtils.KEY_FORCE_UPDATE){
    //       navigatePath=CommonUtils.none;
    //       showAlertDialog_forAppUpdate(context,alert1,message);
    //     }
    //
    //     else if(actionType==CommonUtils.KEY_MEMBER_POINT_TRANSACTION) {
    //       navigatePath=CommonUtils.rewards_popup;
    //       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
    //       showRewardsDeliveryDialog(context, response.body.toString());
    //     }
    //
    //     else if(actionType==CommonUtils.KEY_FEEDBACK_POINT_TRANSACTION) {
    //       navigatePath=CommonUtils.none;
    //       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
    //     }
    //
    //     else if(actionType==CommonUtils.KEY_CALL_INBOX) {
    //       showAlertDialog_oneBtn_msg(context, message);
    //       navigatePath=CommonUtils.inboxPage;
    //
    //       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
    //     }
    //     else if(actionType==CommonUtils.KEY_WALLET_SYNC || actionType==CommonUtils.KEY_WALLET_SYNC_NEW) {
    //       navigatePath=CommonUtils.walletPage;
    //       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
    //       showRewardsDeliveryDialog(context, response.body.toString());
    //     }
    //
    //     else if(actionType==CommonUtils.KEY_MEMBERSHIP_POPUP){
    //       navigatePath=CommonUtils.memberShip_popup;
    //       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
    //       showRewardsDeliveryDialog(context, response.body.toString());
    //     }
    //     else{
    //       navigatePath=CommonUtils.none;
    //     }
    //
    //   }
    //   else{
    //     navigatePath=CommonUtils.none;
    //   }
    //
    //
  } else {
    showAlertDialog_oneBtn(context, alert1, something_went_wrong1);
    throw "something_went_wrong1";
  }

  return navigatePath;

}

// void showAlertDialog_oneBtnForPPN(BuildContext context,String tittle,String message)
// {
//   AlertDialog alert = AlertDialog(
//
//     backgroundColor: Colors.white,
//     title: Text(tittle),
//     // content: CircularProgressIndicator(),
//     content: Text(message,style: TextStyle(color: Colors.black45,fontSize: 15)),
//     actions: [
//       GestureDetector(
//         onTap: (){Navigator.pop(context,true);},
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Container(
//             height: 35,
//             width: 100,
//             color: Colors.white,
//             child:Center(child: Text(ok,style: TextStyle(color: corporateColor),)),
//           ),
//         ),
//       ),
//     ],
//   );
//   showDialog(
//
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6),
//         child: alert,
//       );
//     },
//   );
// }

