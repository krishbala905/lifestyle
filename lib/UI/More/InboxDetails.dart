import 'dart:convert';

import 'package:lifestyle/UI/ConsumerTab.dart';

import '../../Others/AlertDialogUtil.dart';
import '../../Others/CommonUtils.dart';
import '../../Others/Urls.dart';
import '../../Others/Utils.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import 'Inboxmodel/InboxDetailsModel.dart';
class InboxDetails extends StatefulWidget {



  InboxDetails({Key? key , }) : super(key: key);



  @override
  State<InboxDetails> createState() => _InboxDetailsState(CommonUtils.cid,
      CommonUtils.merid, CommonUtils.mername,
      CommonUtils.msgid,
      CommonUtils.msgtype,CommonUtils.msgsubtype,
      CommonUtils.msgsenddate,CommonUtils.msgreadstatus,
      CommonUtils.msgtitile,CommonUtils.merchlogo);
}

class _InboxDetailsState extends State<InboxDetails> {
  double Heightwebview = 100.0;
  late WebViewController _controller;
  var messageimages;
  var cid,merid,mername,msgid,msgtype,msgsubtype,msgsenddate,msgreadstatus,msgtitile,merchlogo;
  _InboxDetailsState(this.cid,this.merid,this.mername,this.msgid,this.msgtype,this.msgsubtype,this.msgsenddate,this.msgreadstatus,this.msgtitile,this.merchlogo);
  late Future<List<InboxDetailsModel>> myfuture;
  @override
  void initState() {
    // TODO: implement initState

    // if(msgid!="0"){
      myfuture = getInboxDetails();
    // }
    //
    // else{
    //   Navigator.pop(context);
    // }
    super.initState();
  }
  @override
  void dispose() {
    _InboxDetails(context);
    super.dispose();
  }
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(mername,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
             Navigator.pop(context);
            CommonUtils.NAVIGATE_PATH=CommonUtils.inboxPage;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ConsumerTab()));
            // _goBack(context);
          },
        ),
        backgroundColor: Maincolor,
        automaticallyImplyLeading: false,
      ),
      body:
      _InboxDetails(context),

    ));
  }
  FutureBuilder<List<dynamic>> _InboxDetails(BuildContext context) {

    return FutureBuilder<List<InboxDetailsModel>>(

      future: myfuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<InboxDetailsModel>? posts = snapshot.data;
          /*if(posts!=null){
            return _buildPostsHome(context, posts);
          }
          else{
            return Container();
          }*/
          if(posts!=null){
           print("chekbhar"+messageimages.toString());
            return WillPopScope(
              child: SafeArea(
                child: SingleChildScrollView(

                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(msgsenddate)),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey),
                          height: 0.75,
                        ),SizedBox(height: 10,),
                        posts[0].MESSAGE_DESCRIPTION!="none"?
                        Container(
                          height: 100.0,
                          child: Text(posts[0].MESSAGE_DESCRIPTION,style: TextStyle(fontSize: 15.0),),
                        ) :
                        Container(
                          height: Heightwebview,
                          width: double.infinity,
                          child: WebView(
                            initialUrl: posts[0].HTML_FILE,
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated: ( WebViewController Web) {

                              this._controller = Web;

                            },
                            onPageFinished: (finish) async {
                              double height = double.parse(await _controller
                                  .runJavascriptReturningResult(
                                  "document.documentElement.scrollHeight;"));
                              setState(() {
                                print(height);
                                Heightwebview = height;
                              });
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey),
                          height: 0.75,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        messageimages!="none"?
                        Container(
                          height: 100.0,
                           child: Image.network(messageimages),
                        ) :
                            Container(),
                        /*posts[1] != "none" ?
                        Container(
                          height: 350.0,
                          child: Column(
                            children: [

                              Container(
                                width: MediaQuery.of(context).size.width/1.5,
                                child: Stack(

                                  children: [
                                    Image.network(posts[0],width: MediaQuery.of(context).size.width/1.5,),
                                    Padding(
                                      padding: const EdgeInsets.only(top:10.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Image.network(merchlogo??"https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png",
                                            width: 30,height: 30,),
                                          SizedBox(width: 20,),
                                          Text(mername,style: TextStyle(fontSize:15),),

                                        ],
                                      ),
                                    ),
                                  ],

                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left:20,right: 20,top: 20),
                                child: Text(posts[2],style: TextStyle(fontSize: 15.0,color: Colors.black54),),
                              ),
                            ],
                          ),
                        ): Container(height: 10.0,)*/
                      ],
                    ),
                  ),
                ),
              ),
              onWillPop: ()async{
                Navigator.pop(context);
                CommonUtils.NAVIGATE_PATH=CommonUtils.inboxPage;
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => ConsumerTab()));
                return true;

              },
            );
          }
          else{
            return Container();
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
  Future<List<InboxDetailsModel>> getInboxDetails() async {
    debugPrint("check1"+ merid.toString());
    debugPrint("check1"+ CommonUtils.consumerID.toString());
    debugPrint("check1"+ cid.toString());
    debugPrint("check2"+ msgtype.toString());
    debugPrint("check1"+ msgsubtype.toString());
    debugPrint("check1"+ msgid.toString());

    final http.Response response = await http.post(
      Uri.parse(INBOX_DETAILS_URL),

      body: {
        "merchant_id": merid.toString(),
        "consumer_id": CommonUtils.consumerID.toString(),
        "country_index":cid.toString(),
        "message_type" :msgtype.toString(),
        "message_sub_type":msgsubtype.toString(),
        "message_id": msgid.toString(),
      },
    ).timeout(Duration(seconds: 30));

    debugPrint("check4"+ response.body.toString());
    if(response.statusCode==200 )
    {
      final Xml2Json xml2json = new Xml2Json();
      xml2json.parse(response.body);
      var jsonstring = xml2json.toParker();
      var data = jsonDecode(jsonstring);
      var newData = data['info'];
      var html_file = Utils().stringSplit(newData['p1']);
       messageimages = Utils().stringSplit(newData['p2']);
      var messageid = Utils().stringSplit(newData['p3']);
      var messagetitle = Utils().stringSplit(newData['p4']);
      var messagedescription = Utils().stringSplit(newData['p5']);
      var eventstatus = Utils().stringSplit(newData['p6']);
      var voucherstatus= Utils().stringSplit(newData['p7']);
      var buttonstatus = Utils().stringSplit(newData['p8']);
      print(html_file.toString());
      print(messageimages.toString());
      List<String> HTML_FILE = html_file.split("*");
      List<String> MESSAGE_IMAGES = messageimages.split("*");
      List<String> MESSAGE_ID = messageid.split("*");
      List<String> MESSAGE_TITLE = messagetitle.split("*");
      List<String> MESSAGE_DESCRIPTION = messagedescription.split("*");
      List<String> EVENT_STATUS =eventstatus.split("*");
      List<String> VOUCHER_STATUS = voucherstatus.split("*");
      List<String> BUTTON_STATUS = buttonstatus.split("*");
      List<InboxDetailsModel> object = [];
      int i = 0;
      object.add(new InboxDetailsModel(
        MESSAGE_ID :MESSAGE_ID[i],
        HTML_FILE:HTML_FILE[i],
        MESSAGE_TITLE: MESSAGE_TITLE[i],
        MESSAGE_DESCRIPTION: MESSAGE_DESCRIPTION[i],
        MESSAGE_IMAGES: MESSAGE_IMAGES,
        EVENT_STATUS: EVENT_STATUS[i],
        VOUCHER_STATUS: VOUCHER_STATUS[i],
        BUTTON_STATUS: BUTTON_STATUS[i],
       ));
      List<InboxDetailsModel> list = object;
      print(MESSAGE_IMAGES.toString());
      return list;


      //  List<dynamic> body1 = jsonDecode(response.body)["data"];
      // List<InboxInitModel> posts1 = body1.map((dynamic item) => InboxInitModel.fromJson(item),).toList();
      // debugPrint("hii"+posts1.toString());
      // return posts1;
    }
    else {

      throw "Unable to retrieve posts.";
    }

  }
}
