import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lifestyle/UI/Singup/OTPActivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import '';
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MobileNumberVerification extends StatefulWidget {
  const MobileNumberVerification({Key? key}) : super(key: key);

  @override
  State<MobileNumberVerification> createState() => _MobileNumberVerificationState();
}

class _MobileNumberVerificationState extends State<MobileNumberVerification> {
  TextEditingController mobileNumberTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Maincolor,
          elevation: 1,
          centerTitle: true,
          title: Text(
            create_new_account,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            color: Colors.white,
            icon:Icon(Icons.arrow_back),
            //replace with our own icon data.
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  please_verify_your_local_mobile_number,
                  style: TextStyle(fontSize: 14,),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            country,
                            style: TextStyle(fontSize: 14,color: Colors.black38),
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: Text(
                      singapore,
                      style: TextStyle(fontSize: 14,color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                color: lightGrey,
                width: double.infinity,
              ),
              Container(
                height: 50,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.phone_android_rounded,
                                color: lightGrey,
                              ),
                              Text(
                                country_code,
                                style: TextStyle(fontSize: 14,color: Colors.black38),
                              )
                            ],
                          )),
                      Container(
                        height: 40,
                        color: lightGrey,
                        width: 1,
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextField(
                              controller: mobileNumberTextController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                             inputFormatters: [
                               LengthLimitingTextInputFormatter(8,),
                             ],
                             // maxLength: 8,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(fontSize: 14),
                                hintStyle: TextStyle(fontSize: 14,color: Colors.black38),
                                border: InputBorder.none,
                                hintText: mobile_number,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: lightGrey,
                width: double.infinity,
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    String data = mobileNumberTextController.text;
                    if (data == "") {
                      showAlertDialog_oneBtn(
                          context, alert, please_enter_mobile_number);
                    } else if (data.length != 8 ||
                        ((data[0] != '8') &&
                            (data[0] != '9') &&
                            (data[0] != '3') &&
                            (data[0] != '6'))) {
                      showAlertDialog_oneBtn(
                          context, alert, please_enter_valid_mobile_number);
                    } else {
    var connectivityresult = await(Connectivity().checkConnectivity());
    if(connectivityresult == ConnectivityResult.mobile || connectivityresult == ConnectivityResult.wifi ) {
      print("connecr");
      showLoadingView(context);
      callMobilNumberVerificationAPI(data);
    }
    else{
    showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
    print("notttt");

    }
                    }

                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Maincolor,

                        borderRadius: BorderRadius.circular(22.5),

                      ),
                      child: Center(
                          child: Text(
                            submit_small,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> callMobilNumberVerificationAPI(var data) async{

    final http.Response response = await http.post(
      Uri.parse(MOBILE_NUMBER_VERIFICATION_URL),

      body: {
        "phone_no": data,
        "action_event": "1",
        "device_token": "",
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        //  "os_version":CommonUtils.osVersion,
        // "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,

      },
    ).timeout(Duration(seconds: 30));
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var dataa = jsonDecode(jsonstring);
    var data2 = dataa['info'];
    print("checkresponse"+ data2.toString());
    var status = stringSplit(data2['p1']);
    var Message = stringSplit(data2['p4']);

    if(status=="1"){
      var mobileNumber=data.toString();
      var transId=stringSplit(data2['p3']);
      var otpCode=stringSplit(data2['p2']);
      print("chekcverficationcoe"+ otpCode.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => OTPActivity(transId, mobileNumber, otpCode)));

    }
    else{
      Navigator.pop(context,true);
      print("message"+ Message.toString());
      showAlertDialog_oneBtn(context,alert, Message);
    }
  }
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
  void dispose(){
    super.dispose();
  }
}
