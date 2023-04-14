/*
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lifestyle/SplashScreen.dart';
import 'package:lifestyle/generated/l10n.dart';
import 'dart:convert';
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
  var bodyValue;
  if(action=="0"){
    bodyValue={
      "device_type":"2",
      "software_version":"1.0.5",
      "os_version":CommonUtils.osVersion.toString(),
      "phone_model":CommonUtils.deviceModel.toString(),
      "phone_imei":"056b0c59846d69c9",
      "time_zone":"Asia/Kolkata",
      "consumer_application_type":"1",
      "merchant_language_id":"1",
      "consumer_language_id":"1",
      "country_index":"191",
      "device_token_id":CommonUtils.deviceTokenID.toString(),
      "consumer_id":CommonUtils.consumerID.toString(),
      "action":action,
      "cma_timestamps":CommonUtils.timeStamp.toString(),

    };
  }
  else{
    bodyValue={
      "device_type":CommonUtils.deviceType.toString(),
      "software_version":CommonUtils.softwareVersion.toString(),
      "os_version":CommonUtils.osVersion.toString(),
      "phone_model":CommonUtils.deviceModel.toString(),
      "time_zone":CommonUtils.timeZone.toString(),
      "consumer_application_type":"1",
      "merchant_language_id":"1",
      "consumer_language_id":"1",
      "country_index":CommonUtils.COUNTRY_INDEX.toString(),
      "device_token_id":CommonUtils.deviceTokenID.toString(),
      "consumer_id":CommonUtils.consumerID.toString(),
      "action":action,
      "cma_timestamps":CommonUtils.timeStamp.toString(),
      "pns_id":pnsId,
      "confirmation_status":confirmStatus,
      "type":type,

    };
  }

  final http.Response response = await http.post(
    // Uri.parse("https://eastsidedev.poket.com/eastside/newapi2/PPNCmdVersion3"),
    Uri.parse(PPN_URL),


    body: bodyValue,
  ).timeout(Duration(seconds: 30));



  print("ppnPOST"+response.body.toString());


  if (response.statusCode == 200) {

    final Xml2Json xml2json = new Xml2Json();

    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = jsonDecode(jsonstring);
    var data1 = data['info'];



    var p1= Utils().stringSplit(data1['p1']);


   if(p1=="True") {
     String p2 = Utils().stringSplit(data1['p2']).toString();
     var p2Data = p2.split(";");



     String actionType = p2Data[0].split(":")[2];




     var p3 = Utils().stringSplit(data1['p3']);
     var msg = Utils().stringSplit(data1['p4']);



     if (actionType == "logeventonly") {
       CommonUtils.NAVIGATE_PATH = CommonUtils.inboxPage;

       showAlertDialog_oneBtn(context, appName, msg);



     }
     else if (actionType == CommonUtils.KEY_MEMBER_POINT_TRANSACTION) {



             navigatePath=CommonUtils.rewards_popup;
             CommonUtils.PPN_RESPONSE_CONTENT=response.body;

      //processingPPNREsponseData(context,p3.toString()); // just hide

     }
     else if (actionType == CommonUtils.KEY_REWARD_REDEEM ) {
       navigatePath = CommonUtils.homePage;
       CommonUtils.PPN_RESPONSE_CONTENT = response.body;
       showAlertDialog_oneBtn(context,  appName, msg);

     }
     else if (actionType == CommonUtils.KEY_WALLET_SYNC) {
       navigatePath = CommonUtils.walletPage;
       CommonUtils.PPN_RESPONSE_CONTENT = response.body;
       showAlertDialog_oneBtn(context,  appName, msg);

     }
     else if (actionType == CommonUtils.KEY_WALLET_SYNC_NEW) {
       navigatePath = CommonUtils.walletPage;
       CommonUtils.PPN_RESPONSE_CONTENT = response.body;
       showAlertDialog_oneBtn(context, appName, msg);
     }
     else if (actionType == CommonUtils.KEY_FORCE_LOG_OUT) {
       showToast(msg, gravity: Toast.bottom);
       SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setString('alreadyLoggedIn', "");
       prefs.setString('consumerId', "");
       prefs.setString('consumerName', "");
       prefs.setString('consumerEmail', "");
      prefs.clear();

       CommonUtils.consumerID = "";
       CommonUtils.consumerName = "";
       CommonUtils.consumerEmail = "";
       navigatePath = CommonUtils.none;
       Navigator.pushReplacement(
           context, MaterialPageRoute(builder: (context) => SplashScreen(),));
       showToast( logout_message, gravity: Toast.bottom);
       // Need to call Api
     }
     else if (actionType == CommonUtils.KEY_FORCE_UPDATE) {
       navigatePath = CommonUtils.none;
       showAlertDialog_forAppUpdate(context, alert1, msg);
     }
     else if(actionType==CommonUtils.KEY_CALL_INBOX) {
             showAlertDialog_oneBtn_msg(context, msg);
             navigatePath=CommonUtils.inboxPage;

             CommonUtils.PPN_RESPONSE_CONTENT=response.body;
           }

     else if(actionType==CommonUtils.KEY_NEWSONLY) {
       showAlertDialog_oneBtn_msg(context, msg);
       navigatePath=CommonUtils.inboxPage;

       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
     }

     else if(actionType==CommonUtils.KEY_REMOVE_GIFT_VOUCHER) {
       showAlertDialog_oneBtn_msg(context, msg);
       navigatePath=CommonUtils.walletPage;

       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
     }

     else if(actionType==CommonUtils.KEY_GIFT_VOUCHER || actionType==CommonUtils.KEY_VOUCHER ) {
       showAlertDialog_oneBtn_msg(context, msg);
       navigatePath=CommonUtils.walletPage;

       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
     }
     else if(actionType==CommonUtils.KEY_WALLET_SYNC) {
       showAlertDialog_oneBtn_msg(context, msg);
       navigatePath=CommonUtils.walletPage;

       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
     }
     else if(actionType==CommonUtils.KEY_WALLET_SYNC_NEW) {
       showAlertDialog_oneBtn_msg(context, msg);
       navigatePath=CommonUtils.walletPage;

       CommonUtils.PPN_RESPONSE_CONTENT=response.body;
     }
     else{
       navigatePath=CommonUtils.none;
     }
   }

  } else {
    showAlertDialog_oneBtn(context, alert1, something_went_wrong1);
    throw "something_went_wrong1";
  }

  return navigatePath;

}

*/
/*
void processingPPNREsponseData(BuildContext context,var pnsId){
  var response=jsonEncode(CommonUtils.PPN_RESPONSE_CONTENT);
  var decodedResponse=jsonDecode(response);
  final Xml2Json xml2json = new Xml2Json();

  xml2json.parse(decodedResponse);
  var jsonstring = xml2json.toParker();
  var data = jsonDecode(jsonstring);
  var data1 = data['info'];




  var msg = Utils().stringSplit(data1['p2']);
  List<String> splitMsg=msg.split(";");
  String prgmId=splitMsg[1].split(":")[1];
  String outletId=splitMsg[2].split(":")[1];
  String totalAmount=splitMsg[3].split(":")[1];
  String timestamp=splitMsg[4].split(":")[1];
  String countryIndex=splitMsg[5].split(":")[1];
  String facebookpoints=splitMsg[6].split(":")[1];
  String queue=splitMsg[7].split(":")[1];
  String transactionId=splitMsg[8].split(":")[1];
  String feedbackPoints=splitMsg[9].split(":")[1];
  String imageUrl=splitMsg[10].split(":")[1];
  String memberId=splitMsg[11].split(":")[1];
  String merchantId=splitMsg[12].split(":")[1];
  String merchantName=splitMsg[13].split(":")[1];
  print("pnsId1"+pnsId);
  print(prgmId);
  print(outletId);
  print(totalAmount);
  print(timestamp);
  print(countryIndex);
  print(facebookpoints);
  print(queue);
  print(transactionId);
  print(feedbackPoints);
  print(imageUrl);
  print(memberId);
  print(merchantId);
  print(merchantName);

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MemberTransaction(
      prgmId, "", totalAmount, totalAmount, merchantId, merchantName, memberId, queue, transactionId, feedbackPoints, countryIndex, outletId, "1", imageUrl,pnsId
  ),));



}*/

