import 'dart:async';
import 'dart:convert';

import 'package:lifestyle/UI/More/InboxDetailsIOS.dart';

import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';

import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'InboxDetails.dart';
import 'Inboxmodel/InboxModel.dart';

class InboxFragment extends StatefulWidget {
  const InboxFragment({Key? key}) : super(key: key);

  @override
  State<InboxFragment> createState() => _InboxFragmentState();
}

class _InboxFragmentState extends State<InboxFragment> {
  var pageNumber = 1;
  bool showNoMsg = true;
  bool showContent = false;
  var data;

  late ScrollController _controller;
  int _page = 1;
  final int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _posts = [];
   List<InboxModel> posts =[];

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      debugPrint("loadmorepage"+_page.toString());// Increase _page by 1
      try {
        final res =
        await http.post(Uri.parse(INBOX_URL),
            body: {
              "consumer_id": CommonUtils.consumerID.toString(),
              "country_index": "+65",
              "page_number": _page.toString(),
              "cma_timestamps": Utils().getTimeStamp(),
              "time_zone": Utils().getTimeZone(),
              "software_version": CommonUtils.softwareVersion,
              "os_version": CommonUtils.osVersion,
              "phone_model": CommonUtils.deviceModel,
              "device_type": "2",
              'consumer_application_type': CommonUtils.consumerApplicationType,
              'consumer_language_id': CommonUtils.consumerLanguageId,
            });
        print("InboxList1" + res.body.toString());
        final Xml2Json xml2json = new Xml2Json();
        xml2json.parse(res.body);
        var jsonstring = xml2json.toParker();
        var data = jsonDecode(jsonstring);
        var newData = data['info'];
        debugPrint("check2"+ newData['p13'].toString());
        debugPrint("check6b"+ newData['p6'].toString());
        var merchantid = Utils().stringSplit(newData['p1']);
        var merchantname = Utils().stringSplit(newData['p2']);
        var merchanturl = Utils().stringSplit(newData['p3']);
        var messagetitle = Utils().stringSplit(newData['p4']);
        var messageid = Utils().stringSplit(newData['p5']);
        var messagesenddate = Utils().stringSplit(newData['p6']);
        var readstatus = Utils().stringSplit(newData['p7']);
        var messagetype = Utils().stringSplit(newData['p8']);
        var downloadvoucherformat = Utils().stringSplit(newData['p9']);
        var validuntil = Utils().stringSplit(newData['p10']);
        var countryindex = Utils().stringSplit(newData['p11']);
        var messagesubtype = Utils().stringSplit(newData['p12']);
        var inboxcount = Utils().stringSplit(newData['p13']);

        List<String> MERCHANT_ID = merchantid.split("*");
        List<String> MERCHANT_NAME = merchantname.split("*");
        List<String> MERCHANT_URL = merchanturl.split("*");
        List<String> MESSAGE_TITLE = messagetitle.split("*");
        List<String> MESSAGE_ID = messageid.split("*");
        List<String> MESSAGE_SEND_DATE = messagesenddate.split("*");
        List<String> READ_STATUS = readstatus.split("*");
        List<String> MESSAGE_TYPE = messagetype.split("*");
        List<String> VALID_UNTIL = validuntil.split("*");
        List<String> COUNTRY_INDEX = countryindex.split("*");
        List<String> MESSAGE_SUB_TYPE = messagesubtype.split("*");
        //   List<String> INBOX_COUNT = inboxcount.split("*");
        List<InboxModel> object = [];


        for (int i = 0; i < MERCHANT_ID.length; i++) {

          object.add(new InboxModel(
            MERCHANT_ID: MERCHANT_ID[i],
            MERCHANT_NAME: MERCHANT_NAME[i],
            MERCHANT_URL :MERCHANT_URL[i],
            MESSAGE_TITLE:MESSAGE_TITLE[i],
            MESSAGE_ID :MESSAGE_ID[i],
            MESSAGE_SEND_DATE:MESSAGE_SEND_DATE[i],
            READ_STATUS :READ_STATUS[i],
            MESSAGE_TYPE:MESSAGE_TYPE[i],
            VALID_UNTIL :VALID_UNTIL[i],
            COUNTRY_INDEX :COUNTRY_INDEX[i],
            MESSAGE_SUB_TYPE :MESSAGE_SUB_TYPE[i],
            /*INBOX_COUNT:INBOX_COUNT[i],*/));
        }
        final List<InboxModel> fetchedPosts = object;
        debugPrint("important"+fetchedPosts.toString());
        debugPrint("important"+fetchedPosts.length.toString());
        if (merchantid.toString()!="none") {
        //if (inboxcount!="1000") {
          if (fetchedPosts.isNotEmpty) {
            setState(() {
              posts.addAll(fetchedPosts);
            });
          }
        }
        else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print("Excep4512:" + err.toString());
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    print("page"+_page.toString());
    try {
      final res =
      await http.post(Uri.parse(INBOX_URL),
          body: {
            "consumer_id": CommonUtils.consumerID.toString(),
            "country_index": "+65",
            "page_number": _page.toString(),
            "cma_timestamps": Utils().getTimeStamp(),
            "time_zone": Utils().getTimeZone(),
            "software_version": CommonUtils.softwareVersion,
            "os_version": CommonUtils.osVersion,
            "phone_model": CommonUtils.deviceModel,
            "device_type": "2",
            'consumer_application_type': CommonUtils.consumerApplicationType,
            'consumer_language_id': CommonUtils.consumerLanguageId,
          });
      debugPrint("InboxList1" + res.body.toString());
      if (res.statusCode == 200) {
        final Xml2Json xml2json = new Xml2Json();
        xml2json.parse(res.body);
        var jsonstring = xml2json.toParker();
        var data = jsonDecode(jsonstring);
        var newData = data['info'];
        var merchantid = Utils().stringSplit(newData['p1']);
        if (merchantid.isEmpty|| merchantid=="none") {
          print("chekdkjg");
          showNoMsg = true;
          showContent = false;
        }else{
          final Xml2Json xml2json = new Xml2Json();
          xml2json.parse(res.body);
          var jsonstring = xml2json.toParker();
          var data = jsonDecode(jsonstring);
          var newData = data['info'];
          debugPrint("check2"+ newData['p13'].toString());
          debugPrint("check1b"+ newData['p1'].toString());
          debugPrint("check4b"+ newData['p4'].toString());
          debugPrint("check5b"+ newData['p5'].toString());
          debugPrint("check6b"+ newData['p6'].toString());
          debugPrint("check7b"+ newData['p7'].toString());
          debugPrint("check8b"+ newData['p8'].toString());
          debugPrint("check9b"+ newData['p9'].toString());
          debugPrint("check10b"+ newData['p10'].toString());
          debugPrint("check11b"+ newData['p11'].toString());
          debugPrint("check12b"+ newData['p12'].toString());
          var merchantid = Utils().stringSplit(newData['p1']);
          var merchantname = Utils().stringSplit(newData['p2']);
          var merchanturl = Utils().stringSplit(newData['p3']);
          var messagetitle = Utils().stringSplit(newData['p4']);
          var messageid = Utils().stringSplit(newData['p5']);
          var messagesenddate = Utils().stringSplit(newData['p6']);
          var readstatus = Utils().stringSplit(newData['p7']);
          var messagetype = Utils().stringSplit(newData['p8']);
          var downloadvoucherformat = Utils().stringSplit(newData['p9']);
          var validuntil = Utils().stringSplit(newData['p10']);
          var countryindex = Utils().stringSplit(newData['p11']);
          var messagesubtype = Utils().stringSplit(newData['p12']);
          var inboxcount = Utils().stringSplit(newData['p13']);

          List<String> MERCHANT_ID = merchantid.split("*");
          List<String> MERCHANT_NAME = merchantname.split("*");
          List<String> MERCHANT_URL = merchanturl.split("*");
          List<String> MESSAGE_TITLE = messagetitle.split("*");
          List<String> MESSAGE_ID = messageid.split("*");
          List<String> MESSAGE_SEND_DATE = messagesenddate.split("*");
          List<String> READ_STATUS = readstatus.split("*");
          List<String> MESSAGE_TYPE = messagetype.split("*");
          List<String> VALID_UNTIL = validuntil.split("*");
          List<String> COUNTRY_INDEX = countryindex.split("*");
          List<String> MESSAGE_SUB_TYPE = messagesubtype.split("*");
          // List<String> INBOX_COUNT = inboxcount.split("*");
          List<InboxModel> object = [];
          // var inboxxcount = int.parse(INBOX_COUNT[0].toString());

          for (int i = 0; i < MERCHANT_ID.length; i++) {

            object.add(new InboxModel(
              MERCHANT_ID: MERCHANT_ID[i],
              MERCHANT_NAME: MERCHANT_NAME[i],
              MERCHANT_URL :MERCHANT_URL[i],
              MESSAGE_TITLE:MESSAGE_TITLE[i],
              MESSAGE_ID :MESSAGE_ID[i],
              MESSAGE_SEND_DATE:MESSAGE_SEND_DATE[i],
              READ_STATUS :READ_STATUS[i],
              MESSAGE_TYPE:MESSAGE_TYPE[i],
              VALID_UNTIL :VALID_UNTIL[i],
              COUNTRY_INDEX :COUNTRY_INDEX[i],
              MESSAGE_SUB_TYPE :MESSAGE_SUB_TYPE[i],
              /* INBOX_COUNT:INBOX_COUNT[i]*/));
          }
          setState(() {

            showNoMsg = false;
            showContent = true;
            posts = object;
            print("chekcdkjgi"+posts.length.toString());

          });
        }

        // return object;
        // if (INBOX_COUNT =="0") {
       /* if (inboxcount.toString() =="none") {
          showNoMsg = true;
          showContent = false;
        }*/
       // else {

       // }

      }

    } catch (err) {
      print("Excep12:" + err.toString());
    }
    setState(() {

      _isFirstLoadRunning = false;
    });

  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
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
        _firstLoad();
      }
    });*/
    _controller = ScrollController()
      ..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Maincolor,
          automaticallyImplyLeading: true,
          title: Text(inbox),
          centerTitle: true,),
        body: _isFirstLoadRunning
            ? const Center(
          child: const CircularProgressIndicator(),
        )
            :
        Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Visibility(
            //     visible: showNoMsg,
            //     child: Center(
            //
            //     )),
            Visibility(
              visible: showNoMsg,
              child: Center(child: Text(noMessage)),
              replacement: Expanded(
                child: ListView.builder(
                  controller: _controller,
                  itemCount: posts.length,
                  itemBuilder: (_, index) =>
                      GestureDetector(
                        onTap: () async{
                          bool isconnected = await initTimer();
                          if(isconnected == true){
                            CommonUtils.cid=posts[index].COUNTRY_INDEX;
                            CommonUtils.merid=posts[index].MERCHANT_ID;
                            CommonUtils.mername= posts[index].MERCHANT_NAME;
                            CommonUtils.msgid=posts[index].MESSAGE_ID;
                            CommonUtils.msgtype=posts[index].MESSAGE_TYPE;
                            CommonUtils.msgsubtype=posts[index].MESSAGE_SUB_TYPE;
                            CommonUtils.msgsenddate=posts[index].MESSAGE_SEND_DATE;
                            CommonUtils.msgreadstatus= posts[index].READ_STATUS;
                            CommonUtils.msgtitile=posts[index].MESSAGE_TITLE;
                            CommonUtils.merchlogo=posts[index].MERCHANT_URL;


                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      InboxDetailsIOS()));


                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "No Internet Connection. Please turn on Internet Connection",
                                toastLength: Toast.LENGTH_LONG);
                            // showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
                          }

                        },
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                  children: [
                                    Expanded(flex: 2,
                                      child: ClipOval(
                                          child: Container(
                                              height: 50.0,
                                              decoration: BoxDecoration(color: Colors.white70,
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Maincolor, width: 0.0),
                                              ), // this line makes the coffee.
                                              child: Center(child:Text((index+1).toString(), style: const TextStyle(color: Color(0xff2200ff))))
                                          )),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: messageReadORNot(
                                              posts[index].READ_STATUS,
                                              posts[index].MERCHANT_NAME,
                                              posts[index].MESSAGE_TITLE,
                                              posts[index].MESSAGE_SEND_DATE,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    posts[index].READ_STATUS=="2"?
                                    Expanded(flex: 1,
                                        child: Image.asset("assets/ic_unread.png",height: 25, width: 25,)):
                                    Container(),
                                    Expanded(flex: 2,
                                        child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.black26,
                                          size: 25,)),
                                  ]


                              ),
                              SizedBox(height: 5,),
                              Container(height: 1,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black26),)
                            ],
                          ),
                        ),
                      ),

                ),
              ),
            ),

            // when the _loadMore function is running
            if (_isLoadMoreRunning == true)
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 40),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),

            // When nothing else to load
            if (_hasNextPage == false)
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 40),
                color: Colors.white,
                child: Center(
                  child: Text(fetched_all_content),
                ),
              ),


          ],
        ),
      ),
    );
  }
  Widget messageReadORNot(var active, var merchantName, var tittle, var date) {

    if (active == "1") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          Text(merchantName, style: TextStyle(color: Colors.grey),),
          SizedBox(height: 5,),
          Text(tittle, style: TextStyle(color: Colors.grey),),
          SizedBox(height: 8,),
          Text(date, style: TextStyle(color: Colors.grey),),
          SizedBox(height: 8,),
        ],
      );
    }
    else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          Text(merchantName, style: TextStyle(color: Colors.black),),
          SizedBox(height: 5,),
          Text(tittle, style: TextStyle(color: Colors.black),),
          SizedBox(height: 15,),
          Text(date, style: TextStyle(color: Colors.black),),
          SizedBox(height: 8,),
        ],
      );
    }
  }

  Future<bool> initTimer() async{
    bool check = true;
    if(await checkinternet()){
      print("connected1");
      Timer(Duration(seconds: 3), () {
        print("connected");
        check = true;
      });
    }else{
      check = false;
      //   showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
    }
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
}
