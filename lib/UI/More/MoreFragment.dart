import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lifestyle/UI/More/AccountDeletion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:lifestyle/Others/AlertDialogUtil.dart';
import 'package:lifestyle/Others/CommonBrowser.dart';
import 'package:lifestyle/Others/CommonUtils.dart';
import 'package:lifestyle/Others/Urls.dart';
import 'package:lifestyle/SplashScreen.dart';
import 'package:lifestyle/UI/More/Expiryreminder.dart';
import 'package:lifestyle/UI/More/FAQ.dart';
import 'package:lifestyle/UI/More/History.dart';
import 'package:lifestyle/UI/More/History1.dart';
import 'package:lifestyle/UI/More/InboxFragment.dart';
import 'package:lifestyle/UI/More/Profile.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart'as http;
import '../../Others/Utils.dart';
import '../../res/Strings.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MoreFragment extends StatefulWidget {
  const MoreFragment({Key? key}) : super(key: key);

  @override
  State<MoreFragment> createState() => _MoreFragmentState();
}

class _MoreFragmentState extends State<MoreFragment> {
 // var BaseUrl = "https://cathaydev.poket.com/cathay/";
  var countt;
  void initState(){
    getInboxCount().then((String result) {
      setState(() {
        countt = result;
      });
    });
    print(countt.toString()+"check");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text("More"),
          backgroundColor: Maincolor
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: ()async{
                bool isconnected = await initTimer();
                if(isconnected == true){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InboxFragment(),));
                }
                else{
                  showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                }

              },
                child: MoreInboxWidet(Assetname: "assets/ic_form_email.png", Title:inbox,Count: countt.toString())),
        InkWell(
          onTap: ()async {
            bool isconnected = await initTimer();
            if(isconnected == true){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileFragment(),));
            }
            else{
              showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
            }

          },
           child: MorePageWidet(Assetname: "assets/icon_profile.png", Title: profile)),
        InkWell(
          onTap: () async {
            bool isconnected = await initTimer();
            if(isconnected == true){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => History(),));
            }
            else{
              showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
            }

          },
           child: MorePageWidet(Assetname: "assets/ic_historylog.png", Title: historylog)),
        InkWell(
          onTap: () async {
            bool isconnected = await initTimer();
            if(isconnected == true){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Expiryreminder(),));
            }
            else{
              showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
            }

          },
           child: MorePageWidet(Assetname: "assets/ic_expiry_reminder.png", Title: Expiry_reminder_txt)),
        InkWell(
          onTap: () async {
            bool isconnected = await initTimer();
            if(isconnected == true){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FAQ(),));
            }
            else{
              showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
            }

          },
            child: MorePageWidet(Assetname: "assets/icon_faq.png", Title: Faq_txt)),
        InkWell(
          onTap: (){
            _launchEmail();
          },
            child: MorePageWidet(Assetname: "assets/ic_feedback.png", Title: feedback),),
        InkWell(
          onTap: (){
            showContactUSPopup(context);
          },
           child: MorePageWidet(Assetname: "assets/ic_tellfriend.png", Title: tell_your_friends)),
            InkWell(
                onTap: () async {
                  bool isconnected = await initTimer();
                  if(isconnected == true){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CommonBrowser(ABOUTUS_URL,"About Us"),));
                  }
                  else{
                    showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
                  }

                },

            child: MorePageWidet(Assetname: "assets/logo.png", Title: about_us)),
        InkWell(
          onTap: () async {
            bool isconnected = await initTimer();
            if(isconnected == true){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CommonBrowser(PRIVACY_URL,"Privacy Policy"),));
            }
            else{
              showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
            }

          },
           child: MorePageWidet(Assetname: "assets/ic_privacy.png", Title: privacypolicy)),
        InkWell(
          onTap: () async {
            bool isconnected = await initTimer();
            if(isconnected == true){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CommonBrowser(TERMS_AND_CONDITION_URL,"Terms & Conditions"),));
            }
            else{
              showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
            }

          },
           child: MorePageWidet(Assetname: "assets/ic_termncondition.png", Title:termsandconditions)),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => AccountDeletion()));
          },
           child: Container(
             height: 50,
             decoration: BoxDecoration(
                 border:Border(
                     bottom: BorderSide(width: 0.2,color: GrayColor)
                 )
             ),
             child: Padding(
               padding: EdgeInsets.only(left: 20),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Image.asset("assets/remove-user.png",width: 20,height: 20,color: Colors.grey, ),
                   SizedBox(width: 15,),
                   Text(req_acc_dele,style: TextStyle(
                     fontSize: 16,color: lightGrey,
                   ),)

                 ],

               ),
             ),
           )),
           //MorePageWidet(Assetname: "assets/remove-user.png", Title: req_acc_dele)),

            InkWell(
              onTap: (){
                showAlertForSignout();
              },
                child: MorePageWidet(Assetname: "assets/ic_signout.png", Title: signout+" (" +CommonUtils.consumerEmail.toString() + ")")),
            SizedBox(height: 15.0,),
            checkDevorLive(),


          ],
        )
      ),
    );
  }
  _launchEmail() async{
    var email_body = CommonUtils.manufacturer.toString()+"\n"+"Model "+CommonUtils.deviceModel.toString()+"\n"+
        "OS "+ CommonUtils.osVersion.toString()+"\n"+"Version "+ CommonUtils.softwareVersion.toString();
    print("check"+ email_body.toString());
    final Email email = Email(
      subject: emailContent,
      recipients: [contactEmail],
      isHTML: false,
      body: email_body,
    );

    await FlutterEmailSender.send(email);
  }
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
  Widget checkDevorLive(){
    if(BASEURL.contains('cathaydev')){

      return Center(
        child: Text(dev_version_text+CommonUtils.softwareVersion.toString()),
      );
    }
    else{
      return Center(
        child: Text(version_text+CommonUtils.softwareVersion.toString()),
      );

    }

  }
  void showAlertForSignout() {
    AlertDialog alert1 = AlertDialog(
      backgroundColor: Colors.white,
      // content: CircularProgressIndicator(),
      content:
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(signout_confirmation,
            textAlign:  TextAlign.left,
            style: TextStyle(color: Colors.black45)),
      ),

      actions: [
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
                Navigator.pop(context, true);
                bool internetcheck = await initTimer();
                print("bharathi"+internetcheck.toString());
                if(internetcheck==true){
                  callSignoutAPi();
                }else{
                  showAlertDialog_oneBtn(this.context, "Network", "No Internet Connection. Please turn on Internet Connection");
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
                        signout_caps,
                        style: TextStyle(color: Maincolor),
                      )),
                ),
              ),
            ),
          ],
        )
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert1;
      },
    );
  }
  Future<void> callSignoutAPi() async {
    print("url:" + LOGOUT_URL);

    final http.Response response = await http.post(
      Uri.parse(LOGOUT_URL),

      body: {
        "consumer_id": CommonUtils.consumerID,
        "device_type":"2"

      },
    ).timeout(Duration(seconds: 30));
    print("check2"+response.body.toString()+CommonUtils.consumerID.toString());
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = json.decode(jsonstring);
    print(data);
    var data2 = data['info'];
    var status = stringSplit(data2['p1']);
    var messg = stringSplitsign(data2['p2']);
    var Mesage = Utils().stringSplit(data2['p2']);
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.clear();
    print("hii"+status);
    if (status == "1") {
      print("hii");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('consumerId');
      prefs.remove('consumerName');
      prefs.remove('consumerMobile');
      prefs.remove('consumerDeviceTokenId');
      prefs.remove('consumerprofileimage');
      // prefs.remove('consumerEmail');
      prefs.remove('alreadyLoggedIn');
      print("checkbhar"+ prefs.getString('consumerEmail').toString());
      // await prefs.clear();
      /*final fb = FacebookLogin();
      if(await fb.isLoggedIn){
        fb.logOut();
      }*/

      showAlertDialog_oneBtnsignout(context, alert, Mesage);

    } else {
      showAlertDialog_oneBtn(context, alert, Mesage);
    }

  }
  String stringSplitsign(String data) {
    return data.split(":)*%8%*")[0];
  }
  void showContactUSPopup(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,

      actions: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:10,right:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(contactUs_content,style: TextStyle(fontSize: 15),),
                SizedBox(height: 35,),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    shareEmailFunction();
                  },
                  child: Text(email,style: TextStyle(fontSize: 15),),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    // _textMe();
                    if(Platform.isAndroid){
                    _launchSMS();}
                    else{
                      _launchSms();
                    }
                  },
                  child: Text(sms,style: TextStyle(fontSize: 15),),
                ),
                /* SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                    shareToFeedFacebookLink(url: "https://www.dragon-i.com.my",quote: 'Hey there,I am using this Dragon-i Restaurants App. I know you will like it. You can search for Dragon-i Restaurants on App Store and Google Play');
                    // share.shareToFeedFacebookLink(url: "https://poket.com/app/");
                    *//*shareNewFb() async{
                      print("fb share");
                      try{
                        var dataa = await SocialSharePlugin.shareToFeedFacebookLink(url: "https://poket.com/app/",quote:  'Poketrewards');
                        print(dataa);
                      }
                      catch(e){
                        print(e);
                      }
                    }*//*

                    // _launchFacebook();
                  },
                  child: Text(facebook,style: TextStyle(fontSize: 15),),
                ),*/
                SizedBox(height: 25,),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:15.0,bottom: 8.0),
          child: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(cancel,style: TextStyle(fontSize: 15),),
            ),
          ),
        )
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
  shareEmailFunction() async{
    final Email email = Email(
      subject: email_subject,
      isHTML: false,
      body: email_body,
    );

    await FlutterEmailSender.send(email);
  }
  _textMe() async {
    // Android

    const uri = 'sms:&body=Hey%20there,%20I\'m%20using%20this%20Dragon-i%20Restaurants%20App%20.I%20know%20you%20will%20like%20it.%20You%20can%20search%20for%20\'Dragon-i%20Restaurants\'%20on%20App%20Store%20and%20Google%20Play.';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:&body=Hey%20there,%20I\'m%20using%20this%20Dragon-i%20Restaurants%20App%20.I%20know%20you%20will%20like%20it.%20You%20can%20search%20for%20\'Dragon-i%20Restaurants\'%20on%20App%20Store%20and%20Google%20Play.';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  _launchSMS() async{
    //const uri = 'sms:?body= Hey there,I am using this Dragon-i Restaurants App. I know you will like it. You can search for Dragon-i Restaurants on App Store and Google Play''
    var smsUri = Uri.parse('sms:?body= Hey there, I redeemed an e- voucher via the Cathay Lifestyle App. You’ll like it, download it now!');
    try {
      print(smsUri.toString());
      if (await canLaunchUrl(
        smsUri,
      )) {
        await launchUrl(smsUri);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text(some_err_occured),
        ),
      );
    }
  }
  _launchSms() async {
    try {
      if (Platform.isAndroid) {
        String uri = 'sms:body=${Uri.encodeComponent("Hey there, I redeemed an e- voucher via the Cathay Lifestyle App. You’ll like it, download it now!")}';
        await launchUrl(Uri.parse(uri));
      } else if (Platform.isIOS) {
        String uri = 'sms:&body=${Uri.encodeComponent("Hey there, I redeemed an e- voucher via the Cathay Lifestyle App. You’ll like it, download it now!")}';
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some error occurred. Please try again!'),
        ),
      );
    }
  }
  void showAlertDialog_oneBtnsignout(BuildContext context, String tittle,
      String message) {
    print("check");
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(tittle, textAlign: TextAlign.left,),
      ),
      // content: CircularProgressIndicator(),
      content: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(message,textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black45)),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(ok,style: TextStyle(color: Maincolor)),
          onPressed: () {
            Navigator.pop(context, true);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                    SplashScreen()), (Route<dynamic> route) => false);

          },
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
  void dispose() {
    // TODO: implement dispose
    FocusScope.of(context).requestFocus(FocusNode());
    super.dispose();
  }
  Future<bool> initTimer() async{
    bool check = true;
    if(await checkinternet()){
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");
        check = true;
        //callSignoutAPi();

      });
    }else{
      check = false;
    }
    print("bharathi1"+check.toString());
    return check;
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
  Future<String> getInboxCount() async {

    final http.Response response = await http.post(
      Uri.parse(ShowUnreadCount_URL),

      body: {
        "consumer_id": CommonUtils.consumerID.toString(),
        "country_index": "+65",
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
print(response.body.toString());
    final Xml2Json xml2json = new Xml2Json();
    xml2json.parse(response.body);
    var jsonstring = xml2json.toParker();
    var data = json.decode(jsonstring);
    print(data);
    var data2 = data['info'];
      var count = stringSplit(data2['p1']);
    print(count.toString());
    return count;


    //
  }
  /*FutureBuilder<String> _InboxCount(BuildContext context) {

    return FutureBuilder<String>(

      future: getInboxCount(),
      builder: (context, snapshot) {


        if (snapshot.connectionState == ConnectionState.done) {

          final String ? posts = snapshot.data;
          if(posts!=null){
            return _buildPostsInbox(context, posts);
          }
          else{
            return Container();
          }

        } else {
          return Center(
            child:SpinKitCircle(
              color: corporateColor,
              size: 10.0,
            ),
          );
        }
      },
    );
  }
  Widget _buildPostsInbox(BuildContext context, String posts) {
    return showInboxCount(posts);
  }
  Widget showInboxCount(var _counter){
    if(_counter=="0"){
      return Container();
    }
    else{
      return  Positioned(

        right: 20,
        top: 5,
        child: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(9),
          ),
          constraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: Text(
            '$_counter',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }*/
}

class MorePageWidet extends StatelessWidget {
  final String Assetname;
  final String Title;
  const MorePageWidet({
    Key? key,required this.Assetname,required this.Title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
            border:Border(
                bottom: BorderSide(width: 0.2,color: GrayColor)
            )
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Assetname,width: 20,height: 20, ),
              SizedBox(width: 15,),
              Text(Title,style: TextStyle(
                  fontSize: 16,color: lightGrey,
              ),)

            ],

          ),
        ),
      );

  }


}
class MoreInboxWidet extends StatelessWidget {
  final String Assetname;
  final String Title;
  final String Count;
  const MoreInboxWidet({
    Key? key,required this.Assetname,required this.Title,required this.Count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border:Border(
              bottom: BorderSide(width: 0.2,color: GrayColor)
          )
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assetname,width: 20,height: 20, ),
            SizedBox(width: 15,),
            Text(Title,style: TextStyle(
              fontSize: 16,color: lightGrey,
            ),),
            SizedBox(width: 6,),
            Count!="null" && Count !=""&& Count!="0"?
                Text("("+Count.toString()+")",style: TextStyle(fontSize: 14,color: Colors.red),)
                :Container(),

          ],

        ),
      ),
    );

  }


}



