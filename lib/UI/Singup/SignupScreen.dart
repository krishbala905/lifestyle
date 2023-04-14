import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:lifestyle/UI/ConsumerTab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/Others/Utils.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../../res/Strings.dart';
class SignupScreen extends StatefulWidget {
  var mobileNumber;
  SignupScreen({Key? key,required this.mobileNumber}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState(mobileNumber);
}

class _SignupScreenState extends State<SignupScreen> {
  var mobileNumber;
  var updatevia = "";
  TextEditingController name_cntrl = TextEditingController();
  TextEditingController surname_cntrl = TextEditingController();
  TextEditingController mobile_cntrl = TextEditingController();
  TextEditingController emailId_cntrl = TextEditingController();
  TextEditingController pwdId_cntrl = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  // TextEditingController radio_cntrl = TextEditingController();
  // Default Radio Button Selected Item When App Starts.
  bool _obscured=true;
  final textFieldFocusNode = FocusNode();
  String radioButtonItem = '';
  var otpCode;
  var email,pwd,usn,surusn,date,mob;
  bool ChecktickBox = false;
  bool ChecktickBoxsms = false;
  bool ChecktickBoxtermscondition = false;
  // Group Value for Radio Button.
  var id = 1;
  void initState() {
    // TODO: implement initState
    print("check"+mobileNumber.toString());
    super.initState();
    _obscured=true;
    hideKeyboard();
    setState(() {
      mobile_cntrl.text = mobileNumber.toString();
      // id = 1;
    });
  }
  _SignupScreenState(this.mobileNumber);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Maincolor,
            centerTitle: true,
            title: Text(
              create_new_account,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              color: Colors.white,
              icon:Icon(Icons.arrow_back_ios),
              //replace with our own icon data.
            ),
            actions: [
              InkWell(
                onTap: () {
                  email = emailId_cntrl.text.toString().trim();
                  pwd = pwdId_cntrl.text.toString();
                  usn = name_cntrl.text.toString().trim();
                  surusn = surname_cntrl.text.toString().trim();
                  date = dateinput.text.toString();
                  mob = mobile_cntrl.text.toString();
                  if(radioButtonItem==''){
                    setState(() {
                      radioButtonItem = "Male";
                    });
                  }
                  var radio = radioButtonItem;
                  print(radioButtonItem);
                  if (usn.isEmpty||usn.length<=0) {
                    print("check");
                    showAlertDialog_oneBtn(this.context, alert, enter_valid_name);

                  }
                  else if (surusn.isEmpty||surusn.length<=0) {
                    print("check");
                    showAlertDialog_oneBtn(this.context, alert, enter_valid_surname);

                  }
                  /*else if (date.isEmpty){
                      showAlertDialog_oneBtn(this.context, alert1,choose_date);
                    }*/
                  else if(email.length==0){
                    showAlertDialog_oneBtn(this.context, alert1,enter_empty_email);
                  }
                  else if(!validateEmail(emailId_cntrl.text)){
                    showAlertDialog_oneBtn(this.context,alert, enter_valid_email);
                  }
                  else if ( pwd.isEmpty) {
                    showAlertDialog_oneBtn(this.context,alert,enter_empty_pwd);
                  }
                  else if ( !ChecktickBoxtermscondition) {
                    print("check");
                    showAlertDialog_oneBtn(
                        this.context, alert, accept_terms_conditions);
                  }
                  else if(ChecktickBox == true && ChecktickBoxsms==true){
                    print("check");
                    updatevia = "1,2";
                    showLoadingView(this.context);
                    initTimer();


                  }else if(ChecktickBoxsms== true){
                    print("check1");
                    updatevia = "2";
                    showLoadingView(this.context);
                    initTimer();

                  }else if(ChecktickBox == true){
                    print("check2");
                    updatevia = "1";
                    showLoadingView(this.context);
                    initTimer();

                  }
                  else{
                    showLoadingView(this.context);
                    initTimer();
                  }

                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                        child: Text(
                          submit,
                          style: TextStyle(color: Maincolor, fontSize: 15),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child:Image.asset("assets/ic_name.png",height: 25, width: 25,),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 8.0, bottom: 2),
                          child: TextField(
                            controller: name_cntrl,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\.]")),
                            ],
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Given Name*",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(width: 25),
                      InkWell(
                        onTap: (){
                          showAlertDialog_oneBtn(context, alert, "We’d love to customise how we address you on your card");
                        },
                          child: Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_form_info.png",width: 25.0,)
                            ,)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 0.75,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child:Image.asset("assets/ic_name.png",height: 25, width: 25,),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 8.0, bottom: 2),
                          child: TextField(
                            controller: surname_cntrl,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\.]")),
                            ],
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Surname*",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(width: 25),
                      InkWell(
                          onTap: (){
                            showAlertDialog_oneBtn(context, alert, "This is also known as the last name. We’d love to know how to address you formally");
                          },
                          child: Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_form_info.png",width: 25.0,)
                            ,)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 0.75,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 135,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: 1,
                              groupValue: id,
                              activeColor: Maincolor,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = "Male";
                                  id = 1;
                                });
                              },
                            ),
                            Text(
                              'Male',
                              style: new TextStyle(fontSize: 14.0,color: lightGrey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Radio(
                              value: 2,
                              groupValue: id,
                              activeColor: Maincolor,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = "Female";
                                  id = 2;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Text(
                          'Female',
                          style: new TextStyle(fontSize: 14.0,color: lightGrey),
                        ),
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      InkWell(
                          onTap: (){
                            showAlertDialog_oneBtn(context, alert, "This will help us determine the perfect promotions for you");
                          },
                          child: Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_form_info.png",width: 25.0,)
                            ,)
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 0.75,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 2),
                            child: Image.asset("assets/ic_form_birthday.png",height: 25, width: 25,)
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 8.0),
                          child: TextField(
                            controller: dateinput,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Date of Birth (DD/MM/YY)",
                              border: InputBorder.none,
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().subtract(Duration(days:1)),
                                firstDate: DateTime(
                                    1860 ), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Maincolor, // <-- SEE HERE
                                        onPrimary: Colors.white, // <-- SEE HERE
                                        onSurface: Colors.black, // <-- SEE HERE
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: Maincolor, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dateinput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(width: 25),
                      InkWell(
                          onTap: (){
                            showAlertDialog_oneBtn(context, alert, "Sharing your birthday will allow us to celebrate your day by rewarding you with special treats");
                          },
                          child: Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_form_info.png",width: 25.0,)
                            ,)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 0.75,
                ),

                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Container(
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Image.asset("assets/ic_form_email.png",height: 25, width: 25,)
                          )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 8),
                          child: TextField(
                            controller: emailId_cntrl,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Email Address*",
                              border: InputBorder.none,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_!#$%&*+-/=?^\`{|}~]')),
                            ],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(width: 25),
                      InkWell(
                          onTap: (){
                            showAlertDialog_oneBtn(context, alert, "This contact will be used for communication on your account matter");
                          },
                          child: Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_form_info.png",width: 25.0,)
                            ,)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 0.75,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Image.asset("assets/ic_form_mobile.png",height: 25, width: 25,)
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 6.0),
                          child: TextField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            controller: mobile_cntrl,
                            enabled: false,
                            // maxLength: 12,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // counterText: ' ',
                              hintText: enter_mobile_number,
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(width: 25),
                      InkWell(
                          onTap: (){
                            showAlertDialog_oneBtn(context, alert, "Storing your number will make it easier and faster for you to share a promotion with a friend!");
                          },
                          child: Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_form_info.png",width: 25.0,)
                            ,)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 0.75,
                ),

                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Container(
                          width: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Icon(
                              Icons.lock_outline_sharp,
                              size: 32,
                              color: Colors.grey,
                            ),
                          )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 8),
                          child: TextField(
                            controller: pwdId_cntrl,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Password*",
                              border: InputBorder.none,
                              /*suffixIcon:  GestureDetector(
                                onTap: _toggleObscured,
                                child: Icon(
                                  _obscured
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  size: 24,
                                  color: Maincolor,
                                ),
                              ),*/
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(width: 25),
                      InkWell(
                          onTap: (){
                            showAlertDialog_oneBtn(context, alert, "This is protect your account access to this app");
                          },
                          child: Padding(padding: EdgeInsets.only(right: 10.0),child: Image.asset("assets/ic_form_info.png",width: 25.0,)
                            ,)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  height: 0.75,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0,left: 15),
                            child: Text(agreetext,style: TextStyle(fontSize: 15,color: Colors.black),),
                          )),
                      SizedBox(width: 25),

                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(

                  height: 20,
                  width: double.infinity,


                  margin: EdgeInsets.only(left: 12,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(value: ChecktickBox, onChanged: (newvalue ){
                        setState(() {
                          _tickfunc();

                        });
                      },
                        checkColor: Colors.white,
                        activeColor: Maincolor,
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => Maincolor),

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(byemail,style: TextStyle(fontSize: 14,color: Colors.black),),

                    ],



                  ),
                ),
                SizedBox(height: 8,),
                /*Container(

                  height: 20,
                  width: double.infinity,


                  margin: EdgeInsets.only(left: 12,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(value: ChecktickBoxsms, onChanged: (newvalue ){
                        setState(() {
                          _tickfunc1();

                        });
                      },
                        checkColor: Colors.white,
                        activeColor: Maincolor,
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => Maincolor),

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(bysms,style: TextStyle(fontSize: 14,color: lightGrey),),

                    ],



                  ),
                ),*/
                SizedBox(height: 8,),
                Container(

                  height: 20,
                  width: double.infinity,


                  margin: EdgeInsets.only(left: 12,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(value: ChecktickBoxtermscondition, onChanged: (newvalue ){
                        setState(() {
                          _tickfunc2();

                        });
                      },
                        checkColor: Colors.white,
                        activeColor: Maincolor,
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => Maincolor),

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RichText(
                          softWrap: true,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: TextSpan(
                            text: i_accept,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            children: [

                              TextSpan(
                                  text: terms_of_service,
                                  style: TextStyle(fontSize: 12,
                                    color:Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer(

                                  )..onTap = () async {
                                    final url = TERMS_AND_CONDITION_URL;
                                    if (await canLaunch(url)) launch(url);
                                  }

                              ),
                            ],
                          )),

                    ],



                  ),
                ),
                SizedBox(height: 15,),
                /*InkWell(
                  onTap: () {
                    email = emailId_cntrl.text.toString().trim();
                    pwd = pwdId_cntrl.text.toString();
                    usn = name_cntrl.text.toString().trim();
                    surusn = surname_cntrl.text.toString().trim();
                    date = dateinput.text.toString();
                    mob = mobile_cntrl.text.toString();
                    if(radioButtonItem==''){
                      setState(() {
                        radioButtonItem = "Male";
                      });
                    }
                    var radio = radioButtonItem;
                    print(radioButtonItem);
                    if (usn.isEmpty||usn.length<=0) {
                      print("check");
                      showAlertDialog_oneBtn(this.context, alert, enter_valid_name);

                    }
                    else if (surusn.isEmpty||surusn.length<=0) {
                      print("check");
                      showAlertDialog_oneBtn(this.context, alert, enter_valid_surname);

                    }
                    *//*else if (date.isEmpty){
                      showAlertDialog_oneBtn(this.context, alert1,choose_date);
                    }*//*
                    else if(email.length==0){
                      showAlertDialog_oneBtn(this.context, alert1,enter_empty_email);
                    }
                    else if(!validateEmail(emailId_cntrl.text)){
                      showAlertDialog_oneBtn(this.context,alert, enter_valid_email);
                    }
                    else if ( pwd.isEmpty) {
                      showAlertDialog_oneBtn(this.context,alert,enter_empty_pwd);
                    }
                    else if ( !ChecktickBoxtermscondition) {
                      print("check");
                      showAlertDialog_oneBtn(
                          this.context, alert, accept_terms_conditions);
                    }
                    else if(ChecktickBox == true && ChecktickBoxsms==true){
                      print("check");
                      updatevia = "1,2";
                      showLoadingView(this.context);
                      initTimer();


                    }else if(ChecktickBoxsms== true){
                      print("check1");
                      updatevia = "2";
                      showLoadingView(this.context);
                      initTimer();

                    }else if(ChecktickBox == true){
                      print("check2");
                      updatevia = "1";
                      showLoadingView(this.context);
                      initTimer();

                    }
                    else{
                      showLoadingView(this.context);
                      initTimer();
                    }

                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Maincolor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                          child: Text(
                            submit,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
      onWillPop: ()async{
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },

    );
  }
  bool validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return false;
    } else {
      return true;
    }
  }
  String validatePassword(String value) {

    if (value.length<6) {
      return "0";
    } else {
      return "1";
    }
  }
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  void _tickfunc() {
    if (ChecktickBox) {
      ChecktickBox = false;
    }
    else {
      ChecktickBox = true;
    }
  }
  void _tickfunc1() {
    if (ChecktickBoxsms) {
      ChecktickBoxsms = false;
    }
    else {
      ChecktickBoxsms = true;
    }
  }
  void _tickfunc2() {
    if (ChecktickBoxtermscondition) {
      ChecktickBoxtermscondition = false;
    }
    else {
      ChecktickBoxtermscondition = true;
    }
  }
  void initTimer() async{
    if(await checkinternet()){
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");
        callSignupapi( );
      });
    }else{
      showAlertDialog_oneBtnsign(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
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
  void showAlertDialog_oneBtnsign(BuildContext context,String tittle,String message)
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
  Future<void> callSignupapi( ) async {
    var data=null;
    print("check2bhart"+updatevia.toString()+surusn.toString());


    final http.Response response = await http.post(
      Uri.parse(SIGNUP_URL),
      body: {
        "device_token":CommonUtils.deviceToken,
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":CommonUtils.deviceType,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        "full_name":usn,
        "sur_name":surusn,
        "phone_no": mob,
        "email":email,
        "password":pwd,
        "gender":radioButtonItem,
        "date_of_birth":date,
        "promotion_update_via":updatevia

      },
    ).timeout(Duration(seconds: 30));
    print("check3");
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var dataa = jsonDecode(jsonstring);
    var data2 = dataa['info'];
    print("checkresponse"+ data2.toString());
    var status = Utils().stringSplit(data2['p1']);
    var Message = Utils().stringSplit(data2['p5']);
// print(lstname);

    if(status=="1") {
      print("check2");
      CommonUtils.consumerID = Utils().stringSplit(data2['p2']).toString();
      CommonUtils.consumerName = Utils().stringSplit(data2['p3']).toString();
      CommonUtils.consumerGender = Utils().stringSplit(data2['p8']).toString();
      CommonUtils.consumerProfileImageUrl=Utils().stringSplit(data2['p9']).toString();
      CommonUtils.consumermobileNumber =Utils().stringSplit1(data2['p10']).toString();
      CommonUtils.consumerIntialScreen=Utils().stringSplit(data2['p6']).toString();
      CommonUtils.consumerEmail = email;
      CommonUtils.KEY_FORCE_LOG_OUT =Utils().stringSplit(data2['p7']).toString();
      CommonUtils.deviceTokenID = Utils().stringSplit(data2['p4']).toString();

      print("DevToken:" + CommonUtils.deviceTokenID.toString());
      print("DevToken:" + CommonUtils.consumermobileNumber.toString());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('NewSignup', "1");
      prefs.setString('consumerId', CommonUtils.consumerID.toString());
      prefs.setString('consumerName', CommonUtils.consumerName.toString());
      prefs.setString('consumerEmail', CommonUtils.consumerEmail.toString());
      prefs.setString(
          'consumerMobile', CommonUtils.consumermobileNumber.toString());
      prefs.setString(
          'consumerDeviceTokenId', CommonUtils.deviceTokenID.toString());
      print("consumerid"+ CommonUtils.consumerID.toString());

      prefs.setString('alreadyLoggedIn', "1");
      Navigator.push(this.context, MaterialPageRoute(builder: (context) => ConsumerTab()));
    }
    else{
      showAlertDialog_oneBtnsign(this.context, 'Alert', Message);
    }



  }
}
