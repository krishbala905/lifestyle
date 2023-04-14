import 'package:flutter/material.dart';
import 'package:lifestyle/UI/Home/Model/CatlogueMainbannerModel.dart';
import 'package:lifestyle/UI/Home/MultipleBannerDetailsPage.dart';
import 'package:lifestyle/UI/Home/MultipleBanners.dart';
import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lifestyle/Others/CommonBrowser.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/Others/Utils.dart';
//import 'package:lifestyle/Home/MultipleBannerDetailsPage.dart';
//import 'package:lifestyle/generated/l10n.dart';
import 'package:lifestyle/res/Colors.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../res/Strings.dart';


class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeBanner(context);
    /*InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status ==InternetConnectionStatus.connected;

      Flushbar(
        message: connected? "Internet connection enabled":"There is  no Internet Connection. Your data will not be updated",
        duration:  Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.grey,
        margin: EdgeInsets.fromLTRB(0, kTextTabBarHeight+8,0, 0),
        // animationDuration:  Duration(microseconds: 0),
      ).show(context);
      if(connected == true){
        _homeBanner(context);
      }
    });*/

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(


            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title:  Text("Home"),
            backgroundColor: Maincolor
        ),
        body:ListView(
          scrollDirection: Axis.vertical,
          children: [

            _homeBanner(context),
          ],
        )
    ));
  }



  Future<List<Catlogmodel>> getHomeBannerData() async {


    final http.Response response = await http.post(
      Uri.parse(HOMEBANNERCMD),

      body: {
       // "merchant_id": CommonUtils.merchantID.toString(),
        "consumer_id": CommonUtils.consumerID.toString(),
        "action_event": "1",
        "cma_timestamps":Utils().getTimeStamp(),
        "time_zone":Utils().getTimeZone(),
        "software_version":CommonUtils.softwareVersion,
        "os_version":CommonUtils.osVersion,
        "phone_model":CommonUtils.deviceModel,
        "device_type":"2",
        'consumer_application_type':CommonUtils.consumerApplicationType,
        'consumer_language_id':CommonUtils.consumerLanguageId,
      },
    ).timeout(Duration(seconds: 30));


print(response.body.toString());
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
      var p6 = Utils().stringSplit(newData['p6']);
      List<String> Cat_ID = p2.split("*");
      List<String> Cat_Image = p3.split("*");
      List<String> Cat_Name = p5.split("*");
      List<String> bannerType = p6.split("*");
      List<Catlogmodel> object = [];

      for (int i = 0; i < Cat_ID.length; i++) {
        object.add(new Catlogmodel(
            Cat_ID: Cat_ID[i], Cat_Image: Cat_Image[i], Cat_Name: Cat_Name[i],bannerType:bannerType[i]));
      }
      return object;
    }
    else {

      throw "Unable to retrieve posts.";
    }

  }
  FutureBuilder<List<Catlogmodel>> _homeBanner(BuildContext context) {

    return FutureBuilder<List<Catlogmodel>>(

      future: getHomeBannerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Catlogmodel>? posts = snapshot.data;
          if(posts!=null && posts.isNotEmpty){
            return _buildPostsHome(context, posts);}
          else{
            return Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Text("No Internet Connection"),
                  ),
                )
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

  ListView _buildPostsHome(BuildContext context, List<Catlogmodel> posts) {
    return ListView.builder(

      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,

      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom:2.0),
          child: InkWell(
            onTap: () {
              var actionType1 = posts[index].bannerType.split(";");
              var actionType = actionType1[0].split("##")[1];
              print(actionType.toString());

              if (actionType == CommonUtils.triggerUrl) {
                var url = actionType1[2].split("##")[1];
                var tittle = posts[index].Cat_Name;
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CommonBrowser(url, tittle),));
              }
              else if (actionType == CommonUtils.triggerPhone) {
                var phone = actionType1[2].split("##")[1];
                _launchCaller(phone);
              }
              else if (actionType == CommonUtils.triggerOneSubbaner) {
                var data = actionType1[2].split("##")[1];
                print(data.toString());
                if(data!="none") {
                  final dateList = data.split("~");
                  print("split " + dateList[0]);
                  CommonUtils.MultipleBannerDetailPageId =dateList[0].split(":")[1];
                  /*var re = RegExp(r'(?<=item_id:)(.*)(?=~consumer_id)');
                  var match = re.firstMatch(actionType1[2]);
                  print(match?.group(0).toString());
                  CommonUtils.MultipleBannerDetailPageId =
                  match != null ? match.group(0).toString() : "none";*/
                  CommonUtils.MultipleBannerDetailPageTittle =
                      posts[index].Cat_Name;

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MultipleBannerDetailsPage(),));
                }
                else{

                }
                }
              else if(actionType==CommonUtils.triggerCMS ){
                var url=actionType1[2].split("##")[1];
                var tittle=posts[index].Cat_Name;
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommonBrowser(url,tittle),));
              }
              else if(actionType==CommonUtils.triggerNormal){
                var categId=posts[index].Cat_ID;
                var tittle=posts[index].Cat_Name;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleBanners(categId,tittle),));
              }
              else if(actionType==CommonUtils.triggerEmail){
                //  var categId=posts[index].categoryId;
                var tittle=actionType1[2].split("##")[1];
                _launchEmail(tittle);
              }
            },

            // child: Image.network(posts[index].categoryImage,),
            child:  Image.network(posts[index].Cat_Image),
          ),
        );
      },
    );
  }
  _launchEmail(var emailId) async {
    final Email email = Email(
      subject: emailContent,
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


}
