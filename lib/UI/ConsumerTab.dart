import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifestyle/Others/PPNAPIClass.dart';
import 'package:lifestyle/UI/Buy_voucher/Buy_VoucherFragment.dart';
import 'package:lifestyle/UI/More/InboxDetailsIOS.dart';
import 'package:lifestyle/res/Colors.dart';
import 'package:lifestyle/res/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Others/AlertDialogUtil.dart';
import '../Others/CommonUtils.dart';
import '../Others/LocalNotificationService.dart';
import '../Others/Urls.dart';
import '../Others/Utils.dart';
import 'Home/HomeFragment.dart';
import 'More/InboxFragment.dart';
import 'More/MoreFragment.dart';
import 'Receipt/ReceiptFragment.dart';
import 'Wallet/WalletFragment.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class ConsumerTab extends StatefulWidget {
  const ConsumerTab({Key? key}) : super(key: key);

  @override
  State<ConsumerTab> createState() => _ConsumerTabState();
}

class _ConsumerTabState extends State<ConsumerTab> {
  String navigatePage="none";

  var tittle="Home";
  int _selectedIndex = 0;

  var homeActive=1;
  var receiptActive=0;
  var walletActive=0;
  var buyvocuherActive=0;
  var moreActive=0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),
    ReceiptFragment(),
    WalletFragment(),
    Buy_VoucherFragment(),
    MoreFragment(),
  ];

  var isDeviceConnected=false;
  bool isALert=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("testInitConsumerTab");
    // Foreground




    /*if(FirebaseMessaging.onMessage.isBroadcast){
      FirebaseMessaging.onMessage.asBroadcastStream().listen((RemoteMessage message) {




        var encodedData=jsonEncode(message.data);
        var decodedData=jsonDecode(encodedData);
        String showtitle=decodedData["message"];
        String moreData=decodedData["moredata"];

        CommonUtils.msgid=moreData;

        LocalNotificationService.initialize(context);
        LocalNotificationService.displayForBroadCast(appName,showtitle);


      });
    }*/
    FirebaseMessaging.onMessage.listen((message) async {
      print("1:"+message.data.toString());

      if(message.notification!=null){
        print("1:Gokul");
        try{
          debugPrint("Frgnd:1:"+message.data.toString());
          try{
            LocalNotificationService.initialize(context);
            LocalNotificationService.display(message);
          }
          catch(e){
            debugPrint("frgExce:"+e.toString());
          }
          /*var action="0";
          print("q:"+CommonUtils.pid);
          if(CommonUtils.pid!="0"){
            action="1";
          }
          dynamic result=await callPPNAPIXML(context,action,CommonUtils.pid,"","");*/



        }
        catch(e){
          debugPrint("FrgndExcep"+e.toString());
        }
      }

    });

    //
    // // BackGround
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print("Gokul2");
      if (message.notification != null) {
        print("Gokul1");
        try {

          dynamic result=await callPPNAPIXML(context,"0","","","");
          changeToPage(result);

        }
        catch (e) {
          debugPrint("FrgndExcep" + e.toString());
        }
      }

       if(message.data!=null){
        print("Gokul");
        print("bharathi"+ message.data.toString());
        print("bharathi"+ message.toString());
        print("bharathi"+ message.notification.toString());
        var encodedData=jsonEncode(message.data);
        var decodedData=jsonDecode(encodedData);
        print("decode"+ decodedData.toString());
        String moreData=decodedData["moredata"];
        navigateToInboxDetailsPage(moreData);
      }
    });

    hideKeyboard();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        var action="0";
        print("q:"+CommonUtils.pid);
        if(CommonUtils.pid!="0"){
          action="1";
        }
        // dynamic result=await callPPNAPIXML(context,"","","");
        dynamic result=await callPPNAPIXML(context,action,CommonUtils.pid,"","");
        changeToPage(result);
      }
      catch (e) {
        debugPrint("InitExcep" + e.toString());
      }
    });
    print("bharathicheck3");
    changeToPage(CommonUtils.NAVIGATE_PATH);

    CommonUtils.NAVIGATE_PATH=CommonUtils.none;
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(

          actions: [
            Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 30,),
          ],
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text(tittle),
          backgroundColor: Maincolor
      ),*/
      body: WillPopScope(
        onWillPop: ()async{
          print(CommonUtils.NAVIGATE_PATH);
          Navigator.of(context).pop(true);
          SystemNavigator.pop();
          return false;
        },
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
         color: Maincolorr,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(flex:1,child: GestureDetector(
                onTap: (){

                  setState(() {
                    _selectedIndex=0;
                    tittle="Home";
                    homeActive=1;
                    receiptActive=0;
                    walletActive=0;
                    buyvocuherActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(homeActive, "assets/ic_home_over.png", "assets/ic_home.png"),
                      SizedBox(height: 2,),
                      setActiveTittle(homeActive, "Home"),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=1;
                    tittle="Receipt";
                    homeActive=0;
                    receiptActive=1;
                    walletActive=0;
                    buyvocuherActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(receiptActive, "assets/ic_receipt_over.png", "assets/ic_receipt_normal.png"),
                      SizedBox(height: 2,),
                      setActiveTittle(receiptActive, "Receipt"),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=2;
                    tittle="Wallet";
                    walletActive=1;
                    homeActive=0;
                    receiptActive=0;
                    buyvocuherActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(walletActive, "assets/ic_wallet_over.png", "assets/ic_wallet.png"),
                      SizedBox(height: 2,),
                      setActiveTittle(walletActive, "Wallet"),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=3;
                    tittle="Buy e-vouchers";
                    homeActive=0;
                    receiptActive=0;
                    buyvocuherActive=1;
                    walletActive=0;
                    moreActive=0;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          setActive(buyvocuherActive, "assets/ic_evoucher_over.png", "assets/ic_evoucher_normal.png"),
                          SizedBox(height: 2,),
                          setActiveTittle(buyvocuherActive, "Buy e-vouchers"),
                        ],
                      ),
                      // _InboxCount(context),
                    ],
                  ),
                ),
              )),
              Expanded(flex:1,child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedIndex=4;
                    tittle="More";
                    homeActive=0;
                    receiptActive=0;
                    walletActive=0;
                    buyvocuherActive=0;
                    moreActive=1;
                  });
                },
                child: Container(
                  width: 40,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      setActive(moreActive, "assets/ic_more_over.png", "assets/ic_more_normal.png"),
                      SizedBox(height: 2,),
                      setActiveTittle(moreActive, "More"),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
  Widget setActive(var active ,var activeIcon,var inactiveIcon){

    if (active==1){
      return Image.asset(activeIcon,height: 20,width: 20,);
    }
    else{
      return Image.asset(inactiveIcon,height: 20,width: 20,);
    }
  }
  Widget setActiveTittle(var active ,var tittle){

    if (active==1){


      return Text(tittle,style: TextStyle(fontSize: 10,color: Maincolor),);
    }
    else{
      return Text(tittle,style: TextStyle(fontSize: 10,color: GrayColor),);
    }
  }
  void changeToPage(String navigatePath){

    if(navigatePath==CommonUtils.walletPage){
      setState(() {
        _selectedIndex=2;
        tittle="Wallet";
        homeActive=0;
        receiptActive=0;
        walletActive=1;
        buyvocuherActive = 0;
        moreActive=0;
      });
    }

    else if(navigatePath==CommonUtils.buyVoucherPage){
      setState(() {
        _selectedIndex=3;
        tittle="Buy Voucher";
        homeActive=0;
        receiptActive=0;
        walletActive=0;
        buyvocuherActive = 1;
        moreActive=0;
      });
    }

    else if(navigatePath == CommonUtils.rewardsPage) {
      setState(() {
        _selectedIndex=2;
        tittle="Rewards";
        homeActive=0;
        receiptActive=1;
        walletActive=0;
        buyvocuherActive = 0;
        moreActive=0;
      });

    }
    else if(navigatePath==CommonUtils.inboxPage){

      setState(() {
        _selectedIndex=4;
        tittle="More";
        homeActive=0;
        receiptActive=0;
        walletActive=0;
        buyvocuherActive = 0;
        moreActive=1;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  InboxFragment()));
        });
      });
    }
    else if(navigatePath==CommonUtils.KEY_FEEDBACK_POINT_TRANSACTION){
      showRewardsDeliveryDialog(context,CommonUtils.PPN_RESPONSE_CONTENT);
    }
    else if(navigatePath==CommonUtils.KEY_MEMBER_POINT_TRANSACTION){
      showRewardsDeliveryDialog(context,CommonUtils.PPN_RESPONSE_CONTENT);
    }
    else if(navigatePath==CommonUtils.none){

    }

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
  }

void navigateToInboxDetailsPage(var moreData){

  if(moreData!="0"){
    CommonUtils.msgid=moreData;
    Navigator.push(context, MaterialPageRoute(builder: (context) => InboxDetailsIOS(),));
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

    if(jsonDecode(response.body)["Status"]=="True")
    {


      var posts1=json.decode(response.body)['Data']['message overall'].toString();
      print("InboxCount:"+posts1);
      return posts1;

    }
    else {

      throw "Unable to retrieve posts.";
    }
    //
  }
  FutureBuilder<String> _InboxCount(BuildContext context) {

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
}
