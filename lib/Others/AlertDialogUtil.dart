import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:launch_review/launch_review.dart';
import 'package:http/http.dart' as http;

import 'package:xml2json/xml2json.dart';

import 'package:lifestyle/res/Colors.dart';
import '../res/Strings.dart';
import 'CommonUtils.dart';
import 'Urls.dart';
import 'Utils.dart';


var actionType;
var prgmId;
var transValue;
var transType;
var transId;
var upgraded;
var upgradedTittle;
var merchantName;
var topup;
var recieved;
var redeemed;
var fbPoints;
var outletid;
var feebackPoints;
var cardurl;
var memberid;

void showAlertDialog_oneBtn(BuildContext context,String tittle,String message)
{
  AlertDialog alert = AlertDialog(

    backgroundColor: Colors.white,
    title: Text(tittle),
    // content: CircularProgressIndicator(),
    content: Text(message,style: TextStyle(color: Colors.black45)),
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
            child:Center(child: Text(ok,style: TextStyle(color:Maincolor),)),
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

void showAlertDialog_oneBtn_msg(BuildContext context,String message)
{
  AlertDialog alert = AlertDialog(

    backgroundColor: Colors.white,
    title: Text(message,style: TextStyle(fontSize: 13),),
    // content: CircularProgressIndicator(),

    actions: [
      GestureDetector(
        onTap: (){Navigator.pop(context,true);},
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 35,
            width: 100,
            color: Colors.white,
            child:Center(child: Text(ok,style: TextStyle(color: Maincolor),)),
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

void showAlertDialogoneBtn_lc(BuildContext context,String tittle)
{
  AlertDialog alert = AlertDialog(

    backgroundColor: Colors.white,
    title: Text(tittle,style: TextStyle(color:Colors.grey,fontSize: 14)),
    // content: CircularProgressIndicator(),

    actions: [
      GestureDetector(
        onTap: (){Navigator.pop(context,true);},
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 35,
            width: 100,
            color: Colors.white,
            child:Center(child: Text(ok,style: TextStyle(color: Maincolor),)),
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
String stringSplitfb(String data) {
  return data.split("->")[0];
}

void showRewardsDeliveryDialog1(BuildContext context,var data){
  data=jsonDecode(data);
  debugPrint("DEDUCT:"+data['DEDUCT']);
  debugPrint("OUTLETID:"+data['OUTLETID']);
  debugPrint("COUNTRYINDEX:"+data['COUNTRYINDEX']);
  debugPrint("PROGRAM_ID:"+data['PROGRAM_ID']);
  debugPrint("CARD_TITLE:"+data['CARD_TITLE']);
  debugPrint("TRANSACTIONVALUE:"+data['TRANSACTIONVALUE']);
  debugPrint("TRANSACTIONTYPE:"+data['TRANSACTIONTYPE']);
  debugPrint("TRANSACTIONID:"+data['TRANSACTIONID']);
  debugPrint("REDEEMED_TITLE:"+data['REDEEMED_TITLE']);
  debugPrint("UPGRADED:"+data['UPGRADED']);
  debugPrint("UPGRADED_TITLE:"+data['UPGRADED_TITLE']);
  debugPrint("CARD_TYPE:"+data['CARD_TYPE']);
  debugPrint("MERCHANT_ID:"+data['MERCHANT_ID']);
  debugPrint("MEMBER_ID:"+data['MEMBER_ID']);
  debugPrint("MERCHANT_NAME:"+data['MERCHANT_NAME']);
  debugPrint("TOPUP:"+data['TOPUP']);
  debugPrint("RECEIVED:"+data['RECEIVED']);
  debugPrint("REDEEMED:"+data['REDEEMED']);
// debugPrint("test0:"+data['ISSUED_POINTS']);
  debugPrint("FEEDBACK_POINTS:${data['FEEDBACK_POINTS']}");
  debugPrint("FB_POINTS:${data['FB_POINTS']}");
  debugPrint("card_img:${data['CARD_URL']}");


  //var deduct=data['DEDUCT'];
  //var outletId=data['OUTLETID'];
  // var COUNTRYINDEX=data['COUNTRYINDEX'];
  actionType=data["ACTION"].toString();
  prgmId=data['PROGRAM_ID'];
  //var cardTittle=data['CARD_TITLE'];
  transValue=data['TRANSACTIONVALUE'];
  transType=data['TRANSACTIONTYPE'];
  transId=data['TRANSACTIONID'];
  // var redeemedTittle=data['REDEEMED_TITLE'];
  upgraded=data['UPGRADED'];
  upgradedTittle=data['UPGRADED_TITLE'];
  //var cardType=data['CARD_TYPE'];

  //var merchantId=data['MERCHANT_ID'];
  // var memberId=data['MEMBER_ID'];
  merchantName=data['MERCHANT_NAME'];
  topup=data['TOPUP'];
  recieved=data['RECEIVED'];
  redeemed=data['REDEEMED'];
  memberid = data['MEMBER_ID'];
  outletid = data['OUTLETID'];
  // var issuedPoints=data['ISSUED_POINTS'];
  fbPoints=data['FB_POINTS'].toString();
  feebackPoints=data['FEEDBACK_POINTS'].toString();
  cardurl = stringSplitfb(data['CARD_URL']).toString();




  showDialog(
      context: context,

      builder: (_) =>  AlertDialog(
        content:Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Image.asset('assets/reward_gift_icon.png',width: 100,height: 100,),

              if(transType!="none") Center(child: Text(transValue,style: TextStyle(fontSize: 20),)),
              const SizedBox(height: 10,),
              if(transType!="none")Text(transType,style: TextStyle(fontSize: 14,color: Colors.black)),
              const SizedBox(height: 10,),
              if(redeemed!="none")Align(alignment: Alignment.topLeft,child: Text(redeemed_string,style: TextStyle(fontSize: 14,color: Maincolor))),

              if(redeemed!="none")Align(alignment:Alignment.topLeft,child: Html(data:redeemed)),
              const SizedBox(height: 10,),


              if(recieved!="none") Align(
                alignment: Alignment.topLeft,
                child: Text(recieved_string,style: TextStyle(color: Maincolor),),
              ),
              if(recieved!="none") Align(
                  alignment: Alignment.topLeft,
                  child: Text(recieved.replaceAll("<br>","\r\n"+"\n"))),
              if(topup!="none")Align(alignment: Alignment.topLeft,child:Text(topped_up_string,style: TextStyle(color: Maincolor,fontSize: 11),),),
              if(topup!="none")Align(alignment: Alignment.topLeft,child:Html(data: topup),),
              SizedBox(height: 10,),
              if(merchantName!="none")  Align(alignment:Alignment.topLeft,child: Text("@ "+merchantName,style: TextStyle(color: Maincolor,fontSize: 14))),
              if(upgradedTittle!="none") Center(child: Text(upgraded.replaceAll("<br>","\r\n")+"\n"+upgradedTittle)),


              SizedBox(height: 15,),
              if((topup!="none")||fbPoints!="0"&&fbPoints!="none") Align(
                  alignment: Alignment.topLeft,
                  child: Text("+ "+fbPoints+" points",style: TextStyle(fontSize: 11,color:Maincolor ),)),
              SizedBox(height: 5,),

              Row(

                children: [
                 // if((topup!="none")||fbPoints!="0"&&fbPoints!="none")

                   Expanded(flex: 1,child: InkWell(
                    onTap: (){
                      print("checkk");
                      Navigator.pop(context, true);

                      // Gokul Commented on 28Nov2022
                      //shareToFeedFacebookLink(url: cardurl, context: context,quote: 'hello');
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Maincolor),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text(share,style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(width: 10,),
                  if(actionType==CommonUtils.KEY_MEMBER_POINT_TRANSACTION)Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      //     TransactionFeedback(feebackPoints, transId, prgmId),));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                  if(topup!="none")Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionFeedback(feebackPoints, transId, prgmId),));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                  if(actionType!=CommonUtils.KEY_MEMBER_POINT_TRANSACTION&&topup=="none")Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);

                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                ],
              ),

            ],
          ),
        ),
      ));


}

void showRewardsDeliveryDialog(BuildContext context,var data){

  data=jsonDecode(data);
  debugPrint("DEDUCT:"+data['DEDUCT']);
  debugPrint("OUTLETID:"+data['OUTLETID']);
  debugPrint("COUNTRYINDEX:"+data['COUNTRYINDEX']);
  debugPrint("PROGRAM_ID:"+data['PROGRAM_ID']);
  debugPrint("CARD_TITLE:"+data['CARD_TITLE']);
  debugPrint("TRANSACTIONVALUE:"+data['TRANSACTIONVALUE']);
  debugPrint("TRANSACTIONTYPE:"+data['TRANSACTIONTYPE']);
  debugPrint("TRANSACTIONID:"+data['TRANSACTIONID']);
  debugPrint("REDEEMED_TITLE:"+data['REDEEMED_TITLE']);
  debugPrint("UPGRADED:"+data['UPGRADED']);
  debugPrint("UPGRADED_TITLE:"+data['UPGRADED_TITLE']);
  debugPrint("CARD_TYPE:"+data['CARD_TYPE']);
  debugPrint("MERCHANT_ID:"+data['MERCHANT_ID']);
  debugPrint("MEMBER_ID:"+data['MEMBER_ID']);
  debugPrint("MERCHANT_NAME:"+data['MERCHANT_NAME']);
  debugPrint("TOPUP:"+data['TOPUP']);
  debugPrint("RECEIVED:"+data['RECEIVED']);
  debugPrint("REDEEMED:"+data['REDEEMED']);
// debugPrint("test0:"+data['ISSUED_POINTS']);
  debugPrint("FEEDBACK_POINTS:${data['FEEDBACK_POINTS']}");
  debugPrint("FB_POINTS:${data['FB_POINTS']}");
  debugPrint("card_img:${data['CARD_URL']}");


  //var deduct=data['DEDUCT'];
  //var outletId=data['OUTLETID'];
  // var COUNTRYINDEX=data['COUNTRYINDEX'];
   actionType=data["ACTION"].toString();
   prgmId=data['PROGRAM_ID'];
  //var cardTittle=data['CARD_TITLE'];
  transValue=data['TRANSACTIONVALUE'];
  transType=data['TRANSACTIONTYPE'];
  transId=data['TRANSACTIONID'];
  // var redeemedTittle=data['REDEEMED_TITLE'];
  upgraded=data['UPGRADED'];
   upgradedTittle=data['UPGRADED_TITLE'];
  //var cardType=data['CARD_TYPE'];

  //var merchantId=data['MERCHANT_ID'];
  // var memberId=data['MEMBER_ID'];
   merchantName=data['MERCHANT_NAME'];
  topup=data['TOPUP'];
  recieved=data['RECEIVED'];
  redeemed=data['REDEEMED'];
  memberid = data['MEMBER_ID'];
  outletid = data['OUTLETID'];
  // var issuedPoints=data['ISSUED_POINTS'];
   fbPoints=data['FB_POINTS'].toString();
  feebackPoints=data['FEEDBACK_POINTS'].toString();
   cardurl = stringSplitfb(data['CARD_URL']).toString();




  showDialog(
      context: context,

      builder: (_) =>  AlertDialog(
        content:Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Image.asset('assets/reward_gift_icon.png',width: 100,height: 100,),

              if(transType!="none") Center(child: Text(transValue,style: TextStyle(fontSize: 20),)),
              const SizedBox(height: 10,),
              if(transType!="none")Text(transType,style: TextStyle(fontSize: 14,color: Colors.black)),
              const SizedBox(height: 10,),
              if(redeemed!="none")Align(alignment: Alignment.topLeft,child: Text(redeemed_string,style: TextStyle(fontSize: 14,color: Maincolor))),

              if(redeemed!="none")Align(alignment:Alignment.topLeft,child: Html(data:redeemed)),
              const SizedBox(height: 10,),


              if(recieved!="none") Align(
                alignment: Alignment.topLeft,
                child: Text(recieved_string,style: TextStyle(color: Maincolor),),
              ),
              if(recieved!="none") Align(
                  alignment: Alignment.topLeft,
                  child: Text(recieved.replaceAll("<br>","\r\n"+"\n"))),
              if(topup!="none")Align(alignment: Alignment.topLeft,child:Text(topped_up_string,style: TextStyle(color: Maincolor,fontSize: 11),),),
              if(topup!="none")Align(alignment: Alignment.topLeft,child:Html(data: topup),),
              SizedBox(height: 10,),
              if(merchantName!="none")  Align(alignment:Alignment.topLeft,child: Text("@ "+merchantName,style: TextStyle(color: Maincolor,fontSize: 14))),
              if(upgradedTittle!="none") Center(child: Text(upgraded.replaceAll("<br>","\r\n")+"\n"+upgradedTittle)),


              SizedBox(height: 15,),
              if((topup!="none")||fbPoints!="0"&&fbPoints!="none") Align(
                  alignment: Alignment.topLeft,
                  child: Text("+ "+fbPoints+" points",style: TextStyle(fontSize: 11,color:Maincolor ),)),
              SizedBox(height: 5,),

              Row(

                children: [

                  if((topup!="none")||fbPoints!="0"&&fbPoints!="none") Expanded(flex: 1,child: InkWell(
                    onTap: (){
                      print("checkk");
                      //Navigator.pop(context, true);

                      // Gokul Commented on 28Nov2022
                      //shareToFeedFacebookLink(url: cardurl, context: context);
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Maincolor),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text(share,style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(width: 10,),
                  if(actionType==CommonUtils.KEY_MEMBER_POINT_TRANSACTION)Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      //     TransactionFeedback(feebackPoints, transId, prgmId),));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                  if(topup!="none")Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionFeedback(feebackPoints, transId, prgmId),));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                  if(actionType!=CommonUtils.KEY_MEMBER_POINT_TRANSACTION&&topup=="none")Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);

                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                ],
              ),

            ],
          ),
        ),
      ));


}

void showRewardsDeliveryDialogForXML(BuildContext context,String value){
  final Xml2Json xml2json = new Xml2Json();
  xml2json.parse(value);
  var jsonstring = xml2json.toParker();
  var data = jsonDecode(jsonstring);
  var data1 = data['info'];



    String p2 = Utils().stringSplit(data1['p2']).toString();
    var p2Data = p2.split(";");


    String actionType = p2Data[0].split(":")[2];


    var p3 = Utils().stringSplit(data1['p3']);
    var msg = Utils().stringSplit(data1['p4']);



    showDialog(
      context: context,

      builder: (_) =>  AlertDialog(
        content:Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Image.asset('assets/reward_gift_icon.png',width: 100,height: 100,),

              if(transType!="none") Center(child: Text(transValue,style: TextStyle(fontSize: 20),)),
              const SizedBox(height: 10,),
              if(transType!="none")Text(transType,style: TextStyle(fontSize: 14,color: Colors.black)),
              const SizedBox(height: 10,),
              if(redeemed!="none")Align(alignment: Alignment.topLeft,child: Text(redeemed_string,style: TextStyle(fontSize: 14,color: Maincolor))),

              if(redeemed!="none")Align(alignment:Alignment.topLeft,child: Html(data:redeemed)),
              const SizedBox(height: 10,),


              if(recieved!="none") Align(
                alignment: Alignment.topLeft,
                child: Text(recieved_string,style: TextStyle(color: Maincolor),),
              ),
              if(recieved!="none") Align(
                  alignment: Alignment.topLeft,
                  child: Text(recieved.replaceAll("<br>","\r\n"+"\n"))),
              if(topup!="none")Align(alignment: Alignment.topLeft,child:Text(topped_up_string,style: TextStyle(color: Maincolor,fontSize: 11),),),
              if(topup!="none")Align(alignment: Alignment.topLeft,child:Html(data: topup),),
              SizedBox(height: 10,),
              if(merchantName!="none")  Align(alignment:Alignment.topLeft,child: Text("@ "+merchantName,style: TextStyle(color: Maincolor,fontSize: 14))),
              if(upgradedTittle!="none") Center(child: Text(upgraded.replaceAll("<br>","\r\n")+"\n"+upgradedTittle)),


              SizedBox(height: 15,),
              if((topup!="none")||fbPoints!="0"&&fbPoints!="none") Align(
                  alignment: Alignment.topLeft,
                  child: Text("+ "+fbPoints+" points",style: TextStyle(fontSize: 11,color:Maincolor ),)),
              SizedBox(height: 5,),

              Row(

                children: [

                  if((topup!="none")||fbPoints!="0"&&fbPoints!="none") Expanded(flex: 1,child: InkWell(
                    onTap: (){
                      print("checkk");
                      //Navigator.pop(context, true);

                      // Gokul Commented on 28Nov2022
                      //shareToFeedFacebookLink(url: cardurl, context: context);
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Maincolor),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text(share,style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(width: 10,),
                  if(actionType==CommonUtils.KEY_MEMBER_POINT_TRANSACTION)Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      //     TransactionFeedback(feebackPoints, transId, prgmId),));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                  if(topup!="none")Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionFeedback(feebackPoints, transId, prgmId),));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                  if(actionType!=CommonUtils.KEY_MEMBER_POINT_TRANSACTION&&topup=="none")Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);

                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(color: Maincolor),
                      child: Center(child: Text(ok,style: TextStyle(color: Colors.white))),),
                  )),
                ],
              ),

            ],
          ),
        ),
      ));


}

void showThanksDialog(BuildContext context,String mes)
{
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(10.0)), //this right here
          child: Container(
            height: 240,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/thanks_img.png',height: 100,width: 100,),
                    SizedBox(height: 20,),
                    Text(mes),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){Navigator.pop(context,true);},
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 35,
                          width: 100,
                          color: Maincolor,
                          child:Center(child: Text(ok,style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
        );
      });
}


void showAlertDialog_forAppUpdate(BuildContext context,String tittle,String message)
{
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: Text(tittle),
    // content: CircularProgressIndicator(),
    content: Text(message,style: TextStyle(color: Colors.black45)),
    actions: [
      GestureDetector(
        onTap: (){
          if(CommonUtils.deviceType==1){
            //Apple
            gotoAppstore(context);
          }
          else if(CommonUtils.deviceType==2){
            // android
            gotoPlaystore(context);
          }

        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 35,
            width: 100,
            color: Colors.white,
            child:Center(child: Text(ok,style: TextStyle(color: Maincolor),)),
          ),
        ),
      ),
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void gotoPlaystore(BuildContext context){
  LaunchReview.launch(
    androidAppId: "com.cathay.lifestyle",

  );
}
void gotoAppstore(BuildContext context){
  LaunchReview.launch(
    iOSAppId: "585027354",
  );
}

void showAlertDialog_oneBtnWitDismiss(BuildContext context,String tittle,String message)
{
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: Text(tittle),
    // content: CircularProgressIndicator(),
    content: Text(message,style: TextStyle(color: Colors.black45)),
    actions: [
      GestureDetector(
        onTap: (){Navigator.pop(context,true);


        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 35,
            width: 100,
            color: Colors.white,
            child:Center(child: Text(ok,style: TextStyle(color: Maincolor),)),
          ),
        ),
      ),
    ],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((exit){
    if (exit == null) return;

    if (exit) {
      // back to previous screen

      Navigator.pop(context);
    } else {
      // user pressed No button
    }
  });

}
void showLoadingView(BuildContext context){
AlertDialog   alert = AlertDialog(
    backgroundColor: Colors.white,

    // content: CircularProgressIndicator(),
    content: Container(
      height: 50,
      child: Center(
        child: Row(
          children: [
            SpinKitCircle(
            color: Maincolor,
            size: 50.0,
            ),
            Text(loading,style: TextStyle(color: Colors.black,fontSize: 18),),
          ],
        ),
      ),
    ),

  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );



}


Future<void> feedbackpoints(BuildContext context) async {

  final http.Response response = await http.post(
    Uri.parse(FBPOSTSTATUSCMD),
    body: {
      "device_type": CommonUtils.deviceType,
      "device_token": CommonUtils.deviceToken,
      "cma_timestamps": Utils().getTimeStamp(),
      "time_zone": Utils().getTimeZone(),
      "software_version": CommonUtils.softwareVersion,
      "os_version": CommonUtils.osVersion,
      'consumer_application_type': CommonUtils.consumerApplicationType,
      'consumer_language_id': CommonUtils.consumerLanguageId,
      'device_token_id': CommonUtils.deviceTokenID,
      'consumer_id':  CommonUtils.consumerID,
      'program_id' : prgmId,
     //  'transaction_program_idNewUiPPNcmdforAllCma': prgmId,
      'merchant_id': CommonUtils.merchantID,
      'member_id': memberid,
      'outlet_id':  outletid,
      'reward_points': fbPoints,
      'transaction_id': transId,
     // 'country_index':  CommonUtils.countryindex,
    },
  ).timeout(Duration(seconds: 30));
  print("chcek"+response.body.toString());
  var data=jsonDecode(response.body);
  print("check1"+data.toString());
  var status = data["Status"];
  var msg = data["Message"];
  if (status == 'True' || status == '1') {
    print("check3");
   //  Navigator.pop(context);
    showThanksDialog(context, msg);
  }
  else {
    showAlertDialog_oneBtn(context,alert1, msg);
  }
}

