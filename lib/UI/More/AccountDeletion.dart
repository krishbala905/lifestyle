import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/Utils.dart';
import 'package:lifestyle/UI/More/MoreFragment.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/NativeAlertDialog.dart';
import 'package:lifestyle/Others/Urls.dart';
//import 'package:lifestyle/generated/l10n.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/res/Strings.dart';

class AccountDeletion extends StatefulWidget {
  const AccountDeletion({Key? key}) : super(key: key);

  @override
  State<AccountDeletion> createState() => _AccountDeletionState();
}

class _AccountDeletionState extends State<AccountDeletion> {
  bool IsloaderSet = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar:AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text(Confirm_Deletion_title),
          backgroundColor: Maincolor,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: 20.0,right: 20.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Text('We are sad that you want to leave us. Please note that account deletion is irreversible',style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF303030),
                          ),),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Important notes:',textAlign: TextAlign.left,style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ), ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 0,right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Icon(Icons.circle_rounded,size: 7,),
                                SizedBox(width: 15,),
                                Expanded(child: Text('It will take 14 working days to process your account deletion request.',style: (
                                    TextStyle(
                                      color: Color(0xFF303030),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    )
                                ),
                                  textAlign: TextAlign.left,
                                ),),

                              ],


                            ),

                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 0,right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Icon(Icons.circle_rounded,size: 7,),
                                SizedBox(width: 15,),
                                Expanded(child: Text('After the successful deletion of your account, you will be automatically forced to log out of this app. You will not be able to log in to a deleted account and view previous account history.',
                                  style: (
                                      TextStyle(
                                        color: Color(0xFF303030),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      )
                                  ),
                                  textAlign: TextAlign.left,
                                ),),

                              ],


                            ),

                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 0,right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Icon(Icons.circle_rounded,size: 7,),
                                SizedBox(width: 15,),
                                Expanded(child: Text('Any remaining balance, benefits, rewards, and credits in your account will be forfeited.',
                                  style: (
                                      TextStyle(
                                        color: Color(0xFF303030),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      )
                                  ),
                                  textAlign: TextAlign.left,
                                ),),

                              ],


                            ),

                          ),




                        ],

                      ),
                    ),
                    Expanded(flex:1,
                      child: Container(
                        padding: EdgeInsets.only(top: 50),
                        //color: Colors.red,
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 140,
                              child: TextButton(onPressed: (){

                                Navigator.pop(context, MaterialPageRoute(builder: (context ) => MoreFragment(),));
                              }, child: Text(cancel_caps ,style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),),
                                style: ButtonStyle(

                                    backgroundColor: MaterialStateProperty.all(Colors.grey,),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),


                                    ))


                                ),
                              ),


                            ),
                            SizedBox(
                              width: 140,
                              child: TextButton(onPressed: (){
                                showLoadingView(context);
                                initTimer();
                              }, child: Text(confirm_capital ,style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),),
                                style: ButtonStyle(

                                    backgroundColor:MaterialStateProperty.all(Color(0xFF35A099),),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),


                                    ))


                                ),
                              ),
                            ),

                          ],

                        ),


                      ),),
                  ],
                ),

              ),

            ),
            IsloaderSet == true ?
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: SpinKitCircle(
                  color: Maincolor,
                  size: 50.0,
                ),
              ),

            ):Container()

          ],
        )

      ),



    );
  }

  Future<void> showAlertDialog_oneBtnWitDismiss(BuildContext context,String tittle,String message) async
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
  Future<void> AccountDeletionApiCall()  async {
    print(AccountDeletionUrl);
    setState(() {
      IsloaderSet = true;
    });

try {
  var data = null;
  final http.Response response = await http.post(
    Uri.parse(AccountDeletionUrl),

    body: {

      "consumer_id": CommonUtils.consumerID,
      /*"cma_timestamps": Utils().getTimeStamp(),
      "time_zone": Utils().getTimeZone(),
      "software_version": CommonUtils.softwareVersion,
      "os_version": CommonUtils.osVersion,
      "phone_model": CommonUtils.deviceModel,
      "device_type": CommonUtils.deviceType,
      'consumer_application_type': CommonUtils.consumerApplicationType,
      'consumer_language_id': CommonUtils.APPLICATIONLANGUAGEID*/
    },
  ).timeout(Duration(seconds: 30));
  print(response.body);
  data = jsonDecode(response.body);

  var status = data['status'];
  var message = data['data'];

  if (status.toString().toLowerCase() == "true") {
   // ShowNativeDialogue(context, alert, data['data']);
     showAlertDialog_oneBtnWitDismiss(context,alert, message);
    //showAlertDialog_oneBtnWitDismiss(context, alert, data['data']).then((value) => Navigator.pop(context));
  }
  else {
    ShowNativeDialogue(context,alert, something_went_wrong);
    //showAlertDialog_oneBtn(context, alert, something_went_wrong);
  }
}
on TimeoutException catch (e) {
  setState(() {
    IsloaderSet = false;
  });
  ShowNativeDialogue(context,alert1,"time out!, try again later");

  print('Timeout Error: $e');
} on SocketException catch (e) {
  setState(() {
    IsloaderSet = false;
  });
  ShowNativeDialogue(context,alert1, "Please check your internet connection");

  print('Socket Error: $e');
} on Error catch (e) {
  setState(() {
    IsloaderSet = false;
  });
  print('General Error: $e');
}

    setState(() {
      IsloaderSet = false;
    });
  }

  void initTimer() async{
    if(await checkinternet()){
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");
        AccountDeletionApiCall();
        // updateprofile(usn,radio,date,addr,mob,email,image1,countrycode);

      });
    }else{
      showAlertDialog_oneBtnprof(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
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
  void showAlertDialog_oneBtnprof(BuildContext context,String tittle,String message)
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
    );
  }
}
