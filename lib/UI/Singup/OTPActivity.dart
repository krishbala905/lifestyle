import 'dart:async';
import 'dart:convert';

import 'package:lifestyle/UI/Singup/SignupScreen.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/style.dart';
import 'package:xml2json/xml2json.dart';

import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Strings.dart';

class OTPActivity extends StatefulWidget {
  var transId, mobileNumber, otpCode;
   OTPActivity(this.transId,this.mobileNumber,this.otpCode,{Key? key}) : super(key: key);


  @override
  State<OTPActivity> createState() => _OTPActivityState(transId,mobileNumber,otpCode);
}

class _OTPActivityState extends State<OTPActivity> {
  var transId, mobileNumber, otpCode;
  _OTPActivityState(this.transId, this.mobileNumber, this.otpCode);
  var pin,newpin;
  Timer? timer;
  int secondsremaining = 60;
  bool enable = false;
  OtpFieldController  otpTextController=OtpFieldController();
  void initState(){
    super.initState();
startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: Maincolor,
          centerTitle: true,
          elevation: 1,
          title: Text(
            create_new_account,
            style: TextStyle(color:Colors.white, fontSize: 20),
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: Colors.white,
            icon:Icon(Icons.arrow_back_ios),
            //replace with our own icon data.
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Text(enter_verification_code,style: TextStyle(fontSize: 14),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: OTPTextField(
                    controller: otpTextController,
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 30,
                    fieldStyle: FieldStyle.underline,
                    outlineBorderRadius: 15,
                    style: TextStyle(fontSize: 15,),
                    onChanged: (pin) {
                      setState(() {
                        newpin = pin;
                      });
                      print("Changed: " + newpin);
                    },
                    onCompleted: (pin) {
                      var newpin = pin;
                      print("checknew"+ newpin.toString());
                      print("Completed: " + pin);
                    }),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left:20,right: 20),
                child: InkWell(
                  onTap: (){
                    var dataa=newpin.toString();
                    print("chekj"+newpin.toString());
                    print("chekc"+ dataa.length.toString());
                    if(dataa.toString()=="null" || dataa.length<4){
                      showAlertDialog_oneBtn(context, alert, enter_verification_otp);
                    }
                    else if(dataa != otpCode){
                      showAlertDialog_oneBtn(context, alert, enter_valid_verification_otp);
                    }
                    else{
                      timer?.cancel();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          SignupScreen(mobileNumber: mobileNumber) ));

                      /*print("mobile"+ mobileNumber.toString());
                      callMobilNumberVerificationAPI(mobileNumber);*/
                    }


                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Maincolor,
                      borderRadius: BorderRadius.circular(20),
                      //border: Border.all(color: colorPrimary),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Center(child: Text(confirm,style: TextStyle(color: Colors.white,fontSize: 15),)),
                  ),
                ),
              ),
              SizedBox(height: 4,),
              enable == true?
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        secondsremaining = 60;
                        enable = false;
                        startTimer();
                      });
                      print("mobile"+ mobileNumber.toString());
                      callMobilNumberVerificationAPI(mobileNumber);
                    },
                    child: Text("Send again",style: TextStyle(
                      fontSize: 14.0,color: lightGrey,
                    ),),
                  ),
                ],
              ):
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {

                    },
                    child: Text("Send again in $secondsremaining sec",style: TextStyle(
                      fontSize: 14.0,
                      color: lightGrey
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Center(child: Text(otpCode),)
            ],
          ),


        ),
      ),
      ),
    );
  }
  Future<void> callMobilNumberVerificationAPI(var data) async{

    final http.Response response = await http.post(
      Uri.parse(MOBILE_NUMBER_VERIFICATION_URL),

      body: {
        "phone_no": mobileNumber,
        "device_token": "",
        //  "trans_Id": transId,
        //  "verification_code": data,
        "action_event": "1",
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
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
    print("checkbhar");
    if(status=="1"){
      setState(() {
        transId=stringSplit(data2['p3']);
        otpCode=stringSplit(data2['p2']);
        print("chekcverficationcoe"+ otpCode.toString());
      });

    }
    else{
      print("message"+ Message.toString());

    }


  }
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_){
      print("check"+secondsremaining.toString());
      if(secondsremaining>0){
        print("check1");
        setState(() {
          secondsremaining--;
        });
      }
      else{
        print("check2");
        setState(() {
          enable = true;
          timer?.cancel();
        });
      }
    });
  }
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
}
