import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/Others/Utils.dart';
//import 'package:lifestyle/generated/l10n.dart';
import 'package:lifestyle/res/Colors.dart';
//import 'package:lifestyle/res/Strings.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/res/Strings.dart';
import 'package:xml2json/xml2json.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgotpasswd_cntrl=TextEditingController();
  var email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(backgroundColor: Maincolor,centerTitle: true,
        elevation:1,
        title: Text(forgott_password,style: TextStyle(color: Colors.white,fontSize:20 ),),),

      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Container(
              width: 170,
              child: Text(please_enter_your_email_address_to_reset_your_passworrd,textAlign: TextAlign.center,style:TextStyle(color: lightGrey,fontSize: 12,)),
            ),
            SizedBox(height: 40,),
            Container(decoration: BoxDecoration(color: Colors.grey),height: 0.5,),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width:50,
                    child: Icon(Icons.email_outlined,size: 25,color: Colors.grey,),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left:25),
                    child: TextField(
                      cursorColor:  Colors.white,
                      controller: forgotpasswd_cntrl,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_!#$%&*+-/=?^\`{|}~]')),
                      ],
                      style: TextStyle(color: textNormal, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: lightGrey),
                        border: InputBorder.none,
                      ),

                    ),
                  ),flex: 1,),

                  SizedBox(width:25),
                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: Colors.grey),height: 0.5,),


            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                // Validation
                 email=forgotpasswd_cntrl.text.toString();
                if(email.length==0){
                  showAlertDialog_oneBtn(context,alert1,enter_empty_email);
                }
                else if(validateEmail(email)!="1"){
                  showAlertDialog_oneBtn(context, alert1,enter_valid_email);
                }
                else{
                  showLoadingView(context);
                  initTimer();
                   // callApi(email);
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                child: Container(
                  height: 40,

                  decoration: BoxDecoration(
                    color: Maincolor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),

                  child: Center(child: Text(retrievepassword,style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.center,)),
                ),
              ),
            ),

          ],

        ),
      ),

    ));
  }

  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return '0';
    } else {
      return "1";
    }
  }
  Future<void> callApi(var email) async {
    var data=null;
    print("url:"+RESETPASSWORD_URL);

    final http.Response response = await http.post(
      Uri.parse(RESETPASSWORD_URL),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: {
        "email": email,
        "action_event": "30",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
      },
    ).timeout(Duration(seconds: 30));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var data2 = data['info'];
      var status = stringSplit(data2['p1']);
      var messg = stringSplit(data2['p2']);
    showAlertDialog_oneBtnWitDismiss(context, alert, messg);
      /*data=await jsonDecode(response.body);
      var status=data["status"].toString();
      var message=data["data"].toString();*/

     /* if(status=="True"){
        showAlertDialog_oneBtnWitDismiss(context, alert, message);
      }
      else{
        showAlertDialog_oneBtn(context, alert, message);
      }*/

    } else {
      showAlertDialog_oneBtnWitDismiss(context, alert1, something_went_wrong1);
    }


  }

  String stringSplit(String data) {
    return data.split("*%8%*")[0];
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
          onTap: (){
            Navigator.pop(context,true);
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
  void initTimer() async{
    if(await checkinternet()){
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");

         callApi(email);

      });
    }else{
      showAlertDialog_oneBtnWitDismiss(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
    }

  }

  Future<bool> checkinternet()async{
    var connectivityresult = await(Connectivity().checkConnectivity());
    if(connectivityresult == ConnectivityResult.none){
      print("not connected");
      return false;
    }
    else{
      return true;
    }
  }
}
