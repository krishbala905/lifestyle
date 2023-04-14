import 'dart:async';
import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:lifestyle/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:lifestyle/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../res/Colors.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import 'ReceiptHistoryModel.dart';

class ReceiptHistory extends StatefulWidget {
  const ReceiptHistory({Key? key}) : super(key: key);

  @override
  State<ReceiptHistory> createState() => _ReceiptHistoryState();
}

class _ReceiptHistoryState extends State<ReceiptHistory> {
  String Reason="";
  String declinedImageUrl="";
  var pageNumber = 1;
  bool showNoMsg = true;
  bool showContent = false;
  var data;

  late ScrollController _controller;
  int _page = 0;
  final int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<ReceiptHistoryModel> posts = [];

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1; // Increase _page by 1
      try {
        final res =
        await http.post(Uri.parse(SRORECEIPTHISTORY_URL),
            body: {
              "consumer_id": CommonUtils.consumerID.toString(),
              "country_index": "+65",
              "history_page": _page.toString(),
              "action_event":"1",
              "cma_timestamps": Utils().getTimeStamp(),
              "time_zone": Utils().getTimeZone(),
              "software_version": CommonUtils.softwareVersion,
              "os_version": CommonUtils.osVersion,
              "phone_model": CommonUtils.deviceModel,
              "device_type": CommonUtils.deviceType,
              'consumer_application_type': CommonUtils.consumerApplicationType,
              'consumer_language_id': CommonUtils.consumerLanguageId,
            });
        print("ReciptCheck2" + res.body.toString());


        final Xml2Json xml2json = new Xml2Json();

        xml2json.parse(res.body);
        var jsonstring = xml2json.toParker();
        var data = jsonDecode(jsonstring);
        var data1 = data['info'];


        var p1= Utils().stringSplit(data1['p1']);

        var p2= Utils().stringSplit(data1['p2']);

        var p3= Utils().stringSplit(data1['p3']);

        var p4= Utils().stringSplit(data1['p4']);

        var p5= Utils().stringSplit(data1['p5']);

        var p6= Utils().stringSplit(data1['p6']);

        List<String> shopName=p1.split("*");
        List<String> status=p2.split("*");
        List<String> creditedPoints=p3.split("*");
        List<String> receiptDate=p4.split("*");
        List<String> receiptNo=p5.split("*");
        List<String> receiptId=p6.split("*");

        List<ReceiptHistoryModel> object=[];

        for(int i=0;i<shopName.length;i++){



          object.add(new ReceiptHistoryModel(shopName: shopName[i], status: status[i],
              creditedPoint: creditedPoints[i], receiptDate: receiptDate[i],
              receiptNo: receiptNo[i], receiptId: receiptId[i]));
        }

        if (object.isNotEmpty) {
          setState(() {
            posts.addAll(object);
          });
        } else {
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
    try {
      final res =
      await http.post(Uri.parse(SRORECEIPTHISTORY_URL),
          body: {
            "consumer_id": CommonUtils.consumerID.toString(),
            "country_index": "+65",
            "history_page": _page.toString(),
            "action_event":"1",
            "cma_timestamps": Utils().getTimeStamp(),
            "time_zone": Utils().getTimeZone(),
            "software_version": CommonUtils.softwareVersion,
            "os_version": CommonUtils.osVersion,
            "phone_model": CommonUtils.deviceModel,
            "device_type": CommonUtils.deviceType,
            'consumer_application_type': CommonUtils.consumerApplicationType,
            'consumer_language_id': CommonUtils.consumerLanguageId,
          });
      print("ReciptCheck1"
          "" + res.body.toString());

      final Xml2Json xml2json = new Xml2Json();

      xml2json.parse(res.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var data1 = data['info'];


      var p1= Utils().stringSplit(data1['p1']);

      if (p1.isEmpty|| p1=="none") {
        showNoMsg = true;
        showContent = false;
      }
      else {

        final Xml2Json xml2json = new Xml2Json();

        xml2json.parse(res.body);
        var jsonstring = xml2json.toParker();
        var data = jsonDecode(jsonstring);
        var data1 = data['info'];


        var p1= Utils().stringSplit(data1['p1']);

        var p2= Utils().stringSplit(data1['p2']);

        var p3= Utils().stringSplit(data1['p3']);

        var p4= Utils().stringSplit(data1['p4']);

        var p5= Utils().stringSplit(data1['p5']);

        var p6= Utils().stringSplit(data1['p6']);

        List<String> shopName=p1.split("*");
        List<String> status=p2.split("*");
        List<String> creditedPoints=p3.split("*");
        List<String> receiptDate=p4.split("*");
        List<String> receiptNo=p5.split("*");
        List<String> receiptId=p6.split("*");

        List<ReceiptHistoryModel> object=[];

        for(int i=0;i<shopName.length;i++){

          object.add(new ReceiptHistoryModel(shopName: shopName[i], status: status[i],
              creditedPoint: creditedPoints[i], receiptDate: receiptDate[i],
              receiptNo: receiptNo[i], receiptId: receiptId[i]));
        }
        setState(() {
          showNoMsg = false;
          showContent = true;
          posts = object;
        });
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
    InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status ==InternetConnectionStatus.connected;
      print("Bharati"+connected.toString());
      // Flushbar(
      //   message: connected? "Internet connection enabled":"There is  no Internet Connection. Your data will not be updated",
      //   duration:  Duration(seconds: 4),
      //   flushbarPosition: FlushbarPosition.TOP,
      //   backgroundColor: Colors.grey,
      //   margin: EdgeInsets.fromLTRB(0, kTextTabBarHeight+8,0, 0),
      //   // animationDuration:  Duration(microseconds: 0),
      // ).show(context);
      if(connected == true){
        _firstLoad();
      }
    });
    _controller = ScrollController()
      ..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          backgroundColor: lightgrey3,
          appBar: AppBar(
              // leading: Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Image.asset('assets/ic_poket_100.png'),
              // ),
              elevation: 0,
             // automaticallyImplyLeading: true,
              centerTitle: true,
              title:  Text("Receipt History",style: TextStyle(fontSize: 15),),
              backgroundColor: corporateColor
          ),
          body: _isFirstLoadRunning
              ? const Center(
            child: const CircularProgressIndicator(),
          )
              :
          Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5,),
              Center(child: Text("It may take upto 7 working days to process the receipts")),
              // Visibility(
              //     visible: showNoMsg,
              //     child: Center(
              //
              //     )),
              Visibility(
                visible: showNoMsg,
                child: Center(child: Text("Data Not found")),
                replacement:

                Expanded(

                  child: ListView.builder(
                    controller: _controller,
                    itemCount: posts.length,
                    itemBuilder: (_, index) =>
                        GestureDetector(
                          onTap: () async{
                            bool isconnected = await initTimer();
                            if(isconnected == true){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      SplashScreen(),
                                  ));
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "No Internet Connection. Please turn on Internet Connection",
                                  toastLength: Toast.LENGTH_LONG);
                              // showAlertDialog_oneBtn(this.context, "Network", "Internet Connection. Please turn on Internet Connection");
                            }

                          },
                          child: InkWell(
                            onTap: (){
                              var actionEvent="0";
                              var status=posts[index].status.toString();
                              print("Status:;;"+status);
                              if(status=="1"){
                                actionEvent="3";
                              }
                              else if(status=="2"){
                                actionEvent="4";
                              }
                              else if(status=="3"){
                                actionEvent="2";
                              }
                  getApiDataForReciptDetails(actionEvent,posts[index].receiptId,posts[index],posts[index].receiptNo,posts[index].receiptDate.toString().substring(0,10));

                  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Text("+ "+posts[index].creditedPoint+" POINTS",style: TextStyle(fontSize: 9),)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(posts[index].shopName,style: TextStyle(fontSize: 11),),
                                  SizedBox(height: 5,),
                                  if(posts[index].status=="1")Row(
                                    children: [
                                      Image.asset("assets/ic_processing.png",width: 20,height: 20),
                                      SizedBox(width: 10,),
                                      Text("Processing",style: TextStyle(color: poketblue,fontSize: 13),),
                                    ],
                                  ),
                                  if(posts[index].status=="2")Row(
                                    children: [
                                      Image.asset("assets/ic_success.png",width: 20,height: 20),
                                      SizedBox(width: 10,),
                                      Text("SUCCESSFUL",style: TextStyle(color: Colors.green,fontSize: 13),)
                                    ],
                                  ),
                                  if(posts[index].status=="3")Row(
                                    children: [
                                      Image.asset("assets/ic_declined.png",width: 20,height: 20,),
                                      SizedBox(width: 10,),
                                      Text("Declined",style: TextStyle(color: Colors.red,fontSize: 13)),
                                    ],
                                  ),




                                  Text("Receipt Date",style: TextStyle(fontSize: 11),),
                                  Text(posts[index].receiptDate,style: TextStyle(fontSize:11),),
                                  const SizedBox(height: 5,),
                                  Text("Receipt No",style: TextStyle(fontSize: 11),),
                                  Text(posts[index].receiptNo,style: TextStyle(fontSize: 11),),


                                ],


                              ),
                            ],





                          ),
                        ),
                      ),
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
                  color: Colors.amber,
                  child: Center(
                    child: Text("Fetched All Content"),
                  ),
                ),


            ],
          ),
        ),
      );
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


  void showDetailsDialog(var actionEvent,ReceiptHistoryModel historyModel , dynamic data, var number, var date){
    print("actionEvent:"+actionEvent);
    // var p1=Utils().stringSplit(data['p1']);
    var p8,p9,p10,p11,p12,p13,p14,p6,p7;
    var p1=date;
    print(date.toString());
    var p2=Utils().stringSplit(data['p2']);
    var p3=Utils().stringSplit(data['p3']);
    var p4=Utils().stringSplit(data['p4']);
    // var p5=Utils().stringSplit(data['p5']);
    var p5=number;
    if(actionEvent!="3"){
       p6=Utils().stringSplit(data['p6']);
       p7=Utils().stringSplit(data['p7']);
    }


    if(actionEvent=="4"){
       p8=Utils().stringSplit(data['p8']);
      p9=Utils().stringSplit(data['p9']);
      p10=Utils().stringSplit(data['p10']);
      p11=Utils().stringSplit(data['p11']);
      p12=Utils().stringSplit(data['p12']);
      p13=Utils().stringSplit(data['p13']);
      p14=Utils().stringSplit(data['p14']);
    }
    if(actionEvent=="2"){
      p5=Utils().stringSplit(data['p5']);
      p6=p6.toString().replaceAll("\\n", "");
      p6=p6.toString().replaceAll("\\", "");
      setState(() {
        Reason=p6;
        declinedImageUrl=p7;

      });
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(

      context: context, builder: (_) => AlertDialog(

      content: SingleChildScrollView(
        child: Container(
          height: height-100,
          width: width-20,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10,),
              InkWell(
                onTap:(){Navigator.pop(context);},
                child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.close,color: poketPurple,size: 20,)),
              ),

              const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Receipt submitted on:",style: TextStyle(fontSize: 12),)),
              const SizedBox(height: 5,),
               Align(
                  alignment: Alignment.topLeft,
                  child:Text(historyModel.receiptDate,style: TextStyle(fontSize: 12),),
              ),

              const SizedBox(height: 10,),
              Row(children: const[
                Expanded(flex:1,child: Text("Retailer",style: TextStyle(fontSize: 15),)),
                Expanded(flex: 1,child:Text("Status",style: TextStyle(fontSize: 15),)),
              ],),
              Container(
                color: lightGrey,
                width: double.infinity,
                height: 1,
              ),

              const SizedBox(height: 10,),
              Row(children: [
                Expanded(flex:1,child: Text(historyModel.shopName,style: TextStyle(fontSize: 12),),),
                Expanded(flex: 1,child:getStatus(historyModel.status)),
              ],),
              SizedBox(height: 10,),
              Row(children: const[
                Expanded(flex:1,child: Text("Receipt Date",style: TextStyle(fontSize: 12),)),
                Expanded(flex: 1,child:Text("Receipt No",style: TextStyle(fontSize: 12),)),
              ],),

              Row(children: [
                Expanded(flex:1,child: Text(p1,style: TextStyle(fontSize: 12),)),
                Expanded(flex: 1,child:Text(p5,style: TextStyle(fontSize: 12),)),
              ],),
              const SizedBox(height: 15,),
              if(historyModel.status=="1")
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text("Kindly note that your receipt is being processed",style: TextStyle(color: PoketNormalGreen,fontSize: 13),),
                  ),
                ),
              if(historyModel.status=="2")
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54,width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Receipt amount",style: TextStyle(fontSize: 10),),
                      )),
                      Expanded(flex: 1,child:Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(p6+'\$',style: TextStyle(fontSize: 10),),
                      )),
                    ],),
                    Container(
                      color: lightGrey,
                      width: double.infinity,
                      height: 1,
                    ),
                    Row(children: [
                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Receipt points",style: TextStyle(fontSize: 10),),
                      )),
                      Expanded(flex: 1,child:Padding(

                        padding: const EdgeInsets.all(3.0),
                        child: Text(p7,style: TextStyle(fontSize: 10),),
                      )),
                    ],),
                    Container(
                      color: lightGrey,
                      width: double.infinity,
                      height: 1,
                    ),
                    Row(children: [
                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Self help Bonus",style: TextStyle(fontSize: 10),),
                      )),
                      Expanded(flex: 1,child:Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(p11,style: TextStyle(fontSize: 10),),
                      )),
                    ],),
                    Container(
                      color: lightGrey,
                      width: double.infinity,
                      height: 1,
                    ),
                    Row(children: [
                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("1st Purchase Bonus",style: TextStyle(fontSize: 10),),
                      )),
                      Expanded(flex: 1,child:Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(p12,style: TextStyle(fontSize: 10),),
                      )),
                    ],),
                    Container(
                      color: lightGrey,
                      width: double.infinity,
                      height: 1,
                    ),
                    Row(children: [
                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Birthday Bonus",style: TextStyle(fontSize: 10),),
                      )),
                      Expanded(flex: 1,child:Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(p13,style: TextStyle(fontSize: 10),),
                      )),
                    ],),
                    Container(
                      color: lightGrey,
                      width: double.infinity,
                      height: 1,
                    ),
                    Row(children: [
                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Total Points",style: TextStyle(fontSize: 10),),
                      )),
                      Expanded(flex: 1,child:Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(p14,style: TextStyle(fontSize: 10),),
                      )),
                    ],),
                    Container(
                      color: lightGrey,
                      width: double.infinity,
                      height: 1,
                    ),
                    Row(children: [
                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Credited date/time",style: TextStyle(fontSize: 10),),
                      )),
                      Expanded(flex: 1,child:Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(p8,style: TextStyle(fontSize: 10),),
                      )),
                    ],),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        showImage(p9);
                      },
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                            color: corporateColor,
                            border: Border.all(color: corporateColor,),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(child: Text("View Your Receipt Image",style: TextStyle(color: Colors.white,fontSize: 10),)),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    InkWell(
                      onTap:(){
                        showReportMistakeUI(historyModel.receiptId);
                      },
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                            color: corporateColor,
                            border: Border.all(color: corporateColor,),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(child: Text("Report Mistake",style: TextStyle(color: Colors.white,fontSize: 10),)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      color: lightGrey,
                      width: double.infinity,
                      height: 1,
                    ),

                  ],
                ),
              ),

              if(historyModel.status=="3")
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Reason for Rejection",style: TextStyle(fontSize: 12),),
                      Container(
                      color: grey,
                      height: 1,
                      width: double.infinity,
                      ),

                      SizedBox(height: 5,),
                      Text(Reason,style: TextStyle(fontSize: 13)),

                      SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          showImage(declinedImageUrl);
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: corporateColor,
                            border: Border.all(color: corporateColor,),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(child: Text("View Your Receipt Image",style: TextStyle(color: Colors.white,fontSize: 10),)),
                        ),
                      ),
                    ],
                  ),
                ),


            ],
          ),
        ),
      ),
    ),);
  }
  void showImage(var imageUrl){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Column(
        children: [
          InkWell(
            onTap:(){
              Navigator.pop(context);
            },
            child: Row(children: const [
              Icon(Icons.arrow_back_ios,color: lightGrey,size: 20,),
              Text("Back",style: TextStyle(color: lightGrey,fontSize: 9),),
            ],),
          ),

          Image.network(imageUrl,width: 200,height: 450,),
        ],
      ),
    ),);
  }
  void showReportMistakeUI(var prgmId){
    TextEditingController tV=new TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      content:SingleChildScrollView(
        child: Column(

          children: [
            InkWell(
              onTap:(){
                Navigator.pop(context);
              },
              child: Row(children: const [
                Icon(Icons.arrow_back_ios,color: lightGrey,size: 20,),
                Text("Back",style: TextStyle(color: lightGrey,fontSize: 11),),
              ],),
            ),
            const SizedBox(height: 20,),
            const Text("Report Mistake",style: TextStyle(fontSize: 11),),
            Container(
              color: lightGrey,
              width: double.infinity,
              height: 1,
            ),
            const SizedBox(height:10),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: lightGrey,
                    width: 1
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top: 5                    ),
                    child: const Text("Please enter the comments below:",style: TextStyle(fontSize: 11),),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: tV,
                      style: TextStyle(fontSize:10),

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Comments Here",
                        hintStyle: TextStyle(color: lightGrey,fontSize: 10),

                      ),
                      maxLines: 8,
                    ),
                  )

                ],
              ),
            ),
            const SizedBox(height:10),
            InkWell(
              onTap: (){
                if(tV.text.isNotEmpty){
                  callApiforReport(prgmId,tV.text);
                  Navigator.pop(context);
                }
                else{
                  showAlertDialog_oneBtn(context, alert,"Please enter your comments");
                }

              },

                child: Center(
                  child: Container(width:100,height:30,decoration: BoxDecoration(color: corporateColor,borderRadius: BorderRadius.circular(15)),
                    child: Center(child: const Text("Report",style: TextStyle(fontSize: 9,color: Colors.white),),),),
                ),

            ),
          ],
        ),
      ),
    ),);
  }

  Future<void> callApiforReport  (var prgmId,var content)async {


    final http.Response response = await http.post(
      Uri.parse(SRORECEIPTHISTORY_URL),

      body: {
        "country_index":"191",
        "consumer_id": CommonUtils.consumerID.toString(),
        "receipt_id": prgmId,
        "action_event":"5",
        "os_version":"31",
        "consumer_application_type":"22",
        "software_version":"1.1",
        "device_model":"1.1",
        "consumer_language_id":"1.1",
        "report_contents":content,
      },
    ).timeout(Duration(seconds: 30));


    print("Details1:"+response.body.toString());

    if(response.statusCode==200)
    {


      final Xml2Json xml2json = new Xml2Json();

      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var data1 = data['info'];
      var p1=data1["p1"];
      var p2=Utils().stringSplit(data1["p2"]);
      showAlertDialog_oneBtn(context, appName,p2);





    }
    else {
      throw "Unable to retrieve posts.";
    }

  }

  Widget getStatus(var status){
    if(status=="1") {
      return Row(
        children: [
          const SizedBox(width: 8,),
          Image.asset("assets/ic_processing.png",width: 20,height: 20),
          const SizedBox(width: 10,),
          const Text("Processing",style: TextStyle(color: poketblue,fontSize: 12),),
        ],
      );
    }
    else if(status=="2") {
      return Row(
        children: [
          const SizedBox(width: 5,),
          Image.asset("assets/ic_success.png",width: 20,height: 20),
          const SizedBox(width: 10,),
          const Text("SUCCESSFUL",style: TextStyle(color: Colors.green,fontSize: 12),)
        ],
      );
    }
    else if(status=="3") {
      return Row(
        children: [
          const SizedBox(width: 5,),
          Image.asset("assets/ic_declined.png",width: 20,height: 20,),
          const SizedBox(width: 10,),
          const Text("Declined",style: TextStyle(color: Colors.red,fontSize: 12)),
        ],
      );
    }
    else{
      return Container();
    }
  }
  Future<void>  getApiDataForReciptDetails(var actionEvent,var receiptId,ReceiptHistoryModel data8,var receptNo,var reciptDate)async{
    print("ReciptId:"+receiptId.toString());
    print("ConsumerId:"+CommonUtils.consumerID.toString());
    final http.Response response = await http.post(
      Uri.parse(SRORECEIPTHISTORY_URL),

      body: {
        "country_index":"191",
        "consumer_id": CommonUtils.consumerID.toString(),
        "receipt_id": receiptId.toString(),
        "action_event":actionEvent,
        "os_version":CommonUtils.osVersion.toString(),
        "consumer_application_type":CommonUtils.consumerApplicationType.toString(),
        "software_version":CommonUtils.softwareVersion.toString(),
        "device_model":CommonUtils.deviceModel.toString(),
        "consumer_language_id":CommonUtils.consumerLanguageId.toString(),
        "report_contents":"1.1",
      },
    ).timeout(Duration(seconds: 30));

    print("Details2:"+response.body.toString());

    if(response.statusCode==200)
    {


      final Xml2Json xml2json = new Xml2Json();

      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var data1 = data['info'];


      showDetailsDialog(actionEvent,data8,data1,receptNo,reciptDate);


    }
    else {
      throw "Unable to retrieve posts.";
    }

  }

}
