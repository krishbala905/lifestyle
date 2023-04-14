


import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';



import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/NativeAlertDialog.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:xml2json/xml2json.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../Others/Utils.dart';
import '../../res/Strings.dart';
class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  TextEditingController FristName = TextEditingController();
  TextEditingController SecondName = TextEditingController();
  TextEditingController DoBTxt = TextEditingController();
  TextEditingController AddressTxt = TextEditingController();
  TextEditingController PostalCode = TextEditingController();
  TextEditingController EmailAddress = TextEditingController();
  TextEditingController Mobilenum = TextEditingController();
  TextEditingController OccupationTxt = TextEditingController();
  TextEditingController CurrentSkinCareTxt = TextEditingController();

bool val = false;
bool IsloaderSet  = false;
  bool showSenstivity = false;
  bool ShowSkinConcen = false;
  bool ShowSkinRoutine  = false;
  bool ByemailCheckbox = false;
  bool BySmsCheckbox = false;
  int SkintypeSelectedindex  = 0;
  int SkinConcernSelectedIndex = 0;
  var Skinconcerncount = 0;
  var skinCareroutinecount = 0;
  var GednerId = 0;
  String SelectGender =  '';

  List Checking = ["Sensitivity","Lack of Hydration"];
  List StringConcernfilterArry = [];
  List StringConcernfilterArrayIndex = [];
  String SkinConcernindexString = "";

  List StingSkinCareroutineFilterArray = [];
  List StringSkinCareroutineFilterArrayIndex = [];
  String SkinCareroutineindexString = "";
  List UpdateviaList = [];
 String updateVia = "";

  List<dynamic> SkintypeArray = ["Normal Skin","Sensitive Skin","Dehydrated Skin","Oily/Combination Skin"];
  List<dynamic> SkinConcernArray = ["Sensitivity","Lack of Hydration","Lack of Radiance","Oiliness","Acne","Pigmentation","Dark spots"];
  List<dynamic> SkincareRoutineArray = ["Makeup Remover","Facial Wash","Toner/Essence Lotion","Serums","Eye Cream","Moisturiser (Day/Night)","Sunscreen","Exfoliator/Masks"];

  String SkinType = "Skin Type";
  String SkinConcernTxt = "Skin Concerns";
  String SkinCareRoutinetxt = "your current morning/evening skincare routine ";
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _GetProfile();


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
      appBar: AppBar(title: Text("Membership Form"),backgroundColor: Maincolor,centerTitle: true,),
      body: LoadData(context),
    ));
  }

  Widget LoadData(BuildContext context)  {




    return Stack(
      children: [
         Column(
            children: [
              Expanded(
                  flex: 10,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    scrollDirection:  Axis.vertical,


                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Image.asset("assets/ic_name.png",width: 25,height: 25,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: TextField(
                                    cursorColor: Colors.grey,
                                    controller: FristName,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.grey, fontSize: 15

                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_]')),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Giver Name",
                                      hintStyle: TextStyle(color: lightGrey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                        GrayLine(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Image.asset("assets/ic_name.png",width: 25,height: 25,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: TextField(
                                    cursorColor: Colors.grey,
                                    controller: SecondName,
                                    keyboardType: TextInputType.name,
                                    style: TextStyle(color: Colors.grey, fontSize: 15

                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_]')),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Surname",
                                      hintStyle: TextStyle(color: lightGrey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GrayLine(),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Row(
                            children: [

                               Container(



                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [

                                    Radio(value: 1, groupValue: GednerId, onChanged: (value){


                                      setState(() {
                                        GednerId = 1;
                                        SelectGender = "Male";


                                      });

                                    },


                                      fillColor: MaterialStateColor.resolveWith(
                                              (states) => Maincolor),


                                    ),

                                    Text("Male",style: TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.grey

                                    ),),
                                    Radio(value: 2, groupValue:GednerId, onChanged: (values){


                                      setState(() {
                                        GednerId = 2;
                                        SelectGender = "Female";



                                      });


                                    },


                                      fillColor: MaterialStateColor.resolveWith(
                                              (states) => Maincolor),

                                    ),
                                    Text("female",style: TextStyle(
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),),

                                  ],
                                ),


                              ),
                            ],
                          ),
                        ),
                        GrayLine(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Image.asset("assets/ic_form_birthday.png",width: 25,height: 25,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: TextField(
                                    controller: DoBTxt,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Date of Birth (DD/MM/YY)",
                                      border: InputBorder.none,
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:DateTime.now().subtract(Duration(days:1)),
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
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          DoBTxt.text =
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

                              ),
                            ],
                          ),
                        ),
                        GrayLine(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Image.asset("assets/ic_form_email.png",width: 25,height: 25,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: TextField(
                                    enabled: false,
                                    cursorColor: Colors.grey,
                                    controller: EmailAddress,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.grey, fontSize: 15

                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_!#$%&*+-/=?^\`{|}~]')),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Email Address",
                                      hintStyle: TextStyle(color: lightGrey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                        GrayLine(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Image.asset("assets/ic_form_mobile.png",width: 25,height: 25,),
                             Container(
                               width: MediaQuery.of(context).size.width * 0.7,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: TextField(
                                    enabled: false,
                                    cursorColor: Colors.grey,
                                    controller: Mobilenum,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.grey, fontSize: 15

                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.@_]')),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Mobile Number",
                                      hintStyle: TextStyle(color: lightGrey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                        GrayLine(),
                        Padding(padding: EdgeInsets.only(left: 20,right: 20),

                          child: Text("I agree to receive latest news and promotional updates from Cathay LifeStyle"),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Checkbox(value: ByemailCheckbox,
                                        checkColor: Colors.white,
                                        activeColor: Maincolor,
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Maincolor),
                                        onChanged: (valur) {

                                      setState(() {
                                        ByemailCheckbox = !ByemailCheckbox;




                                      });


                                    }),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("By Email")


                                ],
                              ),
                              SizedBox(height: 10,),
                              /*Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: Maincolor,
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Maincolor),
                                        value: BySmsCheckbox, onChanged: (valur) {

                                      setState(() {
                                        BySmsCheckbox = !BySmsCheckbox;

                                        // if ( BySmsCheckbox == true) {
                                        //   setState(() {
                                        //     BySmsCheckbox = false;
                                        //     UpdateviaList.remove("2");
                                        //     updateVia = UpdateviaList.reduce((value, element) => value + ',' + element);
                                        //   });
                                        //
                                        //
                                        // } else {
                                        //   setState(() {
                                        //     BySmsCheckbox = true;
                                        //     UpdateviaList.add("2");
                                        //     updateVia = UpdateviaList.reduce((value, element) => value + ',' + element);
                                        //   });
                                        //
                                        // }



                                      });



                                    }),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("By SMS")


                                ],
                              )*/
                            ],

                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )

                      ],
                    ),
                  )
              ),
              Expanded(
                flex: 1,
                child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 15),
                    child: InkWell(
                      onTap: () async{
                        setState(() {
                          // var type = SkintypeSelectedindex + 1;
                          if(ByemailCheckbox == true) {
                            updateVia = "1";
                          }
                          if (BySmsCheckbox == true) {
                            updateVia = "$updateVia ,2";
                          }

                        });
                        if(FristName.text.isEmpty){
                          showAlertDialog_oneBtn(this.context, alert, enter_valid_name);
                        }
                        else if (SecondName.text.isEmpty||SecondName.text.length<=0) {
                          print("check");
                          showAlertDialog_oneBtn(this.context, alert, enter_valid_surname);

                        }
                        else if (DoBTxt.text.isEmpty){
                          showAlertDialog_oneBtn(this.context, alert1,choose_date);
                        }else{
                          var fName = FristName.text.toString();
                          var sname = SecondName.text.toString();
                          var Gender = SelectGender;
                          var Dob = DoBTxt.text.toString();
                          var email = EmailAddress.text.toString();
                          var num = Mobilenum.text.toString();
                          var Promotioupdatevia = updateVia;
                          var connectivityresult = await(Connectivity().checkConnectivity());
                          if(connectivityresult == ConnectivityResult.mobile || connectivityresult == ConnectivityResult.wifi ) {
                            print("connecr");
                            _UpdateProfile(fName, sname, Gender, Dob, num, email, Promotioupdatevia);
                          }
                          else{
                            showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
                            print("notttt");

                          }
                        }


                      },
                      child: Container(

                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(child: Text("Submit",style: TextStyle(
                            color: Colors.white
                        ),)),
                        decoration: BoxDecoration(
                            color: Maincolor,
                            borderRadius:BorderRadius.circular(20)
                        ),
                      ),
                    ),
                  ),
                ),



              )








            ],

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

    );

  }
  _GetProfile( ) async {
    setState(() {
      IsloaderSet = true;
    });


    final http.Response response = await http.post(Uri.parse(PROFILE_URL),
      body: {
      "consumer_id" : CommonUtils.consumerID.toString(),
        "action_event" : "1"
      }
    ).timeout(Duration(seconds: 30));
    print(response.body);
    if (response.statusCode ==200) {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      print(newData);
      var frist_name = Utils().stringSplit(newData['p2']);  //frist name
      var second_name = Utils().stringSplit(newData['p7']); //second name
      var gender = Utils().stringSplit(newData['p3']);//gender
      var DOB = Utils().stringSplit(newData['p4']);//DOB
      var Email = Utils().stringSplit(newData['p5']); //Email
      var mobile_num= Utils().stringSplit(newData['p6']); // mobile num
      var UpdateVia = Utils().stringSplit(newData['p16']);

      setState(() {
        print(gender);
        if(gender == "male") {
          GednerId = 1;
          SelectGender = "Male";

        }else if (gender == "female") {
          GednerId = 2;
          SelectGender = "Female";

        }
        else {
          GednerId = 0;
        }
        var numm = mobile_num.split(",");

        FristName.text = frist_name;
       SecondName.text =  second_name;

       if(DOB=="none"){
         DoBTxt.text = "";
       }else{
        DoBTxt.text = DOB;}
       EmailAddress.text = Email;
       Mobilenum.text = numm[1];


        if(UpdateVia != "none") {
          List<String> Updates =UpdateVia.split(",");

          if ( UpdateVia.contains("1")){

            ByemailCheckbox = true;
          }
          if ( UpdateVia.contains("2")) {
            BySmsCheckbox = true;

          }


        }
        print(UpdateviaList);

    IsloaderSet = false;
      });

    }

  }
  _UpdateProfile(var Fname,Sname,Gender,Dob,Phone,Email,Updatevia) async {
    setState(() {
      IsloaderSet = true;
    });

    print(Gender);

    final http.Response  response = await http.post(Uri.parse(PROFILE_URL),
    body: {
      "consumer_id":CommonUtils.consumerID.toString(),
      "action_event":"2",
      "full_name" : Fname,
      "sur_name" :Sname,
      "phone_no": Phone,
      "email" : Email,
      "gender":Gender,
      "date_of_birth":Dob,
      "promotion_update_via":Updatevia,

    }

    ).timeout(Duration(seconds: 30));


    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = jsonDecode(jsonstring);
    var newData = data['info'];
    var Mesage = Utils().stringSplit(newData['p2']);

    setState(() {
      IsloaderSet = false;
    });
    if(Platform.isAndroid ){
      showAlertDialog_oneBtnWitDismiss(context, "Alert", Mesage);
    }
    if(Platform.isIOS) {
      ShowNativeDialogue(context, "Alert", Mesage).then((value) =>
          Navigator.pop(context));
    }

  }

}



class GrayLine extends StatelessWidget {
  const GrayLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: SizedBox(
        height: 0.5,
        width: double.infinity,
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}


