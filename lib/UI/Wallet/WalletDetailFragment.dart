import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/Utils.dart';
import 'package:lifestyle/UI/ConsumerTab.dart';
import 'package:lifestyle/UI/Wallet/Wallet_Model.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:lifestyle/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Others/Urls.dart';
import 'ParticipatingOutletmodel.dart';
import 'WalletViewmodel.dart';
import 'package:xml2json/xml2json.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletDetailFragment extends StatefulWidget {
  final WalletViewmodel Object1;
   WalletDetailFragment({Key? key,required this.Object1}) : super(key: key);

  @override
  State<WalletDetailFragment> createState() => _WalletDetailFragmentState(this.Object1);
}

class _WalletDetailFragmentState extends State<WalletDetailFragment> {
 WalletViewmodel Object1;
  var fulrnuno;
  bool ShowDescription = true;
  bool Showdescription = true;
  bool ShowTermsTxt = true;
  _WalletDetailFragmentState(this.Object1);
  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    print(Object1.programtype);
    return SafeArea(
      bottom: false,
      top: false,
      child:
    Scaffold(

      //appBar: AppBar(title: Text(Object1.merchantName),backgroundColor: Maincolor,centerTitle: true,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(child: Image.network(Object1.programBackgroundImgURL,fit: BoxFit.fill,height: MediaQuery.of(context).size.height * 0.2,)),
            SizedBox(height: 5,),
            if(Object1.programtype.toString()!="rm")Center(child: Wrap(

              children: [

                Text(expiry+ Object1.programExpiryDate,style: TextStyle(fontSize: 12),),
                SizedBox(width: 100,),

               setFullRunNO(no+ Object1.programID.toString()+"- "+Object1.serialnumber.toString()),
              ],
            )),
            if(Object1.programtype.toString()=="rm")Center(child: Text(expiry+ Object1.programExpiryDate,style: TextStyle(fontSize: 12),)),
            SizedBox(
              height: 10,
            ),
            Center(child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Maincolor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white),
              ),
              child: InkWell(
                onTap: (){
                  clickredeem();
                },
                child: Center(
                    child: Text(
                      "Use Manual Redemption",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
              ),
            /*SizedBox(
              height: 0.5,
              width: double.infinity,
              child: Container(
                color: poketPurple,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20,top: 10,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(WalletDetailConstantstring),
                  SizedBox(
                    height: 15,
                  ),
                  Text(Object1.programTitle,style: TextStyle(
                      color: poketPurple,fontSize: 15,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),*/
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 0.5,
              width: double.infinity,
              child: Container(
                color: poketPurple,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Benefits",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: poketPurple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {

                        setState(() {
                          ShowDescription = !ShowDescription;
                        });
                      },
                      child: ShowDescription == false
                          ? Image.asset(
                        "assets/icon_more.png",
                        width: 20,
                        height: 20,
                      )
                          : Image.asset(
                        "assets/ic_less.png",
                        width: 20,
                        height: 20,
                      )),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Visibility(
                visible: ShowDescription,
                child: Text(
                  Object1.benefits.toString().replaceAll("\\\\n", "\n"),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 0.5,
              width: double.infinity,
              child: Container(
                color: poketPurple,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Terms",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: poketPurple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {
                        print("hellooo");
                        setState(() {
                          ShowTermsTxt = !ShowTermsTxt;
                        });
                      },
                      child: ShowTermsTxt == false
                          ? Image.asset(
                        "assets/icon_more.png",
                        width: 20,
                        height: 20,
                      )
                          : Image.asset(
                        "assets/ic_less.png",
                        width: 20,
                        height: 20,
                      )),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Visibility(
                visible: ShowTermsTxt,
                child: Text(
                  Object1.tnc.toString().replaceAll("\\\\n", "\n"),
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 0.5,
              width: double.infinity,
              child: Container(
                color: poketPurple,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Participating Outlets",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: poketPurple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {
                        print("hellooo");
                        setState(() {
                          Showdescription = !Showdescription;
                        });
                      },
                      child: Showdescription == false
                          ? Image.asset(
                        "assets/icon_more.png",
                        width: 20,
                        height: 20,
                      )
                          : Image.asset(
                        "assets/ic_less.png",
                        width: 20,
                        height: 20,
                      )),
                )
              ],
            ),
            if(Object1.outletList.length.toString()!="0")
              Visibility(visible: Showdescription,
                  // child: _buildparticipatingoutlet(context, Object1)
                  child: _buildparticipatingoutletFutureBuilde(context,Object1),

              ),


          ],

        ),
      )
    ),
    );
  }

 Future<List<ParticipatingOutletmodel>> getParticipatingOutlet(WalletViewmodel object) async {

  print("OutletDetailsCmdUrl:"+PARTICIPATINGOUTLETCMD);
  print("prgmId:"+object.programID.toString());

   final http.Response response = await http.post(
     Uri.parse(PARTICIPATINGOUTLETCMD),

     body: {
       "device_type":CommonUtils.deviceType,
       "software_version":CommonUtils.softwareVersion,
       "os_version":CommonUtils.osVersion,
       "device_model":CommonUtils.deviceModel,
       "device_imei":"",
       "time_zone":Utils().getTimeZone(),
       'consumer_application_type':CommonUtils.consumerApplicationType,
       'consumer_language_id':CommonUtils.consumerLanguageId,
       'country_index':"191",
       'program_id':object.programID,
       "consumer_id": CommonUtils.consumerID.toString(),

     },
   ).timeout(Duration(seconds: 30));


   print(response.body.toString());
  final Xml2Json xml2json = new Xml2Json();
  xml2json.parse(response.body);
  var jsonstring = xml2json.toParker();
  var data = jsonDecode(jsonstring);
  var newData = data['info'];
  var p1 = Utils().stringSplit(newData['p1']);
   if (response.statusCode == 200 && p1!="False") {
     debugPrint("TestGokul:" + response.body);
     final Xml2Json xml2json = new Xml2Json();
     xml2json.parse(response.body);
     var jsonstring = xml2json.toParker();
     var data = jsonDecode(jsonstring);
     var newData = data['info'];
     var p1 = Utils().stringSplit(newData['p1']);

     var p2 = Utils().stringSplit(newData['p2']);

     var p3 = Utils().stringSplit(newData['p3']);
     var p4 = Utils().stringSplit(newData['p4']);
     var p5 = Utils().stringSplit(newData['p5']);
     var p6 = Utils().stringSplit(newData['p6']);
     List<String> merchantName = p2.split("*");
     List<String> phone = p3.split("*");
     List<String> address = p4.split("*");
     List<String> postalCode = p5.split("*");
     List<String> operatingHours = p6.split("*");

     List<ParticipatingOutletmodel> object = [];

     for (int i = 0; i < merchantName.length; i++) {
       object.add(new ParticipatingOutletmodel(
           merchantName[i],
           phone[i],
           address[i],
           postalCode[i],
         operatingHours[i],

       ));
     }
     return object;
   }
   else {

     throw "Unable to retrieve posts.";
   }

 }

 FutureBuilder<List<ParticipatingOutletmodel>> _buildparticipatingoutletFutureBuilde(BuildContext context , WalletViewmodel object) {

   return FutureBuilder<List<ParticipatingOutletmodel>>(

     future: getParticipatingOutlet(object),
     builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.done) {
         final List<ParticipatingOutletmodel>? posts = snapshot.data;
         if(posts!=null && posts.isNotEmpty){
           return _buildparticipatingoutlet(context, posts);}
         else{
           return Container(

           );
         }
       } else {
         return Center(
           child:SpinKitCircle(
             color: Maincolor,
             size: 30.0,
           ),
         );
       }
     },
   );
 }


  Widget setFullRunNO(String data){
    fulrnuno=data;
    return Text(data,
      style:  TextStyle(fontSize: 12),
    );
  }

  Future<void> clickredeem() {
    TextEditingController mTxtRedeemCodeController=TextEditingController();
    TextEditingController mTxtRemarksController=TextEditingController();
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(5.0)),
            child: Container(

              height: 200,
              child: Padding(

                padding: const EdgeInsets.only(left:15.0,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    // ML0a029bO02feJ0f43R64Z00U00V9125T1XbfV1Y01Ibb56
                    SizedBox(height: 10,),
                    TextField(
                      controller: mTxtRedeemCodeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[

                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly

                      ],
                      decoration: InputDecoration(

                        hintText: "Enter Redemption Code",
                        hintStyle: TextStyle(fontSize: 17,color: Colors.grey),

                        enabledBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey,),
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey,),
                        ),

                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        controller: mTxtRemarksController,

                        decoration: InputDecoration(
                          hintText: "Remarks",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        )
                    ),

                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 35,
                              width: 100,
                              color: Colors.white,
                              child: Center(
                                  child: Text(
                                    cancel_caps,
                                    style: TextStyle(color: Maincolor),
                                  )),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async{
                            if(mTxtRedeemCodeController.text.toString()!=""){
                              showLoadingView(context);
                              var connectivityresult = await(Connectivity().checkConnectivity());
                              if(connectivityresult == ConnectivityResult.mobile || connectivityresult == ConnectivityResult.wifi ) {
                                print("connecr");
                               Navigator.pop(context, true);
                                callRedeemAPIForVoucher(mTxtRedeemCodeController.text,mTxtRemarksController.text);
                              }
                              else{
                                showAlertDialog_oneBtnWitDismiss(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
                                print("notttt");

                              }
                            }
                            else{
                              showAlertDialog_oneBtn(context, alert, "Please fill in all the fields");
                            }
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 35,
                              width: 100,
                              color: Colors.white,
                              child: Center(
                                  child: Text(
                                    ok,
                                    style: TextStyle(color: Maincolor),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],

                ),
              ),
            ),
          );
        }
    );
  }
 Future<void> callRedeemAPIForVoucher(var redeemCode,var remarks) async {
   // showLoadingView(context);

   final http.Response response = await http.post(
     Uri.parse(REDEEMVOUCHER_URL),

     body: {
       "consumer_id": CommonUtils.consumerID.toString(),
       "program_id": Object1.programID.toString(),
       "redemption_code":redeemCode.toString(),
       "remarks":remarks.toString(),
       "serial_no":memberid.toString(),
       "merchant_id":Object1.merchantID.toString(),
       'merchant_country_index':"191",
       'country_index':"191",
       "serial_no":Object1.serialnumber.toString()

     },
   ).timeout(Duration(seconds: 30));



   print(response.statusCode.toString());


   // Navigator.pop(context);
   print("Mres:${response.body.toString()}");
   if (response.statusCode == 200) {
     final Xml2Json xml2json = new Xml2Json();
     xml2json.parse(response.body);
     var jsonstring = xml2json.toParker();
     var data = jsonDecode(jsonstring);
     var newData = data['info'];
     var status = Utils().stringSplit(newData['p1']);

     var message = Utils().stringSplit(newData['p2']);

     var p3 = Utils().stringSplit(newData['p3']);

     if ( status=="True") {
       showAlertDialog_oneBtnWitDismissrdeem(context, alert, message);
     }
     else { showAlertDialog_oneBtnWitDismiss(context, alert, "Invalid Redemption Code");}
   }

   else {showAlertDialog_oneBtn(context, alert1, something_went_wrong1);}
 }
 void showAlertDialog_oneBtnWitDismissrdeem(BuildContext context,String tittle,String message)
 {
   AlertDialog alert = AlertDialog(
     backgroundColor: Colors.white,
     title: Text(tittle),
     // content: CircularProgressIndicator(),
     content: Text(message,style: TextStyle(color: Colors.black45)),
     actions: [
       GestureDetector(
         onTap: (){
           Navigator.pop(context);
           print("refreshcheck");
           CommonUtils.NAVIGATE_PATH=CommonUtils.walletPage;
           Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (_) => ConsumerTab()));
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
}
_launchCaller(mobile) async {

  final Uri launchUri=Uri(
    scheme: 'tel',
    path: mobile,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $mobile';
  }
}
ListView _buildparticipatingoutlet(BuildContext context, List<ParticipatingOutletmodel> object1) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: object1.length,
      itemBuilder: (context, index) {
        print("tesGokul:"+object1[index].phone.toString());
        return Padding(
          padding: EdgeInsets.only(left: 10,),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if(object1[index].merchantName!="none")Text(object1[index].merchantName,
                          style: TextStyle(fontSize: 14),),
                        SizedBox(height: 10,),
                        if(object1[index].postalCode!="none")Text(object1[index].postalCode,
                          style: TextStyle(fontSize: 12, color: Colors.grey),),
                        SizedBox(height: 5,),
                        if(object1[index].address!="none")Text(object1[index].address,
                          style: TextStyle(fontSize: 12, color: Colors.grey),),
                        SizedBox(height: 10,),
                        if(object1[index].operatingHours.toString()!="none")SizedBox(
                          height: 0.5,
                          width: double.infinity,
                          child: Container(
                            color: poketPurple,
                          ),
                        ),
                        SizedBox(height: 10,),
                        if(object1[index].operatingHours.toString()!="none") Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Operating Hours",
                              style: TextStyle(fontSize: 11),),
                            if(object1[index].phone!="none")Container(
                                height: 18,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey),
                                ),


                                  child: InkWell(
                                    onTap: (){
                                      _launchCaller(object1[index].phone.toString());
                                    },
                                    child: Center(child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        object1[index].phone.split("-")[0],

                                        style: TextStyle(fontSize: 11),),
                                    )),
                                  ),
                                ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        if(object1[index].operatingHours.toString()!="none")
                        Text(object1[index].operatingHours.toString().replaceAll("\\\\n", "\n"),
                          style: TextStyle(fontSize: 12, color: Colors.grey),),


                      ],


                    ),
                  ],


                ),
              ),
            ),
          ),
        );
      });


}
