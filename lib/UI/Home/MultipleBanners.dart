import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lifestyle/Others/CommonBrowser.dart';
import 'package:lifestyle/UI/Home/Model/WhatsOnMultipleInitModel.dart';
import 'package:lifestyle/UI/Home/MultipleBannerDetailsPage.dart';
import 'package:lifestyle/UI/Home/RewardsDetailFragment.dart';
// import 'package:poketrewards/res/Strings.dart';
import 'package:xml2json/xml2json.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../../../Others/CommonUtils.dart';
import '../../../Others/Urls.dart';
import '../../../Others/Utils.dart';
import '../../../res/Colors.dart';
import '../../Others/AlertDialogUtil.dart';
import '../../res/Strings.dart';

class MultipleBanners extends StatefulWidget {
  var id,tittle;
   MultipleBanners(this.id, this.tittle,{Key? key}) : super(key: key);

  @override
  State<MultipleBanners> createState() => _MultipleBannersState(id,tittle);
}

class _MultipleBannersState extends State<MultipleBanners> {
  var tittle="";
  var id="";
  var actionType1 ;
  var actionType;
  _MultipleBannersState(this.id, this.tittle);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Maincolor,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(tittle,style: TextStyle(color: Colors.white),),
        ),
        body: _homeMultipleBanner(context),
      ),

    );
  }


  Future<List<WhatsOnMultipleInitModel>> getHomeBannerData() async {


    final http.Response response = await http.post(
      Uri.parse(HOMEBANNERCMD_ITEM),

      body: {
        "main_category_id":widget.id,
       // "merchant_id": widget.merchantId,
        "consumer_id": CommonUtils.consumerID.toString(),
        "action_event": "1",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
        "device_type":CommonUtils.deviceType,
      },
    ).timeout(Duration(seconds: 30));


  debugPrint("check5${response.body}");
    if (response.statusCode == 200) {
      debugPrint("CatlogueBanner:" + response.body);
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
      List<String> categoryId = p2.split("*");
      List<String> categoryImage = p3.split("*");
      List<String> categoryName = p4.split("*");
      List<String> bannerType = p5.split("*");
      List<WhatsOnMultipleInitModel> object = [];

      for (int i = 0; i < categoryId.length; i++) {
        object.add(new WhatsOnMultipleInitModel(
            categoryId: categoryId[i], categoryImage:categoryImage[i], categoryName: categoryName[i],bannerType:bannerType[i]));
      }
      return object;
    }
    else {

      throw "Unable to retrieve posts.";
    }


  }
  FutureBuilder<List<WhatsOnMultipleInitModel>> _homeMultipleBanner(BuildContext context) {

    return FutureBuilder<List<WhatsOnMultipleInitModel>>(

      future: getHomeBannerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("check7"+widget.id);
          final List<WhatsOnMultipleInitModel>? posts = snapshot.data;
          return _buildPostsHome(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  ListView _buildPostsHome(BuildContext context, List<WhatsOnMultipleInitModel> posts) {

    return ListView.builder(

     //  physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        actionType1 = posts[index].bannerType.split(";");
        actionType = actionType1[0].split("##")[1];
        print(actionType.toString());
         return InkWell(

          onTap: (){

             print("action1"+actionType1.toString());

            if(actionType==CommonUtils.triggerUrl){
              var url = actionType1[1].split("##")[1];
              var tittle = posts[index].categoryName;
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CommonBrowser(url, tittle),));
            }
            else if(actionType==CommonUtils.triggerVoucher){
              var categoryid = posts[index].categoryId.split("*");
              print("check"+categoryid[0].toString());
              var url = actionType1[1].split("##")[1];
              print(url.toString());
              final dateList = url.split("~");
              print("split " + dateList[0]);
              var programid = dateList[0];
              var merchantid = dateList[1];
              var outletId = dateList[2];
              var vouchername = dateList[3];
              var programtype = dateList[4];
              var isDownload = dateList[5];

              Navigator.push(context, MaterialPageRoute(builder: (context) => RewardsDetailFragement(programid,merchantid,outletId,vouchername,programtype,
              isDownload,categoryid)));
            }
            else if(actionType==CommonUtils.triggerPhone){
              var phone=actionType1[1].split("##")[1];
              _launchCaller(phone);
            }
            else if(actionType==CommonUtils.triggerCMS){
              var data = actionType1[1].split("##")[1];
              print(data.toString());
              CommonUtils.MultipleBannerDetailPageId=data;
              CommonUtils.MultipleBannerDetailPageTittle=posts[index].categoryName;
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MultipleBannerDetailsPage(),));
            }
            else if(actionType==CommonUtils.triggerNormal){
              // var categId=posts[itemIndex].categoryId;
              // var tittle=posts[itemIndex].categoryName;
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MultiplBanners(categId,tittle),));
            }

            else if(actionType==CommonUtils.triggerEmail){
              //  var categId=posts[index].categoryId;
              var tittle=actionType1[1].split("##")[1];
              print("EmailLaunch");
              _launchEmail(tittle);
            }

          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
              border: Border.all(color: lightGrey,),
                  borderRadius: BorderRadius.circular(1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    posts[index].categoryImage,
                  ),
                  SizedBox(height: 10,),
                 Text(posts[index].categoryName,style: TextStyle(
                      fontSize: 15,
                  ),),
                  SizedBox(height: 10,),
                  /*if(actionType=="voucher")Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [

                        Container(width: 1,height: 30,color: lightGrey,),
                        SizedBox(width: 10,),
                        Center(
                          child: Text("free",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Maincolor
                          ),),
                        ),
                        SizedBox(width: 40,),
                        GestureDetector(
                          onTap: (){
                            if( posts[index].poketed=="no"){
                              showAlertforPoketIt(posts[index]);
                            }

                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.only(right: 10,left: 10),

                              child: Container(


                                decoration: BoxDecoration(
                                    color:Maincolor,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                padding: EdgeInsets.all(10),

                                child: Center(
                                  child: setPoketitbtn(posts[index].poketed),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget setPoketitbtn(var data){
    if(data=="yes"){
      return Text("poketed",style: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),);
    }
    else{
      return Text("poket_it",style: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),);
    }
  }

  _launchEmail(var emailId) async {
    final Email email = Email(
      subject:emailContent,
      recipients: [emailId],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
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
  String stringSplit(String data) {
    return data.split("~")[3];
  }

  void showAlertforPoketIt(WhatsOnMultipleInitModel posts){
    String message="";
    if (posts.bannerType=="vouchercard") {
      message=accept_message_voucher;
    }
    else {
      message=accept_message_voucher;
    }
    AlertDialog alert = AlertDialog(

      backgroundColor: Colors.white,
      title: Text(message,style: TextStyle(color:Colors.grey,fontSize: 14)),
      // content: CircularProgressIndicator(),

      content: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: (){Navigator.pop(context,true);},
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 100,
                  color: Colors.white,
                  child:Center(child: Text(cancel_caps,style: TextStyle(color: Maincolor),)),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){Navigator.pop(context,true);
              // getVoucher(posts);
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 100,
                  color: Colors.white,
                  child:Center(child: Text(accept,style: TextStyle(color: Maincolor),)),
                ),
              ),
            ),
          ],
        ),
      ),

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

  /*Future<void> getVoucher(WhatsOnMultipleInitModel posts) async{
    showLoadingView(context);

    final http.Response response = await http.post(
      Uri.parse(PROMOTION_VOUCHER_DOWNLOAD_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": posts.programid.toString(),
        "program_type": posts.programtype.toString(),

        "serial_no":"",
        "merchant_id":CommonUtils.MerchantId.toString(),
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


    String res=response.body;
    print(res);
    var status=json.decode(response.body)['Status'];


    Navigator.pop(context);
    if(status=="True"){
      var otpStatus=json.decode(response.body)['p1_val'].toString();
      var downloadStatus=json.decode(response.body)['p2_val'].toString();
      var message=json.decode(response.body)['p3_val'];


      if (otpStatus=="1") {

        if (downloadStatus=="1") {

          showAlertDialogoneBtn_lc(context,message);
        } else {
          var OtpVerificationCode=json.decode(response.body)['p4_val'];
          var transactionId=json.decode(response.body)['p5_val'];
          var consumerMblNo=json.decode(response.body)['p8_val'];

          // getOtp();
        }

      } else {

        sendToDownloadProgram(posts);

      }
    }
    else{
      showAlertDialog_oneBtnWitDismiss(context,alert1,failed_try_again);
    }

  }

  Future<void> sendToDownloadProgram(WhatsOnMultipleInitModel posts) async{
    showLoadingView(context);

    final http.Response response = await http.post(
      Uri.parse(VOUCHER_DOWNLOAD_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "program_id": posts.programid.toString(),
        "program_type": posts.programtype.toString(),
        "outlet_id":"",
        "serial_no":"",
        "merchant_id":CommonUtils.MerchantId.toString(),
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


    String res=response.body;
    print(res);
    var status=json.decode(response.body)['Status'];
    var message=json.decode(response.body)['message'];


    Navigator.pop(context);
    if(status=="True"){


      showAlertDialog_oneBtn(context, thank_you,message);

    } else {

      showAlertDialogoneBtn_lc(context, message);

    }


  }*/

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

}
