import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lifestyle/OnboardingFragment.dart';
import 'package:lifestyle/Others/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'Others/CommonUtils.dart';
import 'UI/ConsumerTab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Utils().getDeviceINFO();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _setloadingPage();
    });
    getToken();

    super.initState();
  }
  getToken() async {
    if (Platform.isAndroid) {
      // if(CommonUtils.new_huwavei_device==0){
      CommonUtils.deviceToken = await FirebaseMessaging.instance.getToken();
      // }
      /*else{

        await Push.setAutoInitEnabled(true);
        Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
        CommonUtils.DEVICE_HUWAEI_APPID = (await Push.getAppId());
        CommonUtils.DEVICE_HUWAEI_AAID = (await Push.getAAID())!;
      }*/


    }
    else if (Platform.isIOS) {

      CommonUtils.deviceToken=await FirebaseMessaging.instance.getToken();
      if (CommonUtils.deviceToken == null) {
        CommonUtils.deviceToken = "NO PNS";
      }

    }
    debugPrint("DeviceToken:"+CommonUtils.deviceToken.toString());
  }
    _setloadingPage() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var alreadyLoggedIn=prefs.getString('alreadyLoggedIn');

      CommonUtils.consumerID =prefs.getString('consumerId');
      CommonUtils.consumerName=prefs.getString('consumerName');
      CommonUtils.consumerEmail=prefs.getString('consumerEmail');
      CommonUtils.consumermobileNumber=prefs.getString('consumerMobile');
      // CommonUtils.consumerEmail=" ";
      CommonUtils.deviceTokenID=prefs.getString('consumerDeviceTokenId');
      CommonUtils.APPLICATIONLANGUAGEID=prefs.getString('ApplicationLanguageId');

print("bharathi"+ CommonUtils.consumerID.toString());

      Timer(Duration(seconds: 3), () {
        print(alreadyLoggedIn.toString());
        if(alreadyLoggedIn==null||alreadyLoggedIn==""){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OnboardingFragment()));
        }
        else{
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ConsumerTab()));
        }

      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/welcomescreen.jpg',fit: BoxFit.fill),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
